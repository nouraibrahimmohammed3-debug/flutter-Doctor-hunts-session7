import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'admin_doctors_event.dart';
import 'admin_doctors_state.dart';

class AdminDoctorsBloc extends Bloc<AdminDoctorsEvent, AdminDoctorsState> {
  AdminDoctorsBloc({required DoctorsFirestoreService doctorsService})
    : _doctorsService = doctorsService,
      super(const AdminDoctorsState()) {
    on<AdminDoctorsStarted>(_onStarted);
    on<AdminDoctorsFiltersChanged>(
      (event, emit) => emit(
        state.copyWith(
          searchText: event.searchText,
          specialty: event.specialty,
        ),
      ),
    );
    on<AdminDoctorAvailabilityChanged>(_onAvailabilityChanged);
  }

  final DoctorsFirestoreService _doctorsService;

  Future<void> _onStarted(
    AdminDoctorsStarted event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    emit(state.copyWith(status: AdminDoctorsStatus.loading, clearError: true));
    await emit.forEach(
      _doctorsService.watchDoctors(),
      onData: (doctors) => state.copyWith(
        status: AdminDoctorsStatus.success,
        doctors: doctors,
        clearError: true,
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: AdminDoctorsStatus.failure,
        errorMessage: localizedError(error),
      ),
    );
  }

  Future<void> _onAvailabilityChanged(
    AdminDoctorAvailabilityChanged event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    var appStrings = t;
    emit(
      state.copyWith(
        action: AdminDoctorAction.changingAvailability,
        processingDoctorId: event.doctorId,
        clearError: true,
      ),
    );
    try {
      await _doctorsService.updateDoctorAvailability(
        event.doctorId,
        event.isAvailable,
      );
      emit(
        state.copyWith(
          action: AdminDoctorAction.none,
          successMessage: appStrings.commonUi.availabilityUpdated,
          clearProcessingDoctor: true,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          action: AdminDoctorAction.none,
          errorMessage: localizedError(error),
          clearProcessingDoctor: true,
          clearSuccess: true,
        ),
      );
    }
  }
}
