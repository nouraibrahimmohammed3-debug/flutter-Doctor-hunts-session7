import 'package:doctor_hunt/apps/features/onboarding/presentation/widgets/onboarding_artwork.dart';
import 'package:doctor_hunt/apps/features/onboarding/presentation/widgets/onboarding_fraction_box.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel item;
  const OnboardingItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: OnboardingFractionBox(alignment: Alignment.topRight),
        ),
        Positioned.fill(
          child: Column(
            children: [
              Expanded(child: OnboardingArtwork(imagePath: item.imagePath)),
              Gap(3),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: context.bold24TextMain,
              ),
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: context.regular14TextSub,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
