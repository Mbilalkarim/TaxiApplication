import 'package:flutter/material.dart';

import '../colorconstant.dart';

class CustomLinearProgressBar extends StatelessWidget {
  final int totalSteps;
  final int completedSteps;
  final double? height;
  final Color? color;

  const CustomLinearProgressBar({
    Key? key,
    required this.totalSteps,
    required this.completedSteps,
    this.height = 8,
    this.color = AppColors.kProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthFactor;
    if (completedSteps == totalSteps) {
      widthFactor = 1.0;
    } else {
      widthFactor = (completedSteps) / totalSteps;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.kLightestGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      curve: Curves.easeInOut, // Adjust curve as needed
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500), // Adjust duration as needed
            curve: Curves.easeInOut, // Adjust curve as needed
            width: MediaQuery.of(context).size.width * widthFactor,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
