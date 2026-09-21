import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_event.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/cubit/doctor_form_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_form_fields.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class CreateDoctorScreen extends StatelessWidget {
  const CreateDoctorScreen({super.key, this.doctor});

  final DoctorModel? doctor;

  @override
  Widget build(BuildContext context) {
    final existing = doctor;

    return BlocProvider(
      create: (_) => DoctorFormCubit(
        initialState: existing == null
            ? const DoctorFormState()
            : DoctorFormState(
                name: existing.name,
                specialization: existing.specialization,
              ),
      ),
      child: _DoctorFormScreen(doctor: existing),
    );
  }
}

class _DoctorFormScreen extends StatefulWidget {
  const _DoctorFormScreen({this.doctor});

  final DoctorModel? doctor;

  @override
  State<_DoctorFormScreen> createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<_DoctorFormScreen> {
  final _formKey = GlobalKey<FormState>();

  bool get isEdit => widget.doctor != null;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminDoctorsBloc, AdminDoctorsState>(
      listenWhen: (previous, current) =>
          previous.action != current.action ||
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.successMessage != null && state.action == AdminDoctorAction.none) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.successMessage!)),
          );
          context.pop();
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: Scaffold(
        appBar: DoctorHuntAppBar(
          title: isEdit ? 'Edit Doctor' : t.createDoctor,
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
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: Center(child: Text(t.uploadDoctorImage)),
                  ),
                  const Gap(32),
                  BlocBuilder<AdminDoctorsBloc, AdminDoctorsState>(
                    builder: (context, state) {
                      final loading = state.action == AdminDoctorAction.adding ||
                          state.action == AdminDoctorAction.updating;
                      return PrimaryButton(
                        label: isEdit ? 'Edit Doctor' : t.createDoctor,
                        onPressed: loading ? null : () => _submit(context),
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
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final form = context.read<DoctorFormCubit>().state;
    final specialization = form.specialization;
    if (specialization == null) return;

    final updated = (widget.doctor ??
            const DoctorModel(
              id: '',
              name: '',
              specialization: '',
              imagePath: '',
              rating: 0,
              experience: 0,
              patientStories: 0,
              price: 0,
              isAvailable: true,
            ))
        .copyWith(
      name: form.name.trim(),
      specialization: specialization,
    );

    if (isEdit) {
      context.read<AdminDoctorsBloc>().add(AdminDoctorUpdated(updated));
    } else {
      context.read<AdminDoctorsBloc>().add(AdminDoctorAdded(updated));
    }
  }
}
