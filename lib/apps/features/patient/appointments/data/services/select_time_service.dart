
import 'package:doctor_hunt/apps/features/patient/appointments/data/models/time_slot_model.dart';

abstract final class SelectTimeService {
  static const List<TimeSlotModel> slots = [
    TimeSlotModel(hour: 13, minute: 0),
    TimeSlotModel(hour: 13, minute: 30),
    TimeSlotModel(hour: 14, minute: 0),
    TimeSlotModel(hour: 14, minute: 30),
    TimeSlotModel(hour: 15, minute: 0),
    TimeSlotModel(hour: 15, minute: 30),
    TimeSlotModel(hour: 16, minute: 0),
    TimeSlotModel(hour: 17, minute: 0),
    TimeSlotModel(hour: 17, minute: 30),
    TimeSlotModel(hour: 18, minute: 0),
    TimeSlotModel(hour: 18, minute: 30),
    TimeSlotModel(hour: 19, minute: 0),
  ];
  static List<TimeSlotModel> slotsForDate(DateTime date) {
    final DateTime today = DateTime.now();

    final bool isToday =
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    if (isToday) {
      return const [];
    }

    return slots;
  }
}
