class DoctorAvailability {
  const DoctorAvailability({
    this.workingDays = const [],
    this.startMinute = 0,
    this.endMinute = 0,
    this.slotMinutes = 0,
  });
  final List<int> workingDays;
  final int startMinute;
  final int endMinute;
  final int slotMinutes;
  bool get isValid =>
      workingDays.isNotEmpty &&
      workingDays.every((day) => day >= 1 && day <= 7) &&
      startMinute >= 0 &&
      endMinute <= 1440 &&
      startMinute < endMinute &&
      slotMinutes >= 5 &&
      slotMinutes <= endMinute - startMinute;
  Map<String, dynamic> toMap() => {
    'workingDays': workingDays,
    'startMinute': startMinute,
    'endMinute': endMinute,
    'slotMinutes': slotMinutes,
  };
  factory DoctorAvailability.fromMap(Map<String, dynamic> map) =>
      DoctorAvailability(
        workingDays:
            (map['workingDays'] as List?)?.whereType<int>().toList() ?? [],
        startMinute: (map['startMinute'] as num?)?.toInt() ?? 0,
        endMinute: (map['endMinute'] as num?)?.toInt() ?? 0,
        slotMinutes: (map['slotMinutes'] as num?)?.toInt() ?? 0,
      );
  List<DateTime> slotsForDate(DateTime date, {DateTime? now}) {
    if (!isValid || !workingDays.contains(date.weekday)) return [];
    final today = now ?? DateTime.now();
    final day = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ).subtract(const Duration(hours: 3));
    return [
      for (
        var minute = startMinute;
        minute + slotMinutes <= endMinute;
        minute += slotMinutes
      )
        if (day.add(Duration(minutes: minute)).isAfter(today))
          day.add(Duration(minutes: minute)),
    ];
  }
}
