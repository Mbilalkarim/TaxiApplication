import 'package:flutter/material.dart';

import '../colorconstant.dart';
import '../dimensions.dart';

Widget dividerWidget({SizedBox? height}) {
  return Column(
    children: [
      height ?? Dimensions.PADDING_SIZE_5.spaceY,
      Divider(
        height: 10,
        color: AppColors.kGrey.withOpacity(0.4),
      ),
      height ?? Dimensions.PADDING_SIZE_5.spaceY,
    ],
  );
}
