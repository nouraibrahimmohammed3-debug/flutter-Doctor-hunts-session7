import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/cubit/creat_doctor/create_doctor_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/cubit/creat_doctor/create_doctor_state.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateDoctorScreen extends StatefulWidget {
  const CreateDoctorScreen({super.key});

  @override
  State<CreateDoctorScreen> createState() => _CreateDoctorScreenState();
}

class _CreateDoctorScreenState extends State<CreateDoctorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String doctorName = '';
  String? selectedSpecialization;

  @override
  Widget build(BuildContext context) {
    final appStrings = t;

    final specializations = [
      appStrings.dental,
      appStrings.cardiology,
      appStrings.ophthalmology,
      appStrings.generalMedicine,
    ];

    return BlocListener<CreateDoctorCubit, CreateDoctorState>(
      listener: (context, state) {
        if (state.status == CreateDoctorStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appStrings.doctorCreatedSuccessfully)),
          );

          context.pop();
        }

        if (state.status == CreateDoctorStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? appStrings.failedToCreateDoctor,
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(12),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      doctorName = value;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return appStrings.doctorNameRequired;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: appStrings.doctorName,
                      hintText: appStrings.enterDoctorName,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    appStrings.specialization,
                    style: context.regular14TextSub,
                  ),
                  const Gap(8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedSpecialization,
                    hint: Text(appStrings.selectSpecialization),
                    isExpanded: true,
                    items: specializations
                        .map(
                          (specialization) => DropdownMenuItem<String>(
                            value: specialization,
                            child: Text(specialization),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSpecialization = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return appStrings.specializationRequired;
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Gap(20),
                  Text(appStrings.doctorImage, style: context.regular14TextSub),
                  const Gap(8),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      // سنربط اختيار الصورة لاحقًا.
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cloud_upload_outlined),
                          const Gap(8),
                          Text(appStrings.uploadDoctorImage),
                          const Gap(4),
                          Text(
                            appStrings.supportedImageFormats,
                            style: context.regular14TextSub,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(32),
                  BlocBuilder<CreateDoctorCubit, CreateDoctorState>(
                    builder: (context, state) {
                      final bool isLoading =
                          state.status == CreateDoctorStatus.loading;

                      return PrimaryButton(
                        label: appStrings.createDoctor,
                        onPressed: isLoading
                            ? null
                            : () {
                                final bool isValid =
                                    _formKey.currentState?.validate() ?? false;

                                if (!isValid) {
                                  return;
                                }

                                final specialization = selectedSpecialization;

                                if (specialization == null) {
                                  return;
                                }

                                context.read<CreateDoctorCubit>().createDoctor(
                                  name: doctorName,
                                  specialization: specialization,
                                  imagePath: '',
                                );
                              },
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
}
