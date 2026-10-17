import 'package:doctor_hunt/generated/assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

import '../models/onboarding_model.dart';

abstract final class OnboardingService {
  static List<OnboardingModel> get pages {
    var appStrings = t;
    return [
      OnboardingModel(
        title: appStrings.onboardingTitleOne,
        description: appStrings.onboardingDescriptionOne,
        imagePath: AppAssets.imagesOnboardingTrustedDoctorsJpg,
      ),
      OnboardingModel(
        title: appStrings.onboardingTitleTwo,
        description: appStrings.onboardingDescriptionTwo,
        imagePath: AppAssets.imagesOnboardingBestDoctorsJpg,
      ),
      OnboardingModel(
        title: appStrings.onboardingTitleThree,
        description: appStrings.onboardingDescriptionThree,
        imagePath: AppAssets.imagesOnboardingEasyAppointmentsJpg,
      ),
    ];
  }
}
