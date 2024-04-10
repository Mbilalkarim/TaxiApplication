import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxiapplication/utilities/extensions.dart';

import '../Model/profileModel.dart';
import '../Views/auth/loginView.dart';
import '../Views/auth/verifyOtpView.dart';
import '../Views/dashboaard/dashboardView.dart';
import '../Views/profile/ProfileEdit.dart';
import '../utilities/AppConstants.dart';
import '../utilities/app_utilities.dart';
import '../utilities/getStorage.dart';
import 'ProfileController.dart';
import 'authController/auth_service.dart';
import 'authController/controller/verifyOtpController.dart';
import 'authController/crudOperations/crudOperations.dart';
import 'get_di.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  var box = GetStorage();
  int remainingMinutes = 0;
  int remainingSeconds = 0;
  late Timer timer;
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );
  late Animation<double> animation = Tween(begin: 0.0, end: 1.0).animate(controller);

  @override
  void onInit() async {
    // Start the animation
    controller.forward();
    await mainInit();
    if (!checkHaData(AppConstants.LANGUAGE_CODE)) {
      storeLanguage("en");
    }

    UserModel userModel = await FirestoreServices().getUserData();
    storeUserData(userModel);
    // EmergencyPassModel emergencyPassModel = await FirestoreServices().getEmergencyPassData();
    // storeEmergencyPassData(emergencyPassModel);
    Future.delayed(
      const Duration(milliseconds: 2100),
      () async {
        bool checkOtp = await checkOtpTime();
        if (AuthService.firebase().currentUser?.id == null) {
          if (!checkOtp) {
            deleteLocalData();
            Get.myOffAll(const LoginView());
            return;
          } else {
            DateTime storedTime = DateTime.parse(await readOtpTime());
            DateTime now = DateTime.now();
            int differenceInSeconds = now.difference(storedTime).inSeconds;
            int remainingTimeInSeconds = 600 - differenceInSeconds;

            if (remainingTimeInSeconds > 0) {
              Get.put(VerifyOtpController());
              Get.find<VerifyOtpController>().timerCustom();
              Get.myOffAll(const VerifyOtpView());
              return;
            } else {
              deleteOtpTime();
              deleteQrCode();
              deleteUserData();
              deleteNewUser();
              deleteVerificationId();

              Get.myOffAll(const LoginView());
              return;
            }
          }
        } else {
          if (userModel.firstName == null) {
            Get.put(ProfileController());

            Get.find<ProfileController>().isSettings = false;
            Get.find<ProfileController>().update();
            Get.myOffAll(const ProfileEdit());
          } else {
            Get.myOffAll(const DashboardView());
            return;
          }

          return;
        }
      },
    );

    super.onInit();
  }
}
