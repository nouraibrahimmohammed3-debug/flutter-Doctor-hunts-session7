import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

enum DoctorsFindStatus { initial, loading, success, empty, failure }

class DoctorsFindState {
  const DoctorsFindState({
    this.status = DoctorsFindStatus.initial,
    this.doctors = const [],
    this.filteredDoctors = const [],
    this.searchText = '',
    this.errorMessage,
    this.specialty = '',
    this.sortBy = 'popular',
  });

  final DoctorsFindStatus status;

  final List<DoctorModel> doctors;

  final List<DoctorModel> filteredDoctors;

  final String searchText;

  final String? errorMessage;
  final String specialty;
  final String sortBy;
  List<DoctorModel> get visibleDoctors {
    final result = filteredDoctors
        .where(
          (doctor) =>
              specialty.isEmpty ||
              DoctorSpecialty.matches(doctor.specialization, specialty),
        )
        .toList();
    result.sort(
      (a, b) => sortBy == 'rating'
          ? b.rating.compareTo(a.rating)
          : b.patientStories.compareTo(a.patientStories),
    );
    return result;
  }

  static const _noChange = Object();

  DoctorsFindState copyWith({
    DoctorsFindStatus? status,
    List<DoctorModel>? doctors,
    List<DoctorModel>? filteredDoctors,
    String? searchText,
    Object? errorMessage = _noChange,
    String? specialty,
    String? sortBy,
  }) {
    return DoctorsFindState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      searchText: searchText ?? this.searchText,
      specialty: specialty ?? this.specialty,
      sortBy: sortBy ?? this.sortBy,
      errorMessage: identical(errorMessage, _noChange)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
