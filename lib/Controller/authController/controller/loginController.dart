import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  String countryName = "", countryCode = "+92";
  bool boPass = false, boCnfPass = false, boCurrentPass = false;
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  FocusNode phoneFocus = FocusNode();
  TextEditingController txtPhoneNumb = TextEditingController();
  TextEditingController txtPhoneCode = TextEditingController();
  bool isLoader = false;
  List<String> oldNumber = [];
  final List<TextEditingController> textControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;
  @override
  void onInit() {
    txtPhoneCode.text = "+92";
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1.0), // Starting position above the screen
      end: Offset.zero, // Ending position at the top of the screen
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn, // Simulating a drop-down motion
    ));

    // Start the animation
    Future.delayed(
      Duration(seconds: 1),
      () {
        controller.forward();
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
