import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_logo.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_event.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_state.dart';
import 'package:doctor_hunt/apps/features/shared/choose_role/presentation/cubit/choose_role_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/choose_role/presentation/cubit/choose_role_state.dart';
import 'package:doctor_hunt/apps/features/shared/choose_role/presentation/widgets/role_card.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.activeRole != current.activeRole,
          listener: (context, state) {
            switch (state.activeRole) {
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
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                final user = authState.user;

                if (user == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final hasPatient =
                    user.hasRole(UserRole.patient);

                final hasAdmin =
                    user.hasRole(UserRole.admin);

                return Column(
                  children: [
                    const Spacer(),

                    const DoctorHuntLogo(),

                    const SizedBox(height: 34),

                    Text(
                      t.chooseRoleTitle,
                      textAlign: TextAlign.center,
                      style: context.bold24TextMain,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      t.chooseRoleDescription,
                      textAlign: TextAlign.center,
                      style: context.regular14TextSub,
                    ),

                    const SizedBox(height: 28),

                    BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
                      builder: (context, roleState) {
                        return Column(
                          children: [
                            if (hasPatient)
                              RoleCard(
                                title: t.patient,
                                subtitle: t.patientDescription,
                                icon: Icons.person_outline,
                                selected:
                                    roleState.selectedRole ==
                                    UserRole.patient,
                                onTap: () {
                                  context
                                      .read<ChooseRoleCubit>()
                                      .selectRole(
                                        UserRole.patient,
                                      );
                                },
                              ),

                            if (hasPatient && hasAdmin)
                              const SizedBox(height: 14),

                            if (hasAdmin)
                              RoleCard(
                                title: t.admin,
                                subtitle: t.adminDescription,
                                icon: Icons
                                    .admin_panel_settings_outlined,
                                selected:
                                    roleState.selectedRole ==
                                    UserRole.admin,
                                onTap: () {
                                  context
                                      .read<ChooseRoleCubit>()
                                      .selectRole(
                                        UserRole.admin,
                                      );
                                },
                              ),

                            if (!hasPatient && !hasAdmin)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20),
                                child: Text(
                                  'No role is assigned to this account.',
                                  style:
                                      context.regular14TextSub,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    const Spacer(flex: 2),

                    BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
                      builder: (context, roleState) {
                        final selectedRole =
                            roleState.selectedRole;

                        return PrimaryButton(
                          label: t.continueText,
                          onPressed: selectedRole == null
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                        AuthActiveRoleSelected(
                                          selectedRole,
                                        ),
                                      );
                                },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}