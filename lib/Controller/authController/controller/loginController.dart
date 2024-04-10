import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/Controller/authController/controller/verifyOtpController.dart';
import 'package:taxiapplication/utilities/extensions.dart';

import '../../../Model/profileModel.dart';
import '../../../Model/responseModel.dart';
import '../../../Views/auth/verifyOtpView.dart';
import '../../../utilities/app_utilities.dart';
import '../../../utilities/colorconstant.dart';
import '../../../utilities/debug.dart';
import '../../../utilities/getStorage.dart';
import '../auth_service.dart';
import '../crudOperations/crudOperations.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  String countryName = "", countryCode = "+92";
  AuthService authService = AuthService.firebase();
  bool boPass = false, boCnfPass = false, boCurrentPass = false;
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  FocusNode phoneFocus = FocusNode();
  TextEditingController txtPhoneNumb = TextEditingController();
  TextEditingController txtPhoneCode = TextEditingController();
  FirestoreServices firestoreServices = FirestoreServices();
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

  Future<void> getUserData() async {
    try {
      UserModel userModel = await readUserData();
      debug(userModel.userId);
      if (userModel.userId == null || userModel.userId == "") {
        debug("we are in if");
        userModel = await FirestoreServices().getUserData();
        storeUserData(userModel);
      }
    } catch (e) {
      debug(e);
    }
  }

  Future<void> deleteAccountOtp(BuildContext context) async {
    try {
      isLoader = true;
      update();
      ResponseModel response;
      if (!kIsWeb) {
        response = await AuthService.firebase()
            .createUserOtp(phoneNumber: AuthService.firebase().currentUser!.phone!);
      } else {
        response = await AuthService.firebase()
            .createUserOtpWeb(phoneNumber: AuthService.firebase().currentUser!.phone!);
      }
      if (response.isSuccess) {
        customSnackBar(context, AppColors.kGreen, AppColors.kWhite, 'OTP Sent successful');
        isLoader = false;
        update();
        Get.put(VerifyOtpController());
        Get.find<VerifyOtpController>().isDelete = true;
        Get.myGetTo(const VerifyOtpView());
      } else {
        customSnackBar(context, AppColors.kGreen, AppColors.kWhite, response.message);
      }
    } catch (e) {
      debug(e);
    }
  }

  Future<void> createUserOtp(BuildContext context) async {
    try {
      isLoader = true;
      update();
      debug("${txtPhoneCode.text} ${txtPhoneNumb.text}");
      ResponseModel responseModel;
      if (kIsWeb) {
        responseModel = await authService.createUserOtpWeb(
            phoneNumber: "${txtPhoneCode.text}${txtPhoneNumb.text}");
      } else {
        responseModel = await authService.createUserOtp(
            phoneNumber: "${txtPhoneCode.text}${txtPhoneNumb.text}");
      }

      // debug(readVerificationId());
      if (responseModel.isSuccess) {
        customSnackBar(context, AppColors.kGreen, AppColors.kWhite, 'OTP Sent successful');
        Get.put(VerifyOtpController());
        Get.find<VerifyOtpController>().timerCustom();
        Get.find<VerifyOtpController>().isDelete = false;
        Get.find<VerifyOtpController>().phoneNo = "${txtPhoneCode.text}${txtPhoneNumb.text}";

        Get.myGetTo(const VerifyOtpView());
      }
      isLoader = false;
      update();
    } on FirebaseAuthException {
      isLoader = false;
      update();
    } catch (e) {
      isLoader = false;
      update();
      debug(e);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
