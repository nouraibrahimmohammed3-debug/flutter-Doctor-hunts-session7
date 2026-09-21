import 'package:doctor_hunt/apps/features/patient/appointments/data/models/time_slot_model.dart';
import 'package:flutter/material.dart';

class SelectTimeState {
  const SelectTimeState({
    required this.selectedDate,
    required this.availableSlots,
    this.selectedTime,
  });
  final List<TimeSlotModel> availableSlots;
  final DateTime selectedDate;
  final TimeOfDay? selectedTime;
}
