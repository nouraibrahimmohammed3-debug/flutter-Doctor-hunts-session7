import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({
    super.key,
    required this.title,
    required this.doctors,
    required this.onSeeAll,
    required this.onDoctorTap,
    this.largeCards = false,
  });

  final String title;
  final List<DoctorModel> doctors;
  final VoidCallback onSeeAll;
  final ValueChanged<DoctorModel> onDoctorTap;
  final bool largeCards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.4),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: context.semiBold16TextMain)),
              TextButton(
                onPressed: onSeeAll,
                child: Text(t.seeAll, style: context.regular11TextSub),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: largeCards ? 205 : 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return HomeDoctorCard(
                  doctor: doctor,
                  large: largeCards,
                  onTap: () => onDoctorTap(doctor),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDoctorCard extends StatelessWidget {
  const HomeDoctorCard({
    super.key,
    required this.doctor,
    required this.large,
    required this.onTap,
  });

  final DoctorModel doctor;
  final bool large;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: large ? 158 : 105,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.boxShadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: SizedBox(
                  width: double.infinity,
                  child: DoctorImage(imagePath: doctor.imagePath),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              doctor.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.semiBold12TextMain,
            ),
            const SizedBox(height: 2),
            Text(
              doctor.specialization,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.regular11TextSub,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (_) => const Icon(Icons.star, size: 12, color: AppColors.warning),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
