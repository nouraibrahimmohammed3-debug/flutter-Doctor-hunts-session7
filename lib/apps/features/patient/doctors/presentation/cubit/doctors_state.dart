import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

class DoctorsState {
  const DoctorsState({
    required this.doctors,
    required this.filteredDoctors,
    this.favoriteDoctorIds = const {},
    this.searchText = '',
  });

  final List<DoctorModel> doctors;
  final List<DoctorModel> filteredDoctors;
  final Set<String> favoriteDoctorIds;
  final String searchText;

  DoctorsState copyWith({
    List<DoctorModel>? filteredDoctors,
    Set<String>? favoriteDoctorIds,
    String? searchText,
  }) {
    return DoctorsState(
      doctors: doctors,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      favoriteDoctorIds: favoriteDoctorIds ?? this.favoriteDoctorIds,
      searchText: searchText ?? this.searchText,
    );
  }
}
