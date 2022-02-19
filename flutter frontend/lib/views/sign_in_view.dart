import 'package:flutter/material.dart';
import 'package:flutter_laravel_crud_app/widgets/authentication_widget.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationWidget authenticationWidget = Get.put(AuthenticationWidget());
    return authenticationWidget.getAuthenticationWidget(true);
  }
}
