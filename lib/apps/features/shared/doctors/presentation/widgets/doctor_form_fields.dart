import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/presentation/cubit/doctor_form_cubit.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorFormFields extends StatelessWidget {
  const DoctorFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final specializations = [
      t.dental,
      t.cardiology,
      t.ophthalmology,
      t.generalMedicine,
    ];

    return BlocBuilder<DoctorFormCubit, DoctorFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: state.name,
              keyboardType: TextInputType.name,
              onChanged: context.read<DoctorFormCubit>().nameChanged,
              validator: (value) => value == null || value.trim().isEmpty
                  ? t.doctorNameRequired
                  : null,
              decoration: InputDecoration(
                labelText: t.doctorName,
                hintText: t.enterDoctorName,
              ),
            ),
            const Gap(16),
            Text(t.specialization, style: context.regular14TextSub),
            const Gap(8),
            DropdownButtonFormField<String>(
              initialValue: state.specialization,
              hint: Text(t.selectSpecialization),
              isExpanded: true,
              items: specializations
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: context.read<DoctorFormCubit>().specializationChanged,
              validator: (value) =>
                  value == null ? t.specializationRequired : null,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        );
      },
    );
  }
}
