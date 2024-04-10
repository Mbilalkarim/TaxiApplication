import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colorconstant.dart';
import '../dimensions.dart';
import '../fontsizes.dart';

class CustomTextField extends StatelessWidget {
  final double vertical;
  final double isPassBorder;
  final bool obscureText;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final bool enabled;
  final bool autoCorrect;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final InputCounterWidgetBuilder? buildCounter;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? hintText;
  final bool isSearch;
  final double horizontal;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool isPass;
  final EdgeInsetsGeometry? contentPadding;
  final bool isDense;
  final TextCapitalization? textCapitalization;

  const CustomTextField(
      {super.key,
      this.vertical = 8,
      this.isPassBorder = 0,
      this.obscureText = false,
      this.onTap,
      this.maxLines = 1,
      this.maxLength,
      this.textAlign = TextAlign.start,
      this.controller,
      this.enabled = true,
      this.readOnly = false,
      this.buildCounter,
      this.focusNode,
      this.keyboardType,
      this.validator,
      this.onFieldSubmitted,
      this.autoCorrect = false,
      this.minLines,
      this.onChanged,
      this.onEditingComplete,
      this.inputFormatters,
      this.textInputAction,
      this.suffixIcon,
      this.suffix,
      this.prefix,
      this.prefixIcon,
      this.hintText,
      this.isSearch = false,
      this.textAlignVertical,
      this.style,
      this.hintStyle,
      this.contentPadding,
      this.isPass = false,
      this.isDense = false,
      this.textCapitalization,
      this.horizontal = Dimensions.PADDING_SIZE_12});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        textAlignVertical: textAlignVertical,
        onTap: onTap,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        textAlign: textAlign,
        controller: controller,
        enabled: enabled,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        buildCounter: buildCounter,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization ?? TextCapitalization.words,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        autocorrect: autoCorrect,
        minLines: minLines,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        textInputAction: textInputAction,
        style: style ??
            FontSize.txtPop16_400.copyWith(
              color: AppColors.kBlack.withOpacity(0.8),
            ),
        decoration: InputDecoration(
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: vertical,
              ),
          border: InputBorder.none,
          isDense: isDense,
          suffix: suffix,
          hintStyle:
              hintStyle ?? FontSize.txtPop14_600.copyWith(color: AppColors.kGrey.withOpacity(0.5)),
          prefix: prefix, prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon: suffixIcon,

          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: AppColors.kGrey),
          ),

          focusedBorder: isPass
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(isPassBorder)),
                  borderSide: const BorderSide(width: 1, color: AppColors.kPrimary),
                )
              : isSearch
                  ? OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.kGrey.withOpacity(0.2),
                      ),
                    )
                  : const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(width: 1, color: AppColors.kPrimary),
                    ),
          //<--

          // hintStyle: ,
          enabledBorder: isPass
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(isPassBorder)),
                  borderSide: BorderSide(width: 1, color: AppColors.kGrey.withOpacity(0.5)),
                )
              : !isSearch
                  ? const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.kGrey,
                      ), //<-- SEE HERE
                    )
                  : null,
        ));
  }
}
