import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import '../../data/models/doctor_model.dart';
import '../../data/services/doctors_firestore_service.dart';

class DoctorLoadState {
  const DoctorLoadState({this.doctor, this.loading = false, this.error});
  final DoctorModel? doctor;
  final bool loading;
  final String? error;
}

class DoctorLoadCubit extends Cubit<DoctorLoadState> {
  DoctorLoadCubit({
    required this.doctorId,
    required DoctorsFirestoreService service,
    DoctorModel? initialDoctor,
  }) : _service = service,
       super(
         DoctorLoadState(
           doctor: initialDoctor?.id == doctorId ? initialDoctor : null,
           loading: initialDoctor?.id != doctorId,
         ),
       );

  final String doctorId;
  final DoctorsFirestoreService _service;
  StreamSubscription<DoctorModel?>? _subscription;
  int _generation = 0;

  Future<void> load() async {
    final generation = ++_generation;
    await _subscription?.cancel();
    if (isClosed || generation != _generation) return;
    if (doctorId.trim().isEmpty || doctorId.contains('/')) {
      emit(const DoctorLoadState());
      return;
    }
    emit(DoctorLoadState(doctor: state.doctor, loading: state.doctor == null));
    try {
      _subscription = _service
          .watchDoctor(doctorId)
          .listen(
            (doctor) {
              if (!isClosed && generation == _generation) {
                emit(DoctorLoadState(doctor: doctor));
              }
            },
            onError: (Object error) {
              if (!isClosed && generation == _generation) {
                emit(DoctorLoadState(error: localizedError(error)));
              }
            },
          );
    } catch (error) {
      if (!isClosed && generation == _generation) {
        emit(DoctorLoadState(error: localizedError(error)));
      }
    }
  }

  @override
  Future<void> close() async {
    _generation++;
    await _subscription?.cancel();
    return super.close();
  }
}
