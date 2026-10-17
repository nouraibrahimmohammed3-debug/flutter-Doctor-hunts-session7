import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'dart:async';

import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';

import 'doctors_find_event.dart';
import '../../../../shared/doctors/data/models/doctor_specialty.dart';

class DoctorsFindBloc extends Bloc<DoctorsFindEvent, DoctorsFindState> {
  DoctorsFindBloc({required DoctorsFirestoreService doctorsService})
    : _doctorsService = doctorsService,
      super(const DoctorsFindState()) {
    on<DoctorsFindStarted>(_onStarted);
    on<DoctorsFindDoctorsUpdated>(_onDoctorsUpdated);
    on<DoctorsFindSearchChanged>(_onSearchChanged);
    on<DoctorsFindFailed>(_onFailed);
    on<DoctorsFindFiltersChanged>(
      (event, emit) => emit(
        state.copyWith(
          specialty: event.specialty == null
              ? null
              : DoctorSpecialty.id(event.specialty!),
          sortBy: event.sortBy == null
              ? null
              : event.sortBy == 'rating'
              ? 'rating'
              : 'popular',
        ),
      ),
    );
  }

  final DoctorsFirestoreService _doctorsService;

  StreamSubscription<List<DoctorModel>>? _doctorsSubscription;

  Future<void> _onStarted(
    DoctorsFindStarted event,
    Emitter<DoctorsFindState> emit,
  ) async {
    if (_doctorsSubscription != null) {
      return;
    }

    emit(state.copyWith(status: DoctorsFindStatus.loading, errorMessage: null));

    _doctorsSubscription = _doctorsService.watchDoctors().listen(
      (doctors) {
        add(DoctorsFindDoctorsUpdated(doctors));
      },
      onError: (error) {
        add(DoctorsFindFailed(localizedError(error)));
      },
    );
  }

  void _onDoctorsUpdated(
    DoctorsFindDoctorsUpdated event,
    Emitter<DoctorsFindState> emit,
  ) {
    final filteredDoctors = _filterDoctors(event.doctors, state.searchText);

    emit(
      state.copyWith(
        status: event.doctors.isEmpty
            ? DoctorsFindStatus.empty
            : DoctorsFindStatus.success,
        doctors: List.unmodifiable(event.doctors),
        filteredDoctors: List.unmodifiable(filteredDoctors),
        errorMessage: null,
      ),
    );
  }

  void _onSearchChanged(
    DoctorsFindSearchChanged event,
    Emitter<DoctorsFindState> emit,
  ) {
    final filteredDoctors = _filterDoctors(state.doctors, event.value);

    emit(
      state.copyWith(
        searchText: event.value,
        filteredDoctors: List.unmodifiable(filteredDoctors),
      ),
    );
  }

  void _onFailed(DoctorsFindFailed event, Emitter<DoctorsFindState> emit) {
    emit(
      state.copyWith(
        status: DoctorsFindStatus.failure,
        errorMessage: event.message,
      ),
    );
  }

  List<DoctorModel> _filterDoctors(List<DoctorModel> doctors, String value) {
    final query = value.trim().toLowerCase();

    if (query.isEmpty) {
      return doctors.where((doctor) => doctor.isAvailable).toList();
    }

    return doctors.where((doctor) {
      return doctor.isAvailable &&
          (doctor.name.toLowerCase().contains(query) ||
              doctor.specialization.toLowerCase().contains(query) ||
              doctor.specialtyLabel.toLowerCase().contains(query));
    }).toList();
  }

  @override
  Future<void> close() async {
    await _doctorsSubscription?.cancel();
    return super.close();
  }
}
