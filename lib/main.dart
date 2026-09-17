import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'apps/main/doctor_hunt_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const DoctorHuntApp()));
}
