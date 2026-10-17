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
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctor_photo_service.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_form_fields.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AddDoctorBloc>()),
        BlocProvider(
          create: (_) => DoctorFormCubit(
            photoService: getIt<DoctorPhotoService>(),
            initialState: const DoctorFormState(),
          ),
        ),
      ],
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
    var appStrings = context.t;

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
                state.successMessage ?? appStrings.commonUi.doctorAdded,
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
                state.errorMessage ?? appStrings.commonUi.doctorAddFailed,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: DoctorHuntAppBar(
          title: appStrings.createDoctor,
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

                  BlocBuilder<AddDoctorBloc, AddDoctorState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      final loading = state.status == AddDoctorStatus.loading;

                      return PrimaryButton(
                        label: appStrings.createDoctor,
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

    final doctor = DoctorModel(
      id: '',
      name: form.name.trim(),
      specialization: specialization,
      imagePath: form.imagePath,
      rating: 0,
      experience: 0,
      patientStories: 0,
      price: double.parse(form.fee.trim()),
      isAvailable: true,
    );

    context.read<AddDoctorBloc>().add(AddDoctorSubmitted(doctor));
  }
}
