import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

Future<void> mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await AuthService.firebase().initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize native android notification
}
