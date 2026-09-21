import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required Iterable<String> initialFavoriteIds})
    : super(
        FavoritesState(favoriteDoctorIds: Set.unmodifiable(initialFavoriteIds)),
      );

  void toggleFavorite(String doctorId) {
    final Set<String> updatedIds = Set<String>.from(state.favoriteDoctorIds);

    if (updatedIds.contains(doctorId)) {
      updatedIds.remove(doctorId);
    } else {
      updatedIds.add(doctorId);
    }

    emit(state.copyWith(favoriteDoctorIds: Set.unmodifiable(updatedIds)));
  }

  void search(String value) {
    emit(state.copyWith(searchText: value.trim().toLowerCase()));
  }

  bool isFavorite(String doctorId) {
    return state.favoriteDoctorIds.contains(doctorId);
  }
}
