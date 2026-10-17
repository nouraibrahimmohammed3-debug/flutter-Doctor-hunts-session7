import 'package:doctor_hunt/generated/strings.g.dart';

abstract final class DoctorSpecialty {
  static const ids = [
    'dental',
    'cardiology',
    'ophthalmology',
    'general_medicine',
  ];
  static String id(String value) => switch (value.trim().toLowerCase()) {
    'dental' || 'dentist' || 'dentistry' || 'أسنان' || 'طب الأسنان' => 'dental',
    'cardiology' || 'cardiologist' || 'أمراض القلب' => 'cardiology',
    'ophthalmology' || 'العيون' => 'ophthalmology',
    'general' ||
    'general medicine' ||
    'general_medicine' ||
    'طب عام' => 'general_medicine',
    'orthopedics' || 'orthopedic' || 'orthopedist' || 'العظام' => 'orthopedics',
    'dermatology' || 'dermatologist' || 'الجلدية' => 'dermatology',
    'pediatrics' || 'pediatrician' || 'طب الأطفال' => 'pediatrics',
    'pathology' || 'pathologist' || 'علم الأمراض' => 'pathology',
    'oncology' || 'cancer' || 'الأورام' => 'oncology',
    _ => value.trim(),
  };
  static String label(String value) {
    var appStrings = t;
    return switch (id(value)) {
      'dental' => appStrings.dental,
      'cardiology' => appStrings.cardiology,
      'ophthalmology' => appStrings.ophthalmology,
      'general_medicine' => appStrings.generalMedicine,
      'orthopedics' => appStrings.commonUi.specialtyOrthopedics,
      'dermatology' => appStrings.commonUi.specialtyDermatology,
      'pediatrics' => appStrings.commonUi.specialtyPediatrics,
      'pathology' => appStrings.commonUi.specialtyPathology,
      'oncology' => appStrings.commonUi.specialtyOncology,
      _ => value,
    };
  }

  static bool matches(String left, String right) =>
      id(left).toLowerCase() == id(right).toLowerCase();
}
