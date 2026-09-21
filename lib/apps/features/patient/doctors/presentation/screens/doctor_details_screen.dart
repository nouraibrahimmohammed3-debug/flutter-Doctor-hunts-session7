import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({required this.doctor, super.key});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DoctorHuntAppBar(title: 'Creat Doctor'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _DoctorSummary(doctor: doctor),
            const SizedBox(height: 18),
            _DoctorStats(doctor: doctor),
            const SizedBox(height: 22),
            Text(t.services, style: context.semiBold16TextMain),
            const SizedBox(height: 12),
            _ServiceItem(number: 1, text: t.serviceOne),
            _ServiceItem(number: 2, text: t.serviceTwo),
            _ServiceItem(number: 3, text: t.serviceThree),
            const SizedBox(height: 22),
            Text(t.location, style: context.semiBold16TextMain),
            const SizedBox(height: 12),
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: AppColors.secondaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 88,
                    color: AppColors.secondary,
                  ),
                  Icon(Icons.location_on, size: 34, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorSummary extends StatelessWidget {
  const _DoctorSummary({required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.boxShadow, blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 74,
                  height: 84,
                  child: DoctorImage(imagePath: doctor.imagePath),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name, style: context.semiBold16TextMain),
                    Text(
                      doctor.specialization,
                      style: context.regular11TextSub,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        5,
                        (_) => const Icon(
                          Icons.star,
                          size: 15,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.favorite, color: AppColors.danger, size: 21),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.push(AppRouter.selectTimePath(doctor.id));
                  },
                  child: Text(t.bookNow, style: context.medium14White),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '\$${doctor.price.toStringAsFixed(0)}${t.perHour}',
                style: context.medium14Primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DoctorStats extends StatelessWidget {
  const _DoctorStats({required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.boxShadow, blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          _Stat(value: '${doctor.experience}', label: t.running),
          const _Divider(),
          _Stat(value: '${doctor.patientStories}', label: t.ongoing),
          const _Divider(),
          _Stat(value: '${doctor.patientStories}', label: t.patients),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: context.semiBold16TextMain),
          Text(label, style: context.regular11TextSub),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 34, child: VerticalDivider());
  }
}

class _ServiceItem extends StatelessWidget {
  const _ServiceItem({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number.', style: context.medium12Primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: context.regular12TextSub)),
        ],
      ),
    );
  }
}
