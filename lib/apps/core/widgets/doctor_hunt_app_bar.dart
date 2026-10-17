import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class DoctorHuntAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DoctorHuntAppBar({
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.onBackPressed,
    super.key,
  });

  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textMain,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton && onBackPressed != null
          ? BackButton(onPressed: onBackPressed)
          : null,
      title: Text(title, style: context.bold18TextMain),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
