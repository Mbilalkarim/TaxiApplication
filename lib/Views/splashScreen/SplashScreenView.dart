import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/splashController.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/images.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: AppColors.kPrimary, // Set your desired background color
            body: Center(
              child: FadeTransition(
                opacity: _.animation,
                child: ScaleTransition(
                    scale: _.animation,
                    child: Image.asset(
                      Images.taxiLogo_png,
                      width: 200,
                      height: 200,
                    )),
              ),
            ),
          );
        });
  }
}
