import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminDoctorCard extends StatelessWidget {
  const AdminDoctorCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.imagePath,
    required this.isAvailable,
    required this.onMorePressed,
  });
  final String name;
  final String specialization;
  final String imagePath;
  final bool isAvailable;
  final VoidCallback onMorePressed;
  @override
  Widget build(BuildContext context) {
    var appStrings = t;
    return Row(
      children: [
        CircleAvatar(radius: 24, backgroundImage: AssetImage(imagePath)),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: context.bold11Black),
              const Gap(4),
              Text(specialization, style: context.bold12TextSub),
              const Gap(6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.alabaster,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isAvailable ? appStrings.active : appStrings.inactive,
                  style: context.regular14TextSub.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(onPressed: onMorePressed, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
