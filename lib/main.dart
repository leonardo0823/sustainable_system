import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'utils/features_discoveries.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //La app solo se puede usar con la pantalla vertical
    SystemUiOverlay.bottom,
    SystemUiOverlay.top
  ]);

  await initPreferences();

  runApp(const MyApp());
}
