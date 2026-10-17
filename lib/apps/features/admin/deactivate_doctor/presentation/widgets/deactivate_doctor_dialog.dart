import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_event.dart';
import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';

Future<void> showDeactivateDoctorDialog(
  BuildContext context,
  DoctorModel doctor,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return BlocBuilder<DeactivateDoctorBloc, DeactivateDoctorState>(
        builder: (context, state) {
          var appStrings = t;
          final isLoading = state.status == DeactivateDoctorStatus.loading;

          return AlertDialog(
            title: Text(appStrings.commonUi.deactivateQuestion),
            content: Text(
              appStrings.commonUi.deactivateNamedDoctor(name: doctor.name),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => dialogContext.pop(false),
                child: Text(appStrings.commonUi.cancel),
              ),
              FilledButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<DeactivateDoctorBloc>().add(
                          DeactivateDoctorSubmitted(doctor.id),
                        );

                        dialogContext.pop(true);
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(appStrings.commonUi.deactivate),
              ),
            ],
          );
        },
      );
    },
  );

  if (confirmed != true) {
    return;
  }
}
