import 'package:flutter/material.dart';

import 'package:doctor_hunt/apps/core/themes/app_colors.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    required this.imagePath,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String imagePath;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return const ColoredBox(
        color: AppColors.secondaryLight,
        child: Center(
          child: Icon(
            Icons.person_outline,
            size: 52,
            color: AppColors.secondary,
          ),
        ),
      );
    }

    return Image.asset(
      imagePath,
      fit: fit,
      alignment: Alignment.topCenter,
      errorBuilder: (_, __, ___) {
        return const ColoredBox(
          color: AppColors.secondaryLight,
          child: Center(
            child: Icon(Icons.person_outline, color: AppColors.secondary),
          ),
        );
      },
    );
  }
}
