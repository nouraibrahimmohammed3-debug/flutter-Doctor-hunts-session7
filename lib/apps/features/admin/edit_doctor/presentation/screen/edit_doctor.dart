import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/edit_doctor/bloc/edit_doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/edit_doctor/bloc/edit_doctor_event.dart';
import 'package:doctor_hunt/apps/features/admin/edit_doctor/bloc/edit_doctor_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/cubit/doctor_form_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctor_photo_service.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_form_fields.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class EditDoctorScreen extends StatelessWidget {
  const EditDoctorScreen({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditDoctorBloc>(),
      child: BlocProvider(
        create: (_) => DoctorFormCubit(
          photoService: getIt<DoctorPhotoService>(),
          initialState: DoctorFormState(
            name: doctor.name,
            specialization: doctor.specialization,
            fee: doctor.price.toString(),
            imagePath: doctor.imagePath,
          ),
        ),
        child: _EditDoctorView(doctor: doctor),
      ),
    );
  }
}

class _EditDoctorView extends StatefulWidget {
  const _EditDoctorView({required this.doctor});

  final DoctorModel doctor;

  @override
  State<_EditDoctorView> createState() => _EditDoctorViewState();
}

class _EditDoctorViewState extends State<_EditDoctorView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return BlocListener<EditDoctorBloc, EditDoctorState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.status == EditDoctorStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMessage ?? appStrings.commonUi.doctorUpdated,
              ),
            ),
          );

          context.pop();
          return;
        }

        if (state.status == EditDoctorStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? appStrings.commonUi.doctorUpdateFailed,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: DoctorHuntAppBar(
          title: appStrings.editDoctor,
          showBackButton: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Gap(12),

                  const DoctorFormFields(),

                  const Gap(20),
                  const Gap(32),

                  BlocBuilder<EditDoctorBloc, EditDoctorState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      final loading = state.status == EditDoctorStatus.loading;

                      return PrimaryButton(
                        label: appStrings.editDoctor,
                        onPressed:
                            loading ||
                                context.watch<DoctorFormCubit>().state.uploading
                            ? null
                            : () => _submit(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final form = context.read<DoctorFormCubit>().state;
    if (form.uploading) return;

    final specialization = form.specialization;

    if (specialization == null) {
      return;
    }

    final updatedDoctor = widget.doctor.copyWith(
      name: form.name.trim(),
      specialization: specialization,
      price: double.parse(form.fee.trim()),
      imagePath: form.imagePath,
    );

    context.read<EditDoctorBloc>().add(EditDoctorSubmitted(updatedDoctor));
  }
}
