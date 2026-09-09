import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingFractionBox extends StatelessWidget {
  final Alignment alignment;
  const OnboardingFractionBox({
    super.key,
    this.alignment = Alignment.bottomLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: FractionallySizedBox(
          widthFactor: 0.18,
          heightFactor: 0.38,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(999),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
