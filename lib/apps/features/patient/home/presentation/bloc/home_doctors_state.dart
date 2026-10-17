import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

enum HomeDoctorsStatus { initial, loading, success, empty, failure }

class HomeDoctorsState {
  const HomeDoctorsState({
    this.status = HomeDoctorsStatus.initial,
    this.doctors = const [],
    this.errorMessage,
  });

  final HomeDoctorsStatus status;
  final List<DoctorModel> doctors;
  final String? errorMessage;

  HomeDoctorsState copyWith({
    HomeDoctorsStatus? status,
    List<DoctorModel>? doctors,
    String? errorMessage,
  }) {
    return HomeDoctorsState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
