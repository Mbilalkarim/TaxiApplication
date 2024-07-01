import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/Views/splashScreen/SplashScreenView.dart';
import 'package:taxiapplication/utilities/app_size.dart';
import 'package:taxiapplication/utilities/theme/light_theme.dart';

import 'Controller/settingController.dart';

Future<void> main() async {
  Get.put(SettingController());
  // await LocalNotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return GetMaterialApp(
      title: 'Emergency Pass Webapp',
      theme: light,
      locale: Get.find<SettingController>().appLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("de")],
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      home: SplashScreenView(),
    );
  }
}
