import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_image.dart';
import '../../data/models/doctor_specialty.dart';
import 'package:gap/gap.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/presentation/cubit/doctor_form_cubit.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorFormFields extends StatelessWidget {
  const DoctorFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    final specializations = <String>{
      ...DoctorSpecialty.ids,
      if (context.read<DoctorFormCubit>().state.specialization
          case final String value)
        value,
    };

    return BlocBuilder<DoctorFormCubit, DoctorFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 96,
                height: 96,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFB8CDC0),
                      width: 1.5,
                    ),
                  ),
                  child: state.imagePath.isEmpty
                      ? const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Color(0xFF738278),
                        )
                      : ClipOval(
                          child: DoctorImage(imagePath: state.imagePath),
                        ),
                ),
              ),
            ),
            Center(
              child: TextButton.icon(
                onPressed: state.uploading
                    ? null
                    : context.read<DoctorFormCubit>().uploadPhoto,
                icon: state.uploading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add_a_photo_outlined),
                label: Text(
                  state.imagePath.isEmpty
                      ? appStrings.commonUi.addPhoto
                      : appStrings.commonUi.updatePhoto,
                ),
              ),
            ),
            if (state.errorMessage != null)
              Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const Gap(24),
            Text(
              appStrings.doctorName.toUpperCase(),
              style: context.bold12TextMain.copyWith(letterSpacing: 0.7),
            ),
            const Gap(12),
            TextFormField(
              initialValue: state.name,
              keyboardType: TextInputType.name,
              onChanged: context.read<DoctorFormCubit>().nameChanged,
              validator: (value) => value == null || value.trim().isEmpty
                  ? appStrings.doctorNameRequired
                  : null,
              decoration: InputDecoration(hintText: appStrings.enterDoctorName),
            ),
            const Gap(16),
            Text(
              appStrings.specialization.toUpperCase(),
              style: context.bold12TextMain.copyWith(letterSpacing: 0.7),
            ),
            const Gap(12),
            DropdownButtonFormField<String>(
              initialValue: state.specialization,
              hint: Text(appStrings.selectSpecialization),
              isExpanded: true,
              items: specializations
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(DoctorSpecialty.label(item)),
                    ),
                  )
                  .toList(),
              onChanged: context.read<DoctorFormCubit>().specializationChanged,
              validator: (value) =>
                  value == null ? appStrings.specializationRequired : null,
              decoration: const InputDecoration(),
            ),
            const Gap(16),
            Text(
              appStrings.commonUi.consultationFee,
              style: context.bold12TextMain.copyWith(letterSpacing: 0.7),
            ),
            const Gap(12),
            TextFormField(
              initialValue: state.fee,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: context.read<DoctorFormCubit>().feeChanged,
              decoration: InputDecoration(
                hintText: appStrings.commonUi.feeExample,
              ),
              validator: (value) {
                final fee = double.tryParse(value?.trim() ?? '');
                return fee == null || !fee.isFinite || fee < 0
                    ? appStrings.commonUi.invalidFee
                    : null;
              },
            ),
          ],
        );
      },
    );
  }
}
