import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';

sealed class HomeDoctorsEvent {
  const HomeDoctorsEvent();
}

class HomeDoctorsStarted extends HomeDoctorsEvent {
  const HomeDoctorsStarted();
}

enum HomeDoctorsStatus { initial, loading, success, empty, failure }

class HomeDoctorsState {
  const HomeDoctorsState({
    this.status = HomeDoctorsStatus.initial,
    this.doctors = const [],
    this.errorMessage,
  });

  final HomeDoctorsStatus status;
  final List<DoctorModel> doctors;
  final String? errorMessage;

  HomeDoctorsState copyWith({
    HomeDoctorsStatus? status,
    List<DoctorModel>? doctors,
    String? errorMessage,
  }) {
    return HomeDoctorsState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class HomeDoctorsBloc extends Bloc<HomeDoctorsEvent, HomeDoctorsState> {
  HomeDoctorsBloc({required DoctorsFirestoreService doctorsService})
      : _doctorsService = doctorsService,
        super(const HomeDoctorsState()) {
    on<HomeDoctorsStarted>(_onStarted);
  }

  final DoctorsFirestoreService _doctorsService;

  Future<void> _onStarted(
    HomeDoctorsStarted event,
    Emitter<HomeDoctorsState> emit,
  ) async {
    emit(state.copyWith(status: HomeDoctorsStatus.loading));
    await emit.forEach(
      _doctorsService.watchDoctors(),
      onData: (doctors) => state.copyWith(
        status: doctors.isEmpty
            ? HomeDoctorsStatus.empty
            : HomeDoctorsStatus.success,
        doctors: doctors,
        errorMessage: null,
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: HomeDoctorsStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }
}
