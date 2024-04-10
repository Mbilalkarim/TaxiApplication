import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../colorconstant.dart';
import '../fontsizes.dart';

class SingleTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool readOnly;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final TextStyle style;
  final int? maxLength;

  const SingleTextField(
      {super.key,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      this.label,
      this.suffix,
      this.prefix,
      this.enabled = true,
      this.onEditingCompleted,
      this.hintText,
      this.onSubmitted,
      this.maxLength,
      this.onChanged,
      this.style = FontSize.txtPop12_500});

  @override
  Widget build(BuildContext context) {
    RxBool text = false.obs;
    return Obx(() {
      text.value = controller!.text.isEmpty;
      return Flexible(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLength: maxLength ?? 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            style: style,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: "",
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: !text.value ? AppColors.kPrimary : AppColors.kSilver,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
