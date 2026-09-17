import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class DoctorHuntAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DoctorHuntAppBar({
    required this.title,
    this.showBackButton = false,
    this.actions,
    super.key,
  });

  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      automaticallyImplyLeading: showBackButton,
      title: Text(
        title,
        style: context.semiBold16TextMain.copyWith(color: AppColors.white),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
