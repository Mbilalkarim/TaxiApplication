import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colorconstant.dart';
import '../dimensions.dart';
import '../fontsizes.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final double horizontal;
  final double vertical;
  final double radiusValue;
  final Color bgColor;
  final TextStyle style;
  final Color textColor;
  final Color borderColor;
  final bool isLoader;
  final String text;
  final bool hasIcon;
  final String icon;
  final FocusNode? focusNode;
  const CustomButton({
    super.key,
    required this.onTap,
    this.horizontal = 12,
    this.vertical = 12,
    this.radiusValue = 12,
    this.bgColor = AppColors.kPrimary,
    this.textColor = AppColors.kWhite,
    this.style = FontSize.txtPop16_600,
    this.isLoader = false,
    this.borderColor = AppColors.kPrimary,
    required this.text,
    this.hasIcon = false,
    this.icon = "",
    this.focusNode,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusNode: focusNode,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusValue),
            color: bgColor,
            border: Border.all(color: borderColor)),
        child: Center(
          child: isLoader
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(color: textColor, strokeWidth: 1),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasIcon) SvgPicture.asset(icon),
                    if (hasIcon) Dimensions.PADDING_SIZE_5.spaceX,
                    Text(
                      text,
                      style: style.copyWith(color: textColor),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
