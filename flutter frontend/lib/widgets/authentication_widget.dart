import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

import '../widgets/custom_text_field.dart';

class AuthenticationWidget {
  WillPopScope getAuthenticationWidget(bool isSignIn) {
    CustomTextField customTextField = Get.put(CustomTextField());

    Controller controller = Get.put(Controller());

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;

    DateTime timeBackPressed = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          Fluttertoast.showToast(msg: 'Press back again to exit', fontSize: 17);
          return false;
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return false;
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/main_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              SizedBox(
                height: height,
                width: width,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.15,
                left: width * 0.1,
                child: SizedBox(
                  width: width * 0.8,
                  child: const Text(
                    "Welcome to Flutter Laravel CRUD App!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.6,
                  maxChildSize: 0.6,
                  builder: (context, scrollController) {
                    return Container(
                      width: width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(
                                  isSignIn == true ? 'Sign in' : 'Sign Up',
                                  style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                SizedBox(
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        isSignIn == true
                                            ? Container()
                                            : customTextField
                                                .getCustomTextField(1, 'Name:'),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        customTextField.getCustomTextField(
                                            2, 'Email:'),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        customTextField.getCustomTextField(
                                            3, 'Password:'),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        isSignIn == true
                                            ? Container()
                                            : customTextField
                                                .getCustomTextField(
                                                    4, 'Confirm Password:'),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Obx(() {
                                  if (controller.errorCount.value > 0) {
                                    return Text(
                                      controller.error!,
                                      style: const TextStyle(color: Colors.red),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if (isSignIn == true) {
                                        controller.login();
                                      } else {
                                        controller.register();
                                      }
                                    }
                                  },
                                  child: Text(
                                    isSignIn == true ? "Sign in" : "Sign Up",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 40),
                                    primary: Colors.blue.shade800,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: isSignIn == true
                                        ? "Don't have an account? "
                                        : "Have an account? ",
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: isSignIn == true
                                            ? "Sign up"
                                            : "Sign in",
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            if (isSignIn) {
                                              controller
                                                  .changeAuthenticationPage(1);
                                            } else {
                                              controller
                                                  .changeAuthenticationPage(0);
                                            }
                                          },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
