import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../Model/profileModel.dart';
import '../utilities/getStorage.dart';

class DashboardController extends GetxController with GetTickerProviderStateMixin {
  List<XFile> xFile = [];
  File? file;
  bool isLoading = false;
  UserModel userModel = UserModel();
  Uint8List? imageData, tempImageData;
  String updateDate = "";
  var image;
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  @override
  Future<void> onInit() async {
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
    Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        await getUserData();
      },
    );

    super.onInit();
  }

  Future<void> getUserData() async {
    userModel = await readUserData();

    update();
  }
}
