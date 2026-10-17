import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';

import 'edit_doctor_event.dart';
import 'edit_doctor_state.dart';

class EditDoctorBloc extends Bloc<EditDoctorEvent, EditDoctorState> {
  EditDoctorBloc({required DoctorsFirestoreService doctorsService})
    : _doctorsService = doctorsService,
      super(const EditDoctorState()) {
    on<EditDoctorSubmitted>(_onSubmitted);
  }

  final DoctorsFirestoreService _doctorsService;

  Future<void> _onSubmitted(
    EditDoctorSubmitted event,
    Emitter<EditDoctorState> emit,
  ) async {
    var appStrings = t;
    emit(
      state.copyWith(
        status: EditDoctorStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      await _doctorsService.updateDoctor(event.doctor);

      emit(
        state.copyWith(
          status: EditDoctorStatus.success,
          successMessage: appStrings.commonUi.doctorUpdated,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: EditDoctorStatus.failure,
          errorMessage: localizedError(error),
          clearSuccess: true,
        ),
      );
    }
  }
}
