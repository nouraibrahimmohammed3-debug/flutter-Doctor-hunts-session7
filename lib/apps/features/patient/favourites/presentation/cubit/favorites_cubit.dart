import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/favorites_firestore_service.dart';
import '../../../../shared/doctors/data/models/doctor_model.dart';
import '../../../../shared/doctors/data/services/doctors_firestore_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required DoctorsFirestoreService doctorsService,
    required FavoritesFirestoreService favoritesService,
    required String? userId,
  }) : _doctorsService = doctorsService,
       _favoritesService = favoritesService,
       _userId = userId,
       super(const FavoritesState());
  final DoctorsFirestoreService _doctorsService;
  final FavoritesFirestoreService _favoritesService;
  final String? _userId;
  StreamSubscription<List<DoctorModel>>? _doctorsSubscription;
  StreamSubscription<Set<String>>? _favoritesSubscription;
  bool _doctorsLoaded = false;
  bool _favoritesLoaded = false;
  void start() {
    if (_doctorsSubscription != null || _userId == null) return;
    emit(state.copyWith(status: FavoritesStatus.loading));
    _doctorsSubscription = _doctorsService.watchDoctors().listen((doctors) {
      _doctorsLoaded = true;
      emit(state.copyWith(doctors: List.unmodifiable(doctors)));
      _updateStatus();
    }, onError: _onError);
    _favoritesSubscription = _favoritesService.watchFavorites(_userId).listen((
      ids,
    ) {
      _favoritesLoaded = true;
      emit(state.copyWith(favoriteDoctorIds: Set.unmodifiable(ids)));
      _updateStatus();
    }, onError: _onError);
  }

  void _updateStatus() {
    if (!_doctorsLoaded || !_favoritesLoaded) return;
    emit(state.copyWith(status: FavoritesStatus.success));
  }

  void _onError(Object error) => emit(
    state.copyWith(
      status: FavoritesStatus.failure,
      errorMessage: localizedError(error),
    ),
  );
  Future<void> toggleFavorite(String doctorId) async {
    if (_userId == null ||
        !_favoritesLoaded ||
        state.pendingDoctorIds.contains(doctorId)) {
      return;
    }
    final favorite = !isFavorite(doctorId);
    emit(
      state.copyWith(pendingDoctorIds: {...state.pendingDoctorIds, doctorId}),
    );
    try {
      await _favoritesService.setFavorite(_userId, doctorId, favorite);
    } catch (error) {
      if (!isClosed) emit(state.copyWith(errorMessage: localizedError(error)));
    } finally {
      if (!isClosed) {
        emit(
          state.copyWith(
            pendingDoctorIds: {...state.pendingDoctorIds}..remove(doctorId),
            errorMessage: state.errorMessage,
          ),
        );
      }
    }
  }

  void search(String value) => emit(state.copyWith(searchText: value));
  bool isFavorite(String doctorId) =>
      state.favoriteDoctorIds.contains(doctorId);
  @override
  Future<void> close() async {
    await _doctorsSubscription?.cancel();
    await _favoritesSubscription?.cancel();
    return super.close();
  }
}
