import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor/bloc/add_doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor/bloc/add_doctor_event.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor/bloc/add_doctor_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/cubit/doctor_form_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_form_fields.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddDoctorBloc>(),
      child: const _AddDoctorView(),
    );
  }
}

class _AddDoctorView extends StatefulWidget {
  const _AddDoctorView();

  @override
  State<_AddDoctorView> createState() => _AddDoctorViewState();
}

class _AddDoctorViewState extends State<_AddDoctorView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDoctorBloc, AddDoctorState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.status == AddDoctorStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMessage ??
                    'Doctor added successfully.',
              ),
            ),
          );

          context.pop();
          return;
        }

        if (state.status == AddDoctorStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ??
                    'Failed to add doctor.',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: DoctorHuntAppBar(
          title: t.createDoctor,
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

                  Text(t.doctorImage),

                  const Gap(8),

                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        t.uploadDoctorImage,
                      ),
                    ),
                  ),

                  const Gap(32),

                  BlocBuilder<AddDoctorBloc, AddDoctorState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      final loading =
                          state.status ==
                          AddDoctorStatus.loading;

                      return PrimaryButton(
                        label: t.createDoctor,
                        onPressed: loading
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

    final specialization = form.specialization;

    if (specialization == null) {
      return;
    }

    final doctor = DoctorModel(
      id: '',
      name: form.name.trim(),
      specialization: specialization,
      imagePath: '',
      rating: 0,
      experience: 0,
      patientStories: 0,
      price: 0,
      isAvailable: true,
    );

    context.read<AddDoctorBloc>().add(
          AddDoctorSubmitted(doctor),
        );
  }
}