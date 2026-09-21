import 'package:doctor_hunt/generated/assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

import '../models/onboarding_model.dart';

abstract final class OnboardingService {
  static List<OnboardingModel> get pages => [
    OnboardingModel(
      title: t.onboardingTitleOne,
      description: t.onboardingDescriptionOne,
      imagePath: AppAssets.imagesOnboardingTrustedDoctorsJpg,
    ),
    OnboardingModel(
      title: t.onboardingTitleTwo,
      description: t.onboardingDescriptionTwo,
      imagePath: AppAssets.imagesOnboardingBestDoctorsJpg,
    ),
    OnboardingModel(
      title: t.onboardingTitleThree,
      description: t.onboardingDescriptionThree,
      imagePath: AppAssets.imagesOnboardingEasyAppointmentsJpg,
    ),
  ];
}
