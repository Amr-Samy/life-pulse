import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/presentation/resources/helpers/storage.dart';

import 'app/app.dart';
import 'core/firebase_notifications/firebase.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseFcm.setUp();
  await GetStorage.init();
  final storage = GetStorage();
  debugPrint(storage.read("deviceToken"));
  await TokenStorage.initializeCache();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Future.delayed(const Duration(milliseconds: 150));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp( DevicePreview(
    // enabled: !kReleaseMode,
    enabled: false,
    builder: (BuildContext context) => MyApp(),
  )
  );
}
