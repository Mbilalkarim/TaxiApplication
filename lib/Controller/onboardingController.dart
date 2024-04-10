import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/colorconstant.dart';

class OnboardingController extends GetxController {
  int initialPage = 0;
  bool isLoader = false;
  late final PageController pageController = PageController(initialPage: 0);
  //
  // void changePage() {
  //   initialPage++;
  //   pageController.jumpToPage(initialPage);
  //   update();
  // }
  void changePage() {
    initialPage++;
    if (initialPage < 3) {
      pageController.animateToPage(
        initialPage,
        duration: const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the curve as needed
      );
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  List<Widget> buildDots() {
    return List.generate(3, (index) {
      return Container(
        width: initialPage == index ? 20 : 8.0,
        height: initialPage == index ? 8 : 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: initialPage == index ? AppColors.kPrimary : Colors.grey,
        ),
      );
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
