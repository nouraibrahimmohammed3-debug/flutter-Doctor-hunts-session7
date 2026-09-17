import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../doctors/data/models/doctor_model.dart';
import '../../../../doctors/data/services/doctors_firestore_service.dart';
import 'create_doctor_state.dart';

class CreateDoctorCubit
    extends Cubit<CreateDoctorState> {
  CreateDoctorCubit({
    required DoctorsFirestoreService doctorsService,
  })  : _doctorsService = doctorsService,
        super(const CreateDoctorState());

  final DoctorsFirestoreService _doctorsService;
  Future<void> createDoctor({
  required String name,
  required String specialization,
  required String imagePath,
}) async {
  emit(
    state.copyWith(
      status: CreateDoctorStatus.loading,
    ),
  );

  try {
    final doctor = DoctorModel(
      id: '',
      name: name.trim(),
      specialization: specialization,
      imagePath: imagePath,
      rating: 0,
      experience: 0,
      patientStories: 0,
      price: 0,
      isAvailable: true,
    );

    await _doctorsService.addDoctor(doctor);

    emit(
      state.copyWith(
        status: CreateDoctorStatus.success,
      ),
    );
  } catch (error) {
    emit(
      state.copyWith(
        status: CreateDoctorStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }
}
}