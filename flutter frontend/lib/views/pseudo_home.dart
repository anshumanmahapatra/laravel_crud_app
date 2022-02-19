import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/home.dart';
import '../views/sign_in_view.dart';
import '../views/sign_up_view.dart';

import '../controller/controller.dart';

class AuthenticationView {
  PageView getPageView() {
    SignIn signIn = Get.put(const SignIn());
    SignUp signUp = Get.put(const SignUp());
    Controller controller = Get.put(Controller());
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.authenticationPageController,
      children: [
        signIn,
        signUp,
      ],
    );
  }
}

class PseudoHome extends StatelessWidget {
  const PseudoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    Home home = Get.put(const Home());
    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;
    return FutureBuilder<bool>(
        future: controller.isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return home;
            } else {
              return AuthenticationView().getPageView();
            }
          } else if (snapshot.hasError) {
            return SizedBox(
                height: height,
                width: width,
                child: Center(
                  child: Text(snapshot.error.toString()),
                ));
          } else {
            return SizedBox(
                height: height,
                width: width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }
}
