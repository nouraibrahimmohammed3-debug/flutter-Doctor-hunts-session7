import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AppointmentSuccessCard extends StatelessWidget {
  const AppointmentSuccessCard({
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    super.key,
  });

  final DoctorModel doctor;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMM d').format(selectedDate);

    final String formattedTime = selectedTime.format(context);

    var appStrings = t;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 70,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 20),
            Text(
              appStrings.appointmentSuccessful,
              textAlign: TextAlign.center,
              style: context.bold24TextMain,
            ),
            SizedBox(height: 8),
            Text(
              t.done,
              textAlign: TextAlign.center,
              style: context.regular14TextSub,
            ),
            const SizedBox(height: 20),
            Text(
              appStrings.appointmentConfirmation(
                doctorName: doctor.name,
                date: formattedDate,
                time: formattedTime,
              ),
              textAlign: TextAlign.center,
              style: context.regular14TextSub,
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: appStrings.done,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                appStrings.editAppointment,
                style: context.regular14TextSub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
