import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

sealed class AddDoctorEvent {
  const AddDoctorEvent();
}

class AddDoctorSubmitted extends AddDoctorEvent {
  const AddDoctorSubmitted(this.doctor);

  final DoctorModel doctor;
}