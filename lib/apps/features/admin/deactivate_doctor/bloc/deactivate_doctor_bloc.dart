import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';

import 'deactivate_doctor_event.dart';
import 'deactivate_doctor_state.dart';

class DeactivateDoctorBloc
    extends Bloc<DeactivateDoctorEvent, DeactivateDoctorState> {
  DeactivateDoctorBloc({required this.repository})
    : super(const DeactivateDoctorState()) {
    on<DeactivateDoctorSubmitted>(_onDeactivateDoctorSubmitted);
  }

  final DoctorsFirestoreService repository;

  Future<void> _onDeactivateDoctorSubmitted(
    DeactivateDoctorSubmitted event,
    Emitter<DeactivateDoctorState> emit,
  ) async {
    emit(
      state.copyWith(
        successMessage: null,
        errorMessage: null,
        status: DeactivateDoctorStatus.loading,
        deactivatingDoctorId: event.doctorId,
      ),
    );

    try {
      await repository.deactivateDoctor(event.doctorId);

      emit(
        state.copyWith(
          status: DeactivateDoctorStatus.success,
          deactivatingDoctorId: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DeactivateDoctorStatus.failure,
          deactivatingDoctorId: null,
          errorMessage: localizedError(e),
        ),
      );
    }
  }
}
