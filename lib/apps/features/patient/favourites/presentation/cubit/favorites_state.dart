
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

enum FavoritesStatus {
  initial,
  loading,
  success,
  empty,
  failure,
}

class FavoritesState {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.doctors = const [],
    this.favoriteDoctorIds = const {},
    this.searchText = '',
    this.errorMessage,
  });

  final FavoritesStatus status;
  final List<DoctorModel> doctors;
  final Set<String> favoriteDoctorIds;
  final String searchText;
  final String? errorMessage;

  List<DoctorModel> get filteredDoctors {
    final query = searchText.trim().toLowerCase();

    return doctors.where((doctor) {
      final isFavorite = favoriteDoctorIds.contains(doctor.id);

      if (!isFavorite) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return doctor.name.toLowerCase().contains(query) ||
          doctor.specialization.toLowerCase().contains(query);
    }).toList();
  }

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<DoctorModel>? doctors,
    Set<String>? favoriteDoctorIds,
    String? searchText,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      favoriteDoctorIds:
          favoriteDoctorIds ?? this.favoriteDoctorIds,
      searchText: searchText ?? this.searchText,
      errorMessage: errorMessage,
    );
  }
}

