import 'package:flutter/material.dart';

import '../colorconstant.dart';

ThemeData light = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: AppColors.kPrimary,
  secondaryHeaderColor: AppColors.kPrimary,
  disabledColor: const Color(0xFFA0A4A8),
  brightness: Brightness.light,
  hintColor: AppColors.kGrey,
  cardColor: AppColors.kWhite,
  textButtonTheme:
      TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.kPrimary)),
  colorScheme: const ColorScheme.light(primary: AppColors.kPrimary, secondary: AppColors.kPrimary)
      .copyWith(error: const Color(0xFFE84D4F)),
);
