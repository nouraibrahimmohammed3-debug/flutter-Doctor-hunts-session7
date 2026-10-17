import 'package:doctor_hunt/generated/strings.g.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/appointments/data/appointment_service.dart';
import '../../../../shared/doctors/data/models/doctor_model.dart';
import '../../../../shared/doctors/data/services/doctors_firestore_service.dart';
import '../../data/models/time_slot_model.dart';
import 'select_time_state.dart';

class SelectTimeCubit extends Cubit<SelectTimeState> {
  SelectTimeCubit({
    required DoctorModel doctor,
    required AppointmentService appointments,
    required DoctorsFirestoreService doctors,
  }) : _doctor = doctor,
       super(
         SelectTimeState(
           selectedDate: riyadhNow(),
           availableSlots: const [],
           loading: true,
         ),
       ) {
    _appointments = appointments;
    _doctors = doctors;
    _listen();
  }
  late final AppointmentService _appointments;
  late final DoctorsFirestoreService _doctors;
  String? _doctorError;
  String? _slotsError;
  String _message(Object error, String source) {
    var appStrings = t;
    debugPrint('SelectTime $source: $error');
    return error is FirebaseException && error.code == 'permission-denied'
        ? appStrings.commonUi.availabilityAccessFailed
        : appStrings.commonUi.availabilityLoadFailed;
  }

  void _listen() {
    _doctorSubscription = _doctors
        .watchDoctor(_doctor.id)
        .listen(
          (value) {
            var appStrings = t;
            if (value == null) {
              _doctorError = appStrings.commonUi.doctorNotFound;
              _refresh();
              return;
            }
            _doctor = value;
            _doctorLoaded = true;
            _doctorError = null;
            _refresh();
          },
          onError: (Object error) {
            _doctorError = _message(error, 'doctor');
            _refresh();
          },
        );
    _slotsSubscription = _appointments
        .watchBookedSlots(_doctor.id)
        .listen(
          (slots) {
            _booked = slots;
            _slotsLoaded = true;
            _slotsError = null;
            _refresh();
          },
          onError: (Object error) {
            _slotsError = _message(error, 'booking_slots');
            _refresh();
          },
        );
  }

  Future<void> retry() async {
    await _doctorSubscription?.cancel();
    await _slotsSubscription?.cancel();
    if (isClosed) return;
    _doctorLoaded = false;
    _slotsLoaded = false;
    _doctorError = null;
    _slotsError = null;
    _booked = [];
    emit(
      SelectTimeState(
        selectedDate: state.selectedDate,
        availableSlots: const [],
        loading: true,
      ),
    );
    _listen();
  }

  DoctorModel _doctor;
  DoctorModel get doctor => _doctor;
  List<DateTime> _booked = [];
  bool _doctorLoaded = false;
  bool _slotsLoaded = false;
  StreamSubscription<DoctorModel?>? _doctorSubscription;
  StreamSubscription<List<DateTime>>? _slotsSubscription;
  List<TimeSlotModel> slotsForDate(DateTime date) {
    if (!_doctorLoaded ||
        !_slotsLoaded ||
        !_doctor.isAvailable ||
        _doctorError != null ||
        _slotsError != null) {
      return [];
    }
    return _doctor.availability
        .slotsForDate(date)
        .where((slot) => !_booked.any((taken) => taken.isAtSameMomentAs(slot)))
        .map((slot) {
          final local = riyadhTime(slot);
          return TimeSlotModel(hour: local.hour, minute: local.minute);
        })
        .toList();
  }

  void _refresh() {
    final slots = slotsForDate(state.selectedDate);
    final selected = state.selectedTime;
    emit(
      SelectTimeState(
        selectedDate: state.selectedDate,
        availableSlots: slots,
        errorMessage: _doctorError ?? _slotsError,
        loading:
            _doctorError == null &&
            _slotsError == null &&
            (!_doctorLoaded || !_slotsLoaded),
        selectedTime:
            slots.any(
              (slot) =>
                  slot.hour == selected?.hour &&
                  slot.minute == selected?.minute,
            )
            ? selected
            : null,
      ),
    );
  }

  void selectDate(DateTime date) {
    if (state.loading || state.errorMessage != null) return;
    emit(
      SelectTimeState(selectedDate: date, availableSlots: slotsForDate(date)),
    );
  }

  void selectTime(TimeOfDay time) {
    if (!slotsForDate(
      state.selectedDate,
    ).any((slot) => slot.hour == time.hour && slot.minute == time.minute)) {
      _refresh();
      return;
    }
    emit(
      SelectTimeState(
        selectedDate: state.selectedDate,
        availableSlots: state.availableSlots,
        selectedTime: time,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _doctorSubscription?.cancel();
    await _slotsSubscription?.cancel();
    return super.close();
  }
}
