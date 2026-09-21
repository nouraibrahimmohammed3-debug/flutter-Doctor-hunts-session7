import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

sealed class AdminDoctorsEvent {
  const AdminDoctorsEvent();
}

class AdminDoctorsStarted extends AdminDoctorsEvent {
  const AdminDoctorsStarted();
}

class AdminDoctorAdded extends AdminDoctorsEvent {
  const AdminDoctorAdded(this.doctor);
  final DoctorModel doctor;
}

class AdminDoctorUpdated extends AdminDoctorsEvent {
  const AdminDoctorUpdated(this.doctor);
  final DoctorModel doctor;
}

class AdminDoctorDeleted extends AdminDoctorsEvent {
  const AdminDoctorDeleted(this.doctorId);
  final String doctorId;
}

class AdminDoctorAvailabilityChanged extends AdminDoctorsEvent {
  const AdminDoctorAvailabilityChanged(this.doctorId, this.isAvailable);
  final String doctorId;
  final bool isAvailable;
}
