import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxiapplication/utilities/extensions.dart';

import '../../../Model/profileModel.dart';
import '../../../Model/responseModel.dart';
import '../../../Views/auth/loginView.dart';
import '../../../Views/dashboaard/dashboardView.dart';
import '../../../Views/profile/ProfileEdit.dart';
import '../../../utilities/app_utilities.dart';
import '../../../utilities/colorconstant.dart';
import '../../../utilities/debug.dart';
import '../../../utilities/getStorage.dart';
import '../../ProfileController.dart';
import '../auth_service.dart';
import '../crudOperations/crudOperations.dart';

class VerifyOtpController extends GetxController with GetTickerProviderStateMixin {
  bool isDelete = false;
  late int remainingMinutes;
  late int remainingSeconds;
  var box = GetStorage();
  String? phoneNo;
  late Timer timer;
  bool isLoading = false;
  bool? isTimeShow;
  TextEditingController txtPhoneNumb = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  AuthService authService = AuthService.firebase();
  FirestoreServices firestoreServices = FirestoreServices();
  final List<TextEditingController> textControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  late AnimationController controller;
  late Animation<Offset> offsetAnimation;
  @override
  void onInit() {
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
    for (var e in textControllers) {
      e.clear();
    }
    super.onClose();
  }

  String combineTextFromControllers(List<TextEditingController> controllers) {
    String combinedText = '';
    for (TextEditingController controller in controllers) {
      combinedText += controller.text;
    }
    return combinedText;
  }

  Future<ResponseModel> deleteUser(BuildContext context) async {
    try {
      isLoading = true;
      update();
      await verifyOtp();

      ResponseModel response = await FirestoreServices().deleteAccount();

      await FirebaseAuth.instance.currentUser?.delete();
      await AuthService.firebase().logout();
      deleteLocalData();
      if (response.isSuccess) {
        customSnackBar(context, AppColors.kRed, AppColors.kWhite, "Account Deleted ");
        isLoading = false;
        update();
        for (var e in textControllers) {
          e.clear();
        }
        Get.myOffAll(const LoginView());
        return response;
      } else {
        isLoading = false;
        update();

        return ResponseModel(false, "Error Occurred ");
      }
    } catch (e) {
      customSnackBar(context, AppColors.kRed, AppColors.kWhite, "error Occurred ${e}");

      debug(e);
      return ResponseModel(false, "Error Occurred $e");
    }
  }

  Future<void> verifyOtp() async {
    String otpCode = combineTextFromControllers(textControllers);
    try {
      isLoading = true;
      update();
      ResponseModel responseModel;
      responseModel = await authService.verifyOtp(
        otpCode: otpCode,
        verificationId: await readVerificationId(),
      );

      if (!isDelete) {
        if (responseModel.isSuccess) {
          customGetSnackBar(
              AppColors.kGreen, AppColors.kWhite, "OTP verification successful", "Success");

          for (var e in textControllers) {
            e.clear();
          }
          deleteOtpTime();
          bool isNewUser = await readNewUser();
          if (isNewUser) {
            Get.put(ProfileController());
            Get.find<ProfileController>().isSettings = false;

            Get.find<ProfileController>().txtPhoneNumb.text =
                AuthService.firebase().currentUser?.phone ?? "";
            Get.find<ProfileController>().update();
            Get.myOffAll(const ProfileEdit());
          } else {
            UserModel userModel = await FirestoreServices().getUserData();
            storeUserData(userModel);
            if (userModel.firstName == null) {
              debug("we are here firstname");

              Get.put(ProfileController());

              Get.find<ProfileController>().isSettings = false;
              Get.find<ProfileController>().selectedValue = "Captain";
              Get.find<ProfileController>().txtPhoneNumb.text =
                  AuthService.firebase().currentUser?.phone ?? "";
              Get.find<ProfileController>().update();
              Get.myOffAll(const ProfileEdit());
            } else {
              Get.myOffAll(const DashboardView());
              return;
            }

            return;
          }
        }
      }

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      debug(e);
    }
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

  bool isAnyEmpty() {
    for (var controller in textControllers) {
      if (controller.text.isEmpty) {
        return true; // If any controller is empty, return true
      }
    }
    return false; // If no empty controller is found, return false
  }

  Future<void> timerCustom() async {
    try {
      bool isOtpTime = await checkOtpTime();
      if (isOtpTime) {
        DateTime storedTime = DateTime.parse(await readOtpTime());
        DateTime now = DateTime.now();
        int differenceInSeconds = now.difference(storedTime).inSeconds;
        int remainingTimeInSeconds = 600 - differenceInSeconds;

        if (remainingTimeInSeconds > 0) {
          remainingMinutes = remainingTimeInSeconds ~/ 60;
          remainingSeconds = remainingTimeInSeconds % 60;
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            isTimeShow = true;
            update(); // Timer is activated
            if (remainingSeconds > 0) {
              remainingSeconds -= 1;
            } else {
              remainingMinutes -= 1;
              remainingSeconds = 59;
            }
            if (remainingMinutes <= 0 && remainingSeconds <= 0) {
              timer.cancel();

              removeTimer();
              // Handle timeout
            }
            update();
          });
        } else {
          removeTimer();
        }
      } else {
        startFreshTimer();
      }
    } catch (e) {
      debug("e timer $e");
    }
  }

  void startFreshTimer() {
    storeStartTime();
    remainingMinutes = 10;
    remainingSeconds = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      isTimeShow = true;
      update(); // Timer is activated
      // Timer is activated
      if (remainingSeconds > 0) {
        remainingSeconds -= 1;
      } else {
        remainingMinutes -= 1;
        remainingSeconds = 59;
      }
      if (remainingMinutes <= 0 && remainingSeconds <= 0) {
        timer.cancel();
        removeTimer();
        // Handle timeout
      }
      update();
    });
  }

  Future<void> storeStartTime() async {
    storeOtpTime(DateTime.now().toString());
  }

  Future<void> removeTimer() async {
    isTimeShow = false; // Timer is canceled

    deleteOtpTime();
  }
}
