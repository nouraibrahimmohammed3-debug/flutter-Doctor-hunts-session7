import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';

import 'add_doctor_event.dart';
import 'add_doctor_state.dart';

class AddDoctorBloc extends Bloc<AddDoctorEvent, AddDoctorState> {
  AddDoctorBloc({
    required DoctorsFirestoreService doctorsService,
  })  : _doctorsService = doctorsService,
        super(const AddDoctorState()) {
    on<AddDoctorSubmitted>(_onSubmitted);
  }

  final DoctorsFirestoreService _doctorsService;

  Future<void> _onSubmitted(
    AddDoctorSubmitted event,
    Emitter<AddDoctorState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AddDoctorStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      await _doctorsService.addDoctor(event.doctor);

      emit(
        state.copyWith(
          status: AddDoctorStatus.success,
          successMessage:
              'Doctor added successfully.',
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AddDoctorStatus.failure,
          errorMessage: error.toString(),
          clearSuccess: true,
        ),
      );
    }
  }
}