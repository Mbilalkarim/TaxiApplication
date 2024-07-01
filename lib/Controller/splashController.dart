import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxiapplication/utilities/extensions.dart';

import '../Views/auth/loginView.dart';
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

    // EmergencyPassModel emergencyPassModel = await FirestoreServices().getEmergencyPassData();
    // storeEmergencyPassData(emergencyPassModel);
    Future.delayed(
      const Duration(milliseconds: 2100),
      () async {
        Get.myGetTo(LoginView());
      },
    );

    super.onInit();
  }
}
