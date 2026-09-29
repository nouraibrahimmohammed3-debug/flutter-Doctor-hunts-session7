
import 'dart:async';

import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required DoctorsFirestoreService doctorsService,
    Iterable<String> initialFavoriteIds = const [],
  })  : _doctorsService = doctorsService,
        super(
          FavoritesState(
            favoriteDoctorIds: Set.unmodifiable(
              initialFavoriteIds,
            ),
          ),
        );

  final DoctorsFirestoreService _doctorsService;

  StreamSubscription<List<DoctorModel>>? _subscription;

  void start() {
    if (_subscription != null) {
      return;
    }

    emit(
      state.copyWith(
        status: FavoritesStatus.loading,
      ),
    );

    _subscription = _doctorsService.watchDoctors().listen(
      (doctors) {
        emit(
          state.copyWith(
            status: doctors.isEmpty
                ? FavoritesStatus.empty
                : FavoritesStatus.success,
            doctors: List.unmodifiable(doctors),
            errorMessage: null,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: FavoritesStatus.failure,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  void toggleFavorite(String doctorId) {
    final updatedIds = Set<String>.from(
      state.favoriteDoctorIds,
    );

    if (updatedIds.contains(doctorId)) {
      updatedIds.remove(doctorId);
    } else {
      updatedIds.add(doctorId);
    }

    emit(
      state.copyWith(
        favoriteDoctorIds: Set.unmodifiable(updatedIds),
      ),
    );
  }

  void search(String value) {
    emit(
      state.copyWith(
        searchText: value.trim().toLowerCase(),
      ),
    );
  }

  bool isFavorite(String doctorId) {
    return state.favoriteDoctorIds.contains(doctorId);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}

