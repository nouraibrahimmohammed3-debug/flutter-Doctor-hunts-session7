import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/select_time_service.dart';
import 'select_time_state.dart';

class SelectTimeCubit extends Cubit<SelectTimeState> {
  SelectTimeCubit()
    : super(
        SelectTimeState(
          selectedDate: DateTime.now(),
          availableSlots: SelectTimeService.slotsForDate(DateTime.now()),
        ),
      );

  void selectDate(DateTime date) {
    emit(
      SelectTimeState(
        selectedDate: date,
        selectedTime: null,
        availableSlots: SelectTimeService.slotsForDate(date),
      ),
    );
  }

  void selectTime(TimeOfDay time) {
    emit(
      SelectTimeState(
        selectedDate: state.selectedDate,
        selectedTime: time,
        availableSlots: state.availableSlots,
      ),
    );
  }
}
