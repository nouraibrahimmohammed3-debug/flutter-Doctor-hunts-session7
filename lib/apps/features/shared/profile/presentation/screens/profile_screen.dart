import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_navigation_bar.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../widgets/profile_background.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    final auth = context.watch<AuthBloc>().state;
    final user = auth.user;
    final isAdmin = auth.activeRole == UserRole.admin;
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    void edit() => context.push(AppRouter.editProfile);
    return Scaffold(
      body: ProfileBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            BackButton(
                              color: Colors.white,
                              onPressed: () {
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.go(
                                    isAdmin
                                        ? AppRouter.adminDoctor
                                        : AppRouter.home,
                                  );
                                }
                              },
                            ),
                            Text(
                              appStrings.profile,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.white24,
                              foregroundImage: user.photoUrl.isEmpty
                                  ? null
                                  : NetworkImage(user.photoUrl),
                              child: const Icon(
                                Icons.person,
                                size: 52,
                                color: Colors.white,
                              ),
                            ),
                            PositionedDirectional(
                              end: 0,
                              bottom: 0,
                              child: IconButton.filled(
                                tooltip: appStrings.profileForm.photo,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.textSub,
                                  minimumSize: const Size(32, 32),
                                  padding: const EdgeInsets.all(6),
                                ),
                                icon: const Icon(Icons.camera_alt, size: 18),
                                onPressed: () => context.push(
                                  '${AppRouter.editProfile}?photo=true',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              sliver: SliverList.list(
                children: [
                  Text(
                    appStrings.profileForm.personalInfo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ProfileItem(
                    title: appStrings.profileForm.name,
                    value: user.name,
                    onEdit: edit,
                  ),
                  _ProfileItem(
                    title: appStrings.profileForm.phone,
                    value: user.phone.isEmpty ? '-' : user.phone,
                    onEdit: edit,
                  ),
                  _ProfileItem(
                    title: appStrings.profileForm.email,
                    value: user.email,
                  ),
                  _ProfileItem(
                    title: appStrings.profileForm.birthDate,
                    value: user.dateOfBirth == null
                        ? '-'
                        : DateFormat.yMMMd(
                            LocaleSettings.currentLocale.languageCode,
                          ).format(user.dateOfBirth!),
                    onEdit: edit,
                  ),
                  _ProfileItem(
                    title: appStrings.profileForm.gender,
                    value: switch (user.gender) {
                      'male' => appStrings.profileForm.male,
                      'female' => appStrings.profileForm.female,
                      'other' => appStrings.profileForm.other,
                      _ => '-',
                    },
                    onEdit: edit,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton.icon(
                      onPressed: () => context.push(
                        isAdmin ? AppRouter.adminSettings : AppRouter.settings,
                      ),
                      icon: const Icon(Icons.settings_outlined),
                      label: Text(appStrings.preferences.title),
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: edit,
                      child: Text(appStrings.continueText),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isAdmin
          ? DoctorHuntNavigationBar.admin(context: context, selectedIndex: 2)
          : DoctorHuntNavigationBar.patient(context: context, selectedIndex: 3),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({required this.title, required this.value, this.onEdit});
  final String title;
  final String value;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 8, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSub,
                  ),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            IconButton(
              onPressed: onEdit,
              tooltip: appStrings.profileForm.edit,
              icon: const Icon(Icons.edit, size: 18, color: AppColors.textSub),
            )
          else
            const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.lock_outline,
                size: 18,
                color: AppColors.textSub,
              ),
            ),
        ],
      ),
    );
  }
}
