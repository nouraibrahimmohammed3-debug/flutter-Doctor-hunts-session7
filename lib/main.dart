import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apps/core/di/injection_container.dart';
import 'apps/main/doctor_hunt_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final sharedPreferences = await SharedPreferences.getInstance();

  setupDependencies(sharedPreferences: sharedPreferences);

  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const DoctorHuntApp()));
}
