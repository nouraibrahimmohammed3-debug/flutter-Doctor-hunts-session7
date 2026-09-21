import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_logo.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/auth/data/models/user_role.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/cubit/choose_role_cubit.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/cubit/choose_role_state.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/widgets/role_card.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChooseRoleCubit(),
      child: const _ChooseRoleView(),
    );
  }
}

class _ChooseRoleView extends StatelessWidget {
  const _ChooseRoleView();

  @override
  Widget build(BuildContext context) {
    final appStrings = t;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.activeRole != current.activeRole,
      listener: (context, authState) {
        switch (authState.activeRole) {
          case UserRole.patient:
            context.go(AppRouter.home);
            break;
          case UserRole.admin:
            context.go(AppRouter.adminDoctor);
            break;
          case null:
            break;
        }
      },
      child: Scaffold(
        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              DoctorHuntLogo(),
              const SizedBox(height: 34),
              Text(
                t.chooseRoleTitle,
                textAlign: TextAlign.center,
                style: context.bold24TextMain,
              ),
              const SizedBox(height: 10),
              Text(
                appStrings.chooseRoleDescription,
                textAlign: TextAlign.center,
                style: context.regular14TextSub,
              ),
              const SizedBox(height: 28),
              BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (context.read<AuthBloc>().state.user?.hasRole(UserRole.patient) ?? false)
                        RoleCard(
                          title: appStrings.patient,
                          subtitle: appStrings.patientDescription,
                          icon: Icons.person_outline,
                          selected: state.selectedRole == UserRole.patient,
                          onTap: () {
                            context.read<ChooseRoleCubit>().selectRole(UserRole.patient);
                          },
                        ),
                      if ((context.read<AuthBloc>().state.user?.hasRole(UserRole.patient) ?? false) &&
                          (context.read<AuthBloc>().state.user?.hasRole(UserRole.admin) ?? false))
                        const SizedBox(height: 14),
                      if (context.read<AuthBloc>().state.user?.hasRole(UserRole.admin) ?? false)
                        RoleCard(
                          title: appStrings.admin,
                          subtitle: appStrings.adminDescription,
                          icon: Icons.admin_panel_settings_outlined,
                          selected: state.selectedRole == UserRole.admin,
                          onTap: () {
                            context.read<ChooseRoleCubit>().selectRole(UserRole.admin);
                          },
                        ),
                    ],
                  );
                },
              ),
              const Spacer(flex: 2),
              PrimaryButton(
                label: appStrings.continueText,
                onPressed: () {
                  final selectedRole = context
                      .read<ChooseRoleCubit>()
                      .state
                      .selectedRole;

                  if (selectedRole == null) {
                    return;
                  }

                  final authBloc = context.read<AuthBloc>();
                  final user = authBloc.state.user;
                  if (user == null || !user.hasRole(selectedRole)) {
                    return;
                  }

                  authBloc.add(AuthActiveRoleSelected(selectedRole));
                },
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
