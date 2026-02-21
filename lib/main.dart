import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature/app/app.dart';
import 'package:device_preview/device_preview.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // Wrapping our app in DevicePreview
    DevicePreview(
      enabled: false, // Enable only in development mode
      builder: (context) => const Application(),
    ),
  );
}
