import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/doctor_model.dart';
import 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit(List<DoctorModel> doctors)
      : super(
          DoctorsState(
            doctors: List.unmodifiable(doctors),
            filteredDoctors: List.unmodifiable(doctors),
          ),
        );

  void search(String value) {
    final query = value.trim().toLowerCase();
    final result = query.isEmpty
        ? state.doctors
        : state.doctors.where((doctor) {
            return doctor.name.toLowerCase().contains(query) ||
                doctor.specialization.toLowerCase().contains(query);
          }).toList();

    emit(state.copyWith(searchText: value, filteredDoctors: result));
  }

  void toggleFavorite(String doctorId) {
    final favorites = Set<String>.from(state.favoriteDoctorIds);
    favorites.contains(doctorId)
        ? favorites.remove(doctorId)
        : favorites.add(doctorId);
    emit(state.copyWith(favoriteDoctorIds: Set.unmodifiable(favorites)));
  }
}
