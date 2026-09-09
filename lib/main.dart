import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';

import 'apps/main/doctor_hunt_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const DoctorHuntApp()));
}
