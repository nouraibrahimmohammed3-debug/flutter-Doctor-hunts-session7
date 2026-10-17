import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_state.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_event.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/widgets/admin_doctor_card.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DoctorAdminTile extends StatelessWidget {
  const DoctorAdminTile({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final availabilityProcessing = context.select<AdminDoctorsBloc, bool>(
      (bloc) => bloc.state.processingDoctorId == doctor.id,
    );

    final deactivationProcessing = context.select<DeactivateDoctorBloc, bool>(
      (bloc) =>
          bloc.state.status == DeactivateDoctorStatus.loading &&
          bloc.state.deactivatingDoctorId == doctor.id,
    );

    final processing = availabilityProcessing || deactivationProcessing;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.alabaster),
      ),
      child: InkWell(
        onTap: () => context.push(AppRouter.adminDoctorDetailsPath(doctor.id)),
        child: AdminDoctorCard(
          imagePath: doctor.imagePath,
          name: doctor.name,
          specialization: doctor.specialtyLabel,
          isAvailable: doctor.isAvailable,
          isProcessing: processing,
          onMorePressed: processing
              ? null
              : () => _showActions(context, doctor),
        ),
      ),
    );
  }

  void _showActions(BuildContext context, DoctorModel doctor) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        var appStrings = t;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: Text(appStrings.commonUi.appointments),
                onTap: () {
                  sheetContext.pop();
                  context.push(AppRouter.adminAppointments, extra: doctor);
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: Text(appStrings.commonUi.manageAvailability),
                onTap: () {
                  sheetContext.pop();
                  context.push(AppRouter.doctorAvailability, extra: doctor);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: Text(appStrings.editDoctor),
                onTap: () {
                  sheetContext.pop();
                  context.push(AppRouter.editDoctor, extra: doctor);
                },
              ),
              ListTile(
                leading: Icon(
                  doctor.isAvailable ? Icons.visibility_off : Icons.visibility,
                ),
                title: Text(
                  doctor.isAvailable
                      ? appStrings.commonUi.deactivateDoctor
                      : appStrings.commonUi.activateDoctor,
                ),
                onTap: () {
                  sheetContext.pop();
                  context.read<AdminDoctorsBloc>().add(
                    AdminDoctorAvailabilityChanged(
                      doctor.id,
                      !doctor.isAvailable,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
