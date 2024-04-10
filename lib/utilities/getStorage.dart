import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../Model/profileModel.dart';
import 'AppConstants.dart';
import 'debug.dart';

final box = GetStorage();

bool checkHaData(String id) {
  try {
    return box.hasData(id);
  } catch (e) {
    debug(e);
    return false;
  }
}

Future<void> storeVerificationId(String id) async {
  try {
    await box.write(AppConstants.VERIFICATION_ID, id);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteVerificationId() async {
  try {
    if (checkHaData(AppConstants.VERIFICATION_ID)) {
      await box.remove(AppConstants.VERIFICATION_ID);
    }
  } catch (e) {
    debug(e);
  }
}

Future<String> readVerificationId() async {
  try {
    if (checkHaData(AppConstants.VERIFICATION_ID)) {
      return await box.read(AppConstants.VERIFICATION_ID);
    } else {
      return "";
    }
  } catch (e) {
    debug(e);
    return "";
  }
}

Future<void> storeLanguage(String id) async {
  try {
    await box.write(AppConstants.LANGUAGE_CODE, id);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteLanguage() async {
  try {
    if (checkHaData(AppConstants.LANGUAGE_CODE)) {
      await box.remove(AppConstants.LANGUAGE_CODE);
    }
  } catch (e) {
    debug(e);
  }
}

Future<String> readLanguage() async {
  try {
    if (checkHaData(AppConstants.LANGUAGE_CODE)) {
      return await box.read(AppConstants.LANGUAGE_CODE);
    } else {
      return "en";
    }
  } catch (e) {
    debug(e);
    return "en";
  }
}

Future<void> storeOnboarding(bool id) async {
  try {
    await box.write(AppConstants.ONBOARDING, id);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteOnboarding() async {
  try {
    if (checkHaData(AppConstants.ONBOARDING)) {
      await box.remove(AppConstants.ONBOARDING);
    }
  } catch (e) {
    debug(e);
  }
}

Future<bool> readOnboarding() async {
  try {
    if (checkHaData(AppConstants.ONBOARDING)) {
      return await box.read(AppConstants.ONBOARDING);
    } else {
      return false;
    }
  } catch (e) {
    debug(e);
    return false;
  }
}

Future<bool> checkOtpTime() async {
  try {
    return box.hasData(AppConstants.START_TIME_KEY);
  } catch (e) {
    debug(e);
    return false;
  }
}

Future<void> storeOtpTime(String value) async {
  try {
    await box.write(AppConstants.START_TIME_KEY, value);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteOtpTime() async {
  try {
    if (checkHaData(AppConstants.START_TIME_KEY)) {
      await box.remove(AppConstants.START_TIME_KEY);
    }
  } catch (e) {
    debug(e);
  }
}

Future<String> readOtpTime() async {
  try {
    if (checkHaData(AppConstants.START_TIME_KEY)) {
      return await box.read(AppConstants.START_TIME_KEY);
    } else {
      return "";
    }
  } catch (e) {
    debug(e);
    return "";
  }
}

Future<void> storeIsNewUser(bool value) async {
  try {
    await box.write(AppConstants.IS_NEW_USER, value);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteNewUser() async {
  try {
    if (checkHaData(AppConstants.IS_NEW_USER)) {
      await box.remove(AppConstants.IS_NEW_USER);
    }
  } catch (e) {
    debug(e);
  }
}

Future<bool> readNewUser() async {
  try {
    if (checkHaData(AppConstants.IS_NEW_USER)) {
      return await box.read(AppConstants.IS_NEW_USER);
    } else {
      return false;
    }
  } catch (e) {
    debug(e);
    return false;
  }
}

Future<bool> readQrCode() async {
  try {
    if (checkHaData(AppConstants.QR_CODE)) {
      return await box.read(AppConstants.QR_CODE);
    } else {
      return false;
    }
  } catch (e) {
    debug(e);
    return false;
  }
}

Future<void> storeQrCode(bool qrCode) async {
  try {
    await box.write(AppConstants.QR_CODE, qrCode);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteQrCode() async {
  try {
    if (checkHaData(AppConstants.QR_CODE)) {
      await box.remove(AppConstants.QR_CODE);
    }
  } catch (e) {
    debug(e);
  }
}

Future<void> storeUserData(UserModel user) async {
  try {
    final data = jsonEncode(user);
    await box.write(AppConstants.USER_DATA, data);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteUserData() async {
  try {
    if (checkHaData(AppConstants.USER_DATA)) {
      await box.remove(AppConstants.USER_DATA);
    }
  } catch (e) {
    debug(e);
  }
}

Future<UserModel> readUserData() async {
  try {
    if (checkHaData(AppConstants.USER_DATA)) {
      final userData = await box.read(AppConstants.USER_DATA);
      return UserModel.fromJson(jsonDecode(userData));
    } else {
      return UserModel();
    }
  } catch (e) {
    debug(e);
    return UserModel();
  }
}
