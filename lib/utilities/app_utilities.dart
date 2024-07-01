import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'dimensions.dart';
import 'fontsizes.dart';
import 'getStorage.dart';

String formatDate(DateTime pickedDate) {
  final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy');
  return formatter.format(pickedDate);
}

bool checkEmail(String text) {
  final RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
  final RegExp consecutiveSpecialChars = RegExp(r"([.!_%-])\1");
  final parts = text.split('@').last;
  if (regex.hasMatch(text) && !consecutiveSpecialChars.hasMatch(text) && parts.length >= 7) {
    return true;
  } else {
    return false;
  }
}

void deleteLocalData() {
  deleteVerificationId();
}

void customSnackBar(BuildContext context, Color bgColor, Color textColor, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_16, vertical: Dimensions.PADDING_SIZE_24),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: FontSize.txtPop14_500.copyWith(color: textColor),
      )));
}

void customGetSnackBar(Color bgColor, Color textColor, String message, String head) {
  Get.snackbar(
    head,
    message,
    colorText: textColor,
    backgroundColor: bgColor,
    borderRadius: 12,
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING,
  );
}

// void flutterToast(Color bgColor, Color textColor, String message) {
//   try {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       // Adjust for iOS/Web if needed
//       backgroundColor: bgColor,
//       textColor: textColor,
//     );
//   } catch (e) {
//     debug(e);
//   }
// }
