import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

enum AdminDoctorsStatus { initial, loading, success, failure }

enum AdminDoctorAction {
  none,
  adding,
  updating,
  deleting,
  changingAvailability,
}

class AdminDoctorsState {
  const AdminDoctorsState({
    this.status = AdminDoctorsStatus.initial,
    this.action = AdminDoctorAction.none,
    this.doctors = const [],
    this.errorMessage,
    this.successMessage,
    this.processingDoctorId,
    this.searchText = '',
    this.specialty = '',
  });

  final AdminDoctorsStatus status;
  final AdminDoctorAction action;
  final List<DoctorModel> doctors;
  final String? errorMessage;
  final String? successMessage;
  final String? processingDoctorId;
  final String searchText;
  final String specialty;
  List<DoctorModel> get visibleDoctors => doctors
      .where(
        (doctor) =>
            (specialty.isEmpty ||
                DoctorSpecialty.matches(specialty, doctor.specialization)) &&
            doctor.name.toLowerCase().contains(searchText.trim().toLowerCase()),
      )
      .toList();

  AdminDoctorsState copyWith({
    AdminDoctorsStatus? status,
    AdminDoctorAction? action,
    List<DoctorModel>? doctors,
    String? errorMessage,
    String? successMessage,
    String? processingDoctorId,
    bool clearError = false,
    bool clearSuccess = false,
    bool clearProcessingDoctor = false,
    String? searchText,
    String? specialty,
  }) {
    return AdminDoctorsState(
      status: status ?? this.status,
      action: action ?? this.action,
      doctors: doctors ?? this.doctors,
      searchText: searchText ?? this.searchText,
      specialty: specialty ?? this.specialty,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
      processingDoctorId: clearProcessingDoctor
          ? null
          : (processingDoctorId ?? this.processingDoctorId),
    );
  }
}
