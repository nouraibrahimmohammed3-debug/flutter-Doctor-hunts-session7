import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/doctor_hunt_app_bar.dart';
import '../../../shared/doctors/data/models/doctor_model.dart';
import '../../../shared/doctors/data/models/doctor_availability.dart';
import '../../../shared/doctors/data/services/doctors_firestore_service.dart';

class AvailabilityState {
  const AvailabilityState(
    this.schedule, {
    this.saving = false,
    this.saved = false,
    this.error,
  });
  final DoctorAvailability schedule;
  final bool saving;
  final bool saved;
  final String? error;
}

class AvailabilityCubit extends Cubit<AvailabilityState> {
  AvailabilityCubit(this.doctor, this.service)
    : super(AvailabilityState(doctor.availability));
  final DoctorModel doctor;
  final DoctorsFirestoreService service;
  void change({List<int>? days, int? start, int? end, int? duration}) {
    if (state.saving) return;
    final current = state.schedule;
    emit(
      AvailabilityState(
        DoctorAvailability(
          workingDays: days ?? current.workingDays,
          startMinute: start ?? current.startMinute,
          endMinute: end ?? current.endMinute,
          slotMinutes: duration ?? current.slotMinutes,
        ),
      ),
    );
  }

  Future<void> save() async {
    var appStrings = t;
    if (state.saving) return;
    if (!state.schedule.isValid) {
      emit(
        AvailabilityState(
          state.schedule,
          error: appStrings.commonUi.invalidAvailability,
        ),
      );
      return;
    }
    emit(AvailabilityState(state.schedule, saving: true));
    try {
      await service.saveAvailability(doctor.id, state.schedule);
      if (!isClosed) emit(AvailabilityState(state.schedule, saved: true));
    } catch (error) {
      if (!isClosed) {
        emit(AvailabilityState(state.schedule, error: localizedError(error)));
      }
    }
  }
}

class DoctorAvailabilityScreen extends StatelessWidget {
  const DoctorAvailabilityScreen({required this.doctor, super.key});
  final DoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return BlocProvider(
      create: (_) =>
          AvailabilityCubit(doctor, getIt<DoctorsFirestoreService>()),
      child: BlocConsumer<AvailabilityCubit, AvailabilityState>(
        listener: (context, state) {
          if (state.saved) context.pop();
        },
        builder: (context, state) {
          final cubit = context.read<AvailabilityCubit>();
          final schedule = state.schedule;
          final days = [
            appStrings.mvp.monday,
            appStrings.mvp.tuesday,
            appStrings.mvp.wednesday,
            appStrings.mvp.thursday,
            appStrings.mvp.friday,
            appStrings.mvp.saturday,
            appStrings.mvp.sunday,
          ];
          String timeLabel(int minute) => TimeOfDay(
            hour: minute ~/ 60,
            minute: minute % 60,
          ).format(context);
          Future<void> pickTime(bool start) async {
            final minute = start ? schedule.startMinute : schedule.endMinute;
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: minute ~/ 60, minute: minute % 60),
            );
            if (time != null && context.mounted) {
              cubit.change(
                start: start ? time.hour * 60 + time.minute : null,
                end: start ? null : time.hour * 60 + time.minute,
              );
            }
          }

          return Scaffold(
            appBar: DoctorHuntAppBar(
              title: appStrings.commonUi.doctorAvailability,
              showBackButton: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 52,
                            height: 52,
                            child: DoctorImage(imagePath: doctor.imagePath),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                doctor.specialtyLabel,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSub,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          doctor.isAvailable
                              ? appStrings.commonUi.active
                              : appStrings.commonUi.inactive,
                          style: TextStyle(
                            fontSize: 10,
                            color: doctor.isAvailable
                                ? AppColors.primary
                                : AppColors.danger,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        appStrings.commonUi.workingDays,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      appStrings.commonUi.enabledDays(
                        count: schedule.workingDays.length,
                      ),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSub,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Card(
                  child: Column(
                    children: [
                      for (var day = 1; day <= 7; day++)
                        SwitchListTile(
                          secondary: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.calendar_month,
                              size: 17,
                              color: schedule.workingDays.contains(day)
                                  ? AppColors.primary
                                  : AppColors.textSub,
                            ),
                          ),
                          dense: true,
                          title: Text(days[day - 1]),
                          value: schedule.workingDays.contains(day),
                          onChanged: state.saving
                              ? null
                              : (selected) {
                                  final updated = {...schedule.workingDays};
                                  selected
                                      ? updated.add(day)
                                      : updated.remove(day);
                                  cubit.change(days: updated.toList()..sort());
                                },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  appStrings.commonUi.workingHours,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(appStrings.mvp.startTime),
                                trailing: Text(timeLabel(schedule.startMinute)),
                                onTap: state.saving
                                    ? null
                                    : () => pickTime(true),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(appStrings.mvp.endTime),
                                trailing: Text(timeLabel(schedule.endMinute)),
                                onTap: state.saving
                                    ? null
                                    : () => pickTime(false),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          initialValue: schedule.slotMinutes > 0
                              ? '${schedule.slotMinutes}'
                              : '',
                          enabled: !state.saving,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: appStrings.mvp.slotDuration,
                          ),
                          onChanged: (value) =>
                              cubit.change(duration: int.tryParse(value) ?? 0),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: state.saving ? null : cubit.save,
                  child: Text(
                    state.saving
                        ? appStrings.commonUi.saving
                        : appStrings.commonUi.saveAvailability,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
