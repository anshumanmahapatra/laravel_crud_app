import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/controller.dart';

class CustomTextField {
  double height = Get.mediaQuery.size.height;
  double width = Get.mediaQuery.size.width;

  Controller controller = Get.put(Controller());
  Container getCustomTextField(int id, String hintText) {
    return Container(
      height: height * 0.05,
      width: width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        onSaved: (val) {
          controller.saveAuthField(id, val!);
        },
        validator: (value) {
          if (id == 1) {
            if (value == null || value.isEmpty) {
              return 'Please provide a name';
            }
            return null;
          } else if (id == 2) {
            if (value == null || value.isEmpty) {
              return 'Please provide a valid email';
            }
            return null;
          } else if (id == 3) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            }
            return null;
          } else {
            if (value == null || value.isEmpty) {
              return 'Please confirm password';
            }
            return null;
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue.shade800),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue.shade800),
          ),
        ),
      ),
    );
  }
}
