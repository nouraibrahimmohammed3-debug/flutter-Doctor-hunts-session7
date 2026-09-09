import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class SelectTimeDoctorCard extends StatelessWidget {
  const SelectTimeDoctorCard({
    required this.doctor,
    super.key,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadow,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 64,
              height: 64,
              child: DoctorImage(
                imagePath: doctor.imagePath,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: context.semiBold16TextMain,
                ),
                const SizedBox(height: 3),
                Text(
                  doctor.specialization,
                  style: context.regular11TextSub,
                ),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(
                    5,
                    (index) {
                      final bool isFilled = index < doctor.rating.round();

                      return Icon(
                        isFilled ? Icons.star : Icons.star_border,
                        size: 14,
                        color: AppColors.warning,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.favorite,
            color: AppColors.danger,
            size: 21,
          ),
        ],
      ),
    );
  }
}
