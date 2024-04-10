import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'authController/auth_service.dart';

Future<void> mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().initialize();
  AuthService.firebase().logout();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
