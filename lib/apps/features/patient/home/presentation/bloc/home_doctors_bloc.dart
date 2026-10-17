import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_event.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';

class HomeDoctorsBloc extends Bloc<HomeDoctorsEvent, HomeDoctorsState> {
  HomeDoctorsBloc({required this.doctorsService})
    : super(const HomeDoctorsState()) {
    on<HomeDoctorsStarted>(_onStarted);
  }

  final DoctorsFirestoreService doctorsService;

  Future<void> _onStarted(
    HomeDoctorsStarted event,
    Emitter<HomeDoctorsState> emit,
  ) async {
    emit(state.copyWith(status: HomeDoctorsStatus.loading));

    await emit.forEach<List<DoctorModel>>(
      doctorsService.watchDoctors(),
      onData: (doctors) => state.copyWith(
        status: doctors.isEmpty
            ? HomeDoctorsStatus.empty
            : HomeDoctorsStatus.success,
        doctors: doctors,
        errorMessage: null,
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: HomeDoctorsStatus.failure,
        errorMessage: localizedError(error),
      ),
    );
  }
}
