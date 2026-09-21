import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onSearchTap});
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.homeGreeting, style: context.regular12White),
                    const SizedBox(height: 3),
                    Text(t.findYourDoctor, style: context.bold20White),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.white,
                child: Icon(Icons.person_outline, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            onTap: onSearchTap,
            decoration: InputDecoration(
              hintText: t.searchDoctor,
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: const Icon(Icons.close, size: 18),
              filled: true,
              fillColor: AppColors.white,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
