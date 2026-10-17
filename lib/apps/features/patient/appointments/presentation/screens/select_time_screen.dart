import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/data/models/time_slot_model.dart';
import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/features/shared/appointments/data/appointment_service.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'review_appointment_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/cubit/select_time_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/cubit/select_time_state.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/widgets/select_time_doctor_card.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:intl/intl.dart';

class SelectTimeScreen extends StatelessWidget {
  const SelectTimeScreen({required this.doctor, super.key});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return BlocProvider(
      create: (_) => SelectTimeCubit(
        doctor: doctor,
        appointments: getIt<AppointmentService>(),
        doctors: getIt<DoctorsFirestoreService>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appStrings.selecttime, style: context.semiBold16TextMain),
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRouter.home);
              }
            },
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              SelectTimeDoctorCard(doctor: doctor),
              const SizedBox(height: 20),
              BlocBuilder<SelectTimeCubit, SelectTimeState>(
                builder: (context, state) {
                  if (state.errorMessage != null) {
                    return Column(
                      children: [
                        Text(state.errorMessage!, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: context.read<SelectTimeCubit>().retry,
                          child: Text(appStrings.commonUi.tryAgain),
                        ),
                      ],
                    );
                  }
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final DateTime now = riyadhNow();

                  final DateTime today = DateTime(now.year, now.month, now.day);

                  final DateTime selectedDate = DateTime(
                    state.selectedDate.year,
                    state.selectedDate.month,
                    state.selectedDate.day,
                  );

                  DateTime? nextAvailableDate;
                  final lastDate = today.add(const Duration(days: 30));
                  for (
                    var date = selectedDate.add(const Duration(days: 1));
                    !date.isAfter(lastDate);
                    date = date.add(const Duration(days: 1))
                  ) {
                    if (context
                        .read<SelectTimeCubit>()
                        .slotsForDate(date)
                        .isNotEmpty) {
                      nextAvailableDate = date;
                      break;
                    }
                  }

                  final morningSlots = state.availableSlots
                      .where((slot) => slot.hour < 12)
                      .toList();

                  final List<TimeSlotModel> afternoonSlots = state
                      .availableSlots
                      .where((slot) => slot.hour >= 12 && slot.hour < 17)
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
                            '${DateFormat('d MMM', LocaleSettings.currentLocale.languageCode).format(selectedDate)}'
                      : DateFormat(
                          'EEEE, d MMM',
                          LocaleSettings.currentLocale.languageCode,
                        ).format(selectedDate);

                  final String nextAvailableDateLabel =
                      nextAvailableDate == null
                      ? ''
                      : DateFormat(
                          'EEE, d MMM',
                          LocaleSettings.currentLocale.languageCode,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          selected: isSelected,
                          showCheckmark: false,
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.primaryLight,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              DateFormat(
                                'MMMM yyyy',
                                LocaleSettings.currentLocale.languageCode,
                              ).format(selectedDate),
                              style: context.semiBold16TextMain,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_month_outlined),
                            tooltip: appStrings.commonUi.chooseDate,
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: today,
                                lastDate: lastDate,
                              );
                              if (date != null && context.mounted) {
                                context.read<SelectTimeCubit>().selectDate(
                                  date,
                                );
                              }
                            },
                          ),
                        ],
                      ),
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

                              final int slotsCount = context
                                  .read<SelectTimeCubit>()
                                  .slotsForDate(date)
                                  .length;

                              final String dayName = isCurrentDay
                                  ? appStrings.today
                                  : isTomorrow
                                  ? appStrings.tomorrow
                                  : DateFormat(
                                      'EEE',
                                      LocaleSettings.currentLocale.languageCode,
                                    ).format(date);

                              final String title =
                                  '$dayName, '
                                  '${DateFormat('d MMM', LocaleSettings.currentLocale.languageCode).format(date)}';

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
                                        style: context.semiBold14TextMain
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
                            if (nextAvailableDate != null)
                              PrimaryButton(
                                label:
                                    '${appStrings.nextAvailabilityOn} '
                                    '$nextAvailableDateLabel',
                                onPressed: () {
                                  context.read<SelectTimeCubit>().selectDate(
                                    nextAvailableDate!,
                                  );
                                },
                              ),
                          ],
                        )
                      else ...[
                        if (morningSlots.isNotEmpty) ...[
                          Text(
                            appStrings.commonUi.morningSlots(
                              count: morningSlots.length,
                            ),
                            style: context.semiBold16TextMain,
                          ),
                          const SizedBox(height: 12),
                          buildSlots(morningSlots),
                          const SizedBox(height: 20),
                        ],
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
                          label: appStrings.commonUi.confirm,
                          onPressed: () {
                            final TimeOfDay? selectedTime = state.selectedTime;

                            if (selectedTime == null) {
                              return;
                            }

                            Navigator.of(context).push<bool>(
                              MaterialPageRoute(
                                builder: (_) => ReviewAppointmentScreen(
                                  doctor: context
                                      .read<SelectTimeCubit>()
                                      .doctor,
                                  date: state.selectedDate,
                                  time: selectedTime,
                                ),
                              ),
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
