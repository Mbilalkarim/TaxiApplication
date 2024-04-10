import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colorconstant.dart';
import '../dimensions.dart';
import '../fontsizes.dart';
import 'customTextfield.dart';

class CustomInfoWidget extends StatelessWidget {
  final String heading;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoCorrect;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool isReadOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final TextCapitalization? textCapitalization;
  final bool isMandatory;
  const CustomInfoWidget({
    super.key,
    required this.heading,
    required this.hintText,
    this.inputFormatters,
    this.autoCorrect = false,
    this.keyboardType,
    required this.controller,
    this.isReadOnly = false,
    this.focusNode,
    this.textInputAction,
    this.onTap,
    this.onFieldSubmitted,
    this.textCapitalization,
    this.isMandatory = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: heading,
              style: FontSize.txtPop14_600.copyWith(color: AppColors.kBlack),
              children: [
                if (isMandatory)
                  TextSpan(
                      text: ' *', style: FontSize.txtPop14_600.copyWith(color: AppColors.kBlack)),
              ]),
          maxLines: 1,
          textAlign: TextAlign.right,
        ),
        CustomTextField(
          hintText: hintText,
          vertical: 8,
          onTap: onTap,
          horizontal: 0,
          readOnly: isReadOnly,
          inputFormatters: inputFormatters,
          autoCorrect: autoCorrect,
          keyboardType: keyboardType,
          controller: controller,
          isPass: true,
          isDense: true,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization,
        ),
        Dimensions.PADDING_SIZE_10.spaceY,
      ],
    );
  }
}
