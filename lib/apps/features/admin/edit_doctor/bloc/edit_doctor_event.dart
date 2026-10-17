import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

sealed class EditDoctorEvent {
  const EditDoctorEvent();
}

class EditDoctorSubmitted extends EditDoctorEvent {
  const EditDoctorSubmitted(this.doctor);

  final DoctorModel doctor;
}
