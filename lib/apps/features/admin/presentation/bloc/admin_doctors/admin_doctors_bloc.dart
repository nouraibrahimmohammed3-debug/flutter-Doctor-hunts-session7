import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'admin_doctors_event.dart';
import 'admin_doctors_state.dart';

class AdminDoctorsBloc extends Bloc<AdminDoctorsEvent, AdminDoctorsState> {
  AdminDoctorsBloc({required DoctorsFirestoreService doctorsService})
      : _doctorsService = doctorsService,
        super(const AdminDoctorsState()) {
    on<AdminDoctorsStarted>(_onStarted);
    on<AdminDoctorAdded>(_onDoctorAdded);
    on<AdminDoctorUpdated>(_onDoctorUpdated);
    on<AdminDoctorDeleted>(_onDoctorDeleted);
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
        errorMessage: error.toString(),
      ),
    );
  }

  Future<void> _onDoctorAdded(
    AdminDoctorAdded event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    emit(state.copyWith(action: AdminDoctorAction.adding, clearError: true));
    try {
      await _doctorsService.addDoctor(event.doctor);
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        successMessage: 'Doctor added successfully.',
        clearError: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        errorMessage: error.toString(),
        clearSuccess: true,
      ));
    }
  }

  Future<void> _onDoctorUpdated(
    AdminDoctorUpdated event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    emit(state.copyWith(
      action: AdminDoctorAction.updating,
      processingDoctorId: event.doctor.id,
      clearError: true,
    ));
    try {
      await _doctorsService.updateDoctor(event.doctor);
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        successMessage: 'Doctor updated successfully.',
        clearProcessingDoctor: true,
        clearError: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        errorMessage: error.toString(),
        clearProcessingDoctor: true,
        clearSuccess: true,
      ));
    }
  }

  Future<void> _onDoctorDeleted(
    AdminDoctorDeleted event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    emit(state.copyWith(
      action: AdminDoctorAction.deleting,
      processingDoctorId: event.doctorId,
      clearError: true,
    ));
    try {
      await _doctorsService.deleteDoctor(event.doctorId);
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        successMessage: 'Doctor deleted successfully.',
        clearProcessingDoctor: true,
        clearError: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        errorMessage: error.toString(),
        clearProcessingDoctor: true,
        clearSuccess: true,
      ));
    }
  }

  Future<void> _onAvailabilityChanged(
    AdminDoctorAvailabilityChanged event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    emit(state.copyWith(
      action: AdminDoctorAction.changingAvailability,
      processingDoctorId: event.doctorId,
      clearError: true,
    ));
    try {
      await _doctorsService.updateDoctorAvailability(
        event.doctorId,
        event.isAvailable,
      );
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        successMessage: 'Doctor availability updated.',
        clearProcessingDoctor: true,
        clearError: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        action: AdminDoctorAction.none,
        errorMessage: error.toString(),
        clearProcessingDoctor: true,
        clearSuccess: true,
      ));
    }
  }
}
