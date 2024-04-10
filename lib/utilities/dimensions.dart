import 'package:flutter/material.dart';

class Dimensions {
  static const double FONT_SIZE_8 = 8.0;
  static const double FONT_SIZE_10 = 10.0;
  static const double FONT_SIZE_12 = 12.0;
  static const double FONT_SIZE_14 = 14.0;
  static const double FONT_SIZE_16 = 16.0;
  static const double FONT_SIZE_18 = 18.0;
  static const double FONT_SIZE_20 = 20.0;
  static const double FONT_SIZE_24 = 24.0;
  static const double FONT_SIZE_28 = 28.0;

  static const double PADDING_SIZE_2 = 2.0;
  static const double PADDING_SIZE_4 = 4.0;
  static const double PADDING_SIZE_5 = 5.0;
  static const double PADDING_SIZE_8 = 8.0;
  static const double PADDING_SIZE_10 = 10.0;
  static const double PADDING_SIZE_12 = 12.0;
  static const double PADDING_SIZE_14 = 14.0;
  static const double PADDING_SIZE_16 = 16.0;
  static const double PADDING_SIZE_20 = 20.0;
  static const double PADDING_SIZE_24 = 24.0;
  static const double PADDING_SIZE_27 = 27.0;
  static const double PADDING_SIZE_32 = 32.0;

  static const double RADIUS_SIZE_5 = 5.0;
  static const double RADIUS__SIZE_8 = 8.0;
  static const double RADIUS_SIZE_10 = 10.0;
  static const double RADIUS_SIZE_12 = 12.0;
  static const double RADIUS_SIZE_16 = 16.0;
  static const double RADIUS_SIZE_20 = 20.0;
}

extension SpaceXY on double {
  SizedBox get spaceX => SizedBox(
        width: this,
      );
  SizedBox get spaceY => SizedBox(
        height: this,
      );
}
