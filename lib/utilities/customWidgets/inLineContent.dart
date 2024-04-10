import 'package:flutter/material.dart';

import '../colorconstant.dart';
import '../dimensions.dart';
import '../fontsizes.dart';

Widget inLineContent(String heading, GestureTapCallback onTap, {TextStyle? style}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_12),
      padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 9,
                child: Text(
                  heading,
                  style: style ?? FontSize.txtPop14_800,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                ),
              ),
              const Flexible(
                flex: 1,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
              ),
            ],
          ),
          Dimensions.PADDING_SIZE_8.spaceY,
          Container(
            padding: EdgeInsets.zero,
            height: 1,
            color: AppColors.kGrey.withOpacity(0.5),
            width: double.infinity,
          ),
        ],
      ),
    ),
  );
}
