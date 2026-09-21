import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/data/models/time_slot_model.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/data/services/select_time_service.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/cubit/select_time_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/cubit/select_time_state.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/widgets/appointment_success_card.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/widgets/select_time_doctor_card.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SelectTimeScreen extends StatelessWidget {
  const SelectTimeScreen({required this.doctor, super.key});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    var appStrings = t;

    return BlocProvider(
      create: (_) => SelectTimeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appStrings.selecttime, style: context.semiBold16TextMain),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              SelectTimeDoctorCard(doctor: doctor),
              const SizedBox(height: 20),
              BlocBuilder<SelectTimeCubit, SelectTimeState>(
                builder: (context, state) {
                  final DateTime now = DateTime.now();

                  final DateTime today = DateTime(now.year, now.month, now.day);

                  final DateTime selectedDate = DateTime(
                    state.selectedDate.year,
                    state.selectedDate.month,
                    state.selectedDate.day,
                  );

                  final DateTime nextAvailableDate = selectedDate.add(
                    const Duration(days: 1),
                  );

                  final List<TimeSlotModel> afternoonSlots = state
                      .availableSlots
                      .where((slot) => slot.hour < 17)
                      .toList();

                  final List<TimeSlotModel> eveningSlots = state.availableSlots
                      .where((slot) => slot.hour >= 17)
                      .toList();

                  final bool isToday =
                      selectedDate.year == today.year &&
                      selectedDate.month == today.month &&
                      selectedDate.day == today.day;

                  final String dateLabel = isToday
                      ? '${appStrings.today}, '
                            '${DateFormat('d MMM').format(selectedDate)}'
                      : DateFormat('EEEE, d MMM').format(selectedDate);

                  final String nextAvailableDateLabel = DateFormat(
                    'EEE, d MMM',
                  ).format(nextAvailableDate);

                  Widget buildSlots(List<TimeSlotModel> slots) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: slots.map((slot) {
                        final TimeOfDay time = TimeOfDay(
                          hour: slot.hour,
                          minute: slot.minute,
                        );

                        final bool isSelected =
                            state.selectedTime?.hour == time.hour &&
                            state.selectedTime?.minute == time.minute;

                        return ChoiceChip(
                          label: Text(time.format(context)),
                          selected: isSelected,
                          showCheckmark: false,
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.primaryLight,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelStyle: isSelected
                              ? context.medium12Primary.copyWith(
                                  color: AppColors.white,
                                )
                              : context.medium12Primary,
                          onSelected: (_) {
                            context.read<SelectTimeCubit>().selectTime(time);
                          },
                        );
                      }).toList(),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EasyDateTimeLinePicker.itemBuilder(
                        focusedDate: selectedDate,
                        firstDate: today,
                        lastDate: today.add(const Duration(days: 30)),
                        itemExtent: 145,
                        daySeparatorPadding: 5,
                        headerOptions: const HeaderOptions(
                          headerType: HeaderType.none,
                        ),
                        timelineOptions: const TimelineOptions(height: 64),
                        itemBuilder:
                            (
                              context,
                              date,
                              isSelected,
                              isDisabled,
                              isCurrentDay,
                              onTap,
                            ) {
                              final DateTime tomorrow = today.add(
                                const Duration(days: 1),
                              );

                              final bool isTomorrow =
                                  date.year == tomorrow.year &&
                                  date.month == tomorrow.month &&
                                  date.day == tomorrow.day;

                              final int slotsCount =
                                  SelectTimeService.slotsForDate(date).length;

                              final String dayName = isCurrentDay
                                  ? appStrings.today
                                  : isTomorrow
                                  ? appStrings.tomorrow
                                  : DateFormat('EEE').format(date);

                              final String title =
                                  '$dayName, '
                                  '${DateFormat('d MMM').format(date)}';

                              final String availability = slotsCount == 0
                                  ? appStrings.noSlotsAvailable
                                  : '$slotsCount '
                                        '${appStrings.slotsAvailable}';

                              return InkWell(
                                onTap: isDisabled ? null : onTap,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textBorders,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.semiBold16TextMain
                                            .copyWith(
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.textMain,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        availability,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.regular11TextSub
                                            .copyWith(
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.textSub,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                        onDateChange: (date) {
                          context.read<SelectTimeCubit>().selectDate(date);
                        },
                      ),
                      const SizedBox(height: 18),
                      Center(
                        child: Text(
                          dateLabel,
                          style: context.semiBold16TextMain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (state.availableSlots.isEmpty)
                        Column(
                          children: [
                            Text(
                              appStrings.noSlotsAvailable,
                              style: context.regular14TextSub,
                            ),
                            const SizedBox(height: 18),
                            PrimaryButton(
                              label:
                                  '${appStrings.nextAvailabilityOn} '
                                  '$nextAvailableDateLabel',
                              onPressed: () {
                                context.read<SelectTimeCubit>().selectDate(
                                  nextAvailableDate,
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            Text(
                              appStrings.orText,
                              style: context.regular14TextSub,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  appStrings.contactClinic,
                                  style: context.medium14Primary,
                                ),
                              ),
                            ),
                          ],
                        )
                      else ...[
                        if (afternoonSlots.isNotEmpty) ...[
                          Text(
                            '${appStrings.afternoon} '
                            '${afternoonSlots.length} '
                            '${appStrings.slots}',
                            style: context.semiBold16TextMain,
                          ),
                          const SizedBox(height: 12),
                          buildSlots(afternoonSlots),
                        ],
                        if (afternoonSlots.isNotEmpty &&
                            eveningSlots.isNotEmpty)
                          const SizedBox(height: 20),
                        if (eveningSlots.isNotEmpty) ...[
                          Text(
                            '${appStrings.evening} '
                            '${eveningSlots.length} '
                            '${appStrings.slots}',
                            style: context.semiBold16TextMain,
                          ),
                          const SizedBox(height: 12),
                          buildSlots(eveningSlots),
                        ],
                      ],
                      if (state.selectedTime != null) ...[
                        const SizedBox(height: 28),
                        PrimaryButton(
                          label: appStrings.bookAppointment,
                          onPressed: () {
                            final TimeOfDay? selectedTime = state.selectedTime;

                            if (selectedTime == null) {
                              return;
                            }

                            showDialog<void>(
                              context: context,
                              builder: (dialogContext) {
                                return AppointmentSuccessCard(
                                  doctor: doctor,
                                  selectedDate: state.selectedDate,
                                  selectedTime: selectedTime,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
