import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

enum DoctorsFindStatus {
  initial,
  loading,
  success,
  empty,
  failure,
}

class DoctorsFindState {
  const DoctorsFindState({
    this.status = DoctorsFindStatus.initial,
    this.doctors = const [],
    this.filteredDoctors = const [],
    this.searchText = '',
    this.errorMessage,
  });

  final DoctorsFindStatus status;

  final List<DoctorModel> doctors;

  final List<DoctorModel> filteredDoctors;

  final String searchText;

  final String? errorMessage;

  static const _noChange = Object();

  DoctorsFindState copyWith({
    DoctorsFindStatus? status,
    List<DoctorModel>? doctors,
    List<DoctorModel>? filteredDoctors,
    String? searchText,
    Object? errorMessage = _noChange,
  }) {
    return DoctorsFindState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      searchText: searchText ?? this.searchText,
      errorMessage: identical(errorMessage, _noChange)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}