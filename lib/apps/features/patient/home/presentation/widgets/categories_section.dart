import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      (t.dental, AppAssets.imagesCategoriesDentalPng),
      (t.cardiology, ''),
      (t.ophthalmology, AppAssets.imagesCategoriesOphthalmologyPng),
      (t.generalMedicine, ''),
    ];
    const fallbackIcons = [
      Icons.medical_services_outlined,
      Icons.favorite_outline,
      Icons.visibility_outlined,
      Icons.health_and_safety_outlined,
    ];
    const colors = [
      AppColors.primary,
      AppColors.danger,
      AppColors.warning,
      AppColors.secondary,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.categories, style: context.semiBold16TextMain),
          const SizedBox(height: 12),
          SizedBox(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == categories.length - 1 ? 0 : 10,
                  ),
                  child: SizedBox(
                    width: 75,
                    child: Column(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: category.$2.isNotEmpty
                                ? Image.asset(category.$2, fit: BoxFit.contain)
                                : DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: colors[index].withValues(alpha: .12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        fallbackIcons[index],
                                        color: colors[index],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category.$1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.regular11TextSub,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
