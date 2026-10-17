import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_specialty.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    final categories = [
      (
        appStrings.dental,
        AppAssets.imagesCategoriesDentalPng,
        Icons.medical_services,
        const Color(0xFF6055FF),
      ),
      (appStrings.cardiology, '', Icons.monitor_heart, const Color(0xFF0ACFA7)),
      (
        appStrings.ophthalmology,
        AppAssets.imagesCategoriesOphthalmologyPng,
        Icons.visibility,
        const Color(0xFFFFA351),
      ),
      (
        appStrings.generalMedicine,
        '',
        Icons.health_and_safety,
        const Color(0xFFFF646B),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          for (var index = 0; index < categories.length; index++) ...[
            if (index > 0) const SizedBox(width: 12),
            Expanded(
              child: Tooltip(
                message: categories[index].$1,
                child: Semantics(
                  label: categories[index].$1,
                  button: true,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => context.push(
                      Uri(
                        path: AppRouter.findDoctors,
                        queryParameters: {
                          'specialty': DoctorSpecialty.ids[index],
                        },
                      ).toString(),
                    ),
                    child: Container(
                      height: 82,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            categories[index].$4,
                            categories[index].$4.withValues(alpha: .72),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: categories[index].$2.isNotEmpty
                          ? Image.asset(categories[index].$2, fit: BoxFit.cover)
                          : Icon(
                              categories[index].$3,
                              color: AppColors.white,
                              size: 38,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
