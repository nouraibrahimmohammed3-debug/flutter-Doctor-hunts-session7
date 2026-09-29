import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

sealed class DoctorsFindEvent {
  const DoctorsFindEvent();
}

class DoctorsFindStarted extends DoctorsFindEvent {
  const DoctorsFindStarted();
}

class DoctorsFindSearchChanged extends DoctorsFindEvent {
  const DoctorsFindSearchChanged(this.value);

  final String value;
}

class DoctorsFindDoctorsUpdated extends DoctorsFindEvent {
  const DoctorsFindDoctorsUpdated(this.doctors);

  final List<DoctorModel> doctors;
}

class DoctorsFindFailed extends DoctorsFindEvent {
  const DoctorsFindFailed(this.message);

  final String message;
}