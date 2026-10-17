import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_navigation_bar.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_event.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_state.dart';
import 'package:doctor_hunt/apps/features/shared/profile/data/profile_service.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../widgets/profile_background.dart';

Future<void> confirmLogout(BuildContext context) async {
  final yes = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      var appStrings = dialogContext.t;
      return AlertDialog(
        title: Text(appStrings.preferences.logout),
        content: Text(appStrings.preferences.logoutQuestion),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(appStrings.preferences.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(appStrings.preferences.logout),
          ),
        ],
      );
    },
  );
  if (yes == true && context.mounted) {
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }
}

class SettingsCubit extends Cubit<bool> {
  SettingsCubit() : super(false);
  Future<void> run(
    Future<void> Function() operation,
    BuildContext context,
  ) async {
    if (state) return;
    emit(true);
    try {
      await operation();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(localizedError(error))));
      }
    } finally {
      if (!isClosed) emit(false);
    }
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, auth) {
          final user = auth.user;
          if (user == null) return const SizedBox.shrink();
          return BlocBuilder<SettingsCubit, bool>(
            builder: (context, busy) {
              final service = getIt<ProfileService>();
              final cubit = context.read<SettingsCubit>();
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xFFEAF8FF),
                  title: Text(appStrings.preferences.title),
                ),
                bottomNavigationBar: auth.activeRole == UserRole.admin
                    ? DoctorHuntNavigationBar.admin(
                        context: context,
                        selectedIndex: 2,
                      )
                    : DoctorHuntNavigationBar.patient(
                        context: context,
                        selectedIndex: 3,
                      ),
                body: ProfileBackground(
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: user.photoUrl.isEmpty
                                ? null
                                : NetworkImage(user.photoUrl),
                            child: user.photoUrl.isEmpty
                                ? const Icon(Icons.person_outline)
                                : null,
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: AppColors.textSub,
                          ),
                          onTap: busy
                              ? null
                              : () => context.push(AppRouter.profile),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(appStrings.preferences.security),
                      if (auth.activeRole == UserRole.admin)
                        ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: Text(appStrings.location),
                          onTap: busy
                              ? null
                              : () => context.push(AppRouter.clinicLocation),
                        ),
                      ListTile(
                        leading: const _SettingsIcon(
                          icon: Icons.lock_outline,
                          color: Color(0xFFFF6268),
                        ),
                        title: Text(appStrings.changePasswordTitle),
                        onTap: busy
                            ? null
                            : () => context.push(AppRouter.changePassword),
                      ),
                      SwitchListTile(
                        secondary: const _SettingsIcon(
                          icon: Icons.notifications_outlined,
                          color: Color(0xFF219C61),
                        ),
                        title: Text(appStrings.preferences.notifications),
                        value: user.notificationsEnabled,
                        onChanged: busy
                            ? null
                            : (enabled) => cubit.run(
                                () => service.setNotifications(enabled),
                                context,
                              ),
                      ),
                      const Divider(color: Color(0xFFE6EAF1)),
                      ListTile(
                        leading: const _SettingsIcon(
                          icon: Icons.privacy_tip_outlined,
                          color: Color(0xFFFFA14A),
                        ),
                        title: Text(appStrings.privacyPolicy.title),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: AppColors.textSub,
                        ),
                        onTap: () => context.push(AppRouter.privacyPolicy),
                      ),
                      const SizedBox(height: 24),
                      Text(appStrings.preferences.more),
                      ListTile(
                        title: Text(appStrings.preferences.language),
                        trailing: DropdownButton<String>(
                          value: user.language == 'ar' ? 'ar' : 'en',
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(appStrings.commonUi.english),
                            ),
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text(appStrings.commonUi.arabic),
                            ),
                          ],
                          onChanged: busy
                              ? null
                              : (language) {
                                  if (language != null) {
                                    cubit.run(
                                      () => service.setLanguage(language),
                                      context,
                                    );
                                  }
                                },
                        ),
                      ),
                      const Divider(color: Color(0xFFE6EAF1)),
                      _BuildVersion(),
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                          backgroundColor: const Color(0xFFFFF3F3),
                          side: BorderSide.none,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: busy ? null : () => confirmLogout(context),
                        icon: const Icon(Icons.logout),
                        label: Text(appStrings.preferences.logout),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  const _SettingsIcon({required this.icon, required this.color});
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: 18,
    backgroundColor: color,
    child: Icon(icon, size: 18, color: Colors.white),
  );
}

class _BuildVersion extends StatefulWidget {
  @override
  State<_BuildVersion> createState() => _BuildVersionState();
}

class _BuildVersionState extends State<_BuildVersion> {
  late final Future<PackageInfo> _info = PackageInfo.fromPlatform();
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return ListTile(
      title: Text(appStrings.preferences.buildVersion),
      trailing: FutureBuilder<PackageInfo>(
        future: _info,
        builder: (context, snapshot) => Text(
          snapshot.hasError
              ? appStrings.preferences.versionUnavailable
              : snapshot.hasData
              ? '${snapshot.data!.version}+${snapshot.data!.buildNumber}'
              : appStrings.commonUi.loading,
          style: const TextStyle(fontSize: 12, color: AppColors.textSub),
        ),
      ),
    );
  }
}
