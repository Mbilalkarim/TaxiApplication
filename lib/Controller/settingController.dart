import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utilities/getStorage.dart';

class SettingController extends GetxController {
  Locale? appLocale;
  bool isLoader = false;
  var box = GetStorage();
  String? languageCode;

  @override
  Future<void> onInit() async {
    await GetStorage.init();
    languageCode = await readLanguage();
    appLocale = Locale(languageCode!);

    super.onInit();
  }

  void changeLanguage(Locale type) async {
    storeLanguage(type.languageCode);
    languageCode = type.languageCode;
    Get.updateLocale(type);
    update();
  }
}
