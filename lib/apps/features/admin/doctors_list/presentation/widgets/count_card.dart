import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:gap/gap.dart';

class CountCard extends StatelessWidget {
  const CountCard({super.key, required this.title, required this.value});

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.alabaster,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.regular14TextSub),
            const Gap(4),
            Text('$value', style: context.semiBold16TextMain),
          ],
        ),
      ),
    );
  }
}
