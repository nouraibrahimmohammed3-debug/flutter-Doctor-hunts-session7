import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_event.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_logo.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appStrings = t;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(AppRouter.chooseRole);
          return;
        }

        if (state.status == AuthStatus.failure ||
            state.status == AuthStatus.inactive) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Login failed.',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DoctorHuntLogo(
                  appStrings: appStrings.welcome,
                ),
                const Gap(10),
                Text(
                  'Login to your account',
                  style: context.regular14TextSub,
                ),
                const Gap(20),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: appStrings.email,
                    hintText: appStrings.enterEmail,
                    prefixIcon:
                        const Icon(Icons.email_outlined),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const Gap(20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: appStrings.password,
                    hintText: appStrings.enterPassword,
                    prefixIcon:
                        const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const Gap(20),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == AuthStatus.loading) {
                      return const CircularProgressIndicator();
                    }

                    return PrimaryButton(
                      label: appStrings.botnlogin,
                      onPressed: () {
                        final email =
                            _emailController.text.trim();
                        final password =
                            _passwordController.text;

                        if (email.isEmpty ||
                            password.isEmpty) {
                          return;
                        }

                        context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                email: email,
                                password: password,
                              ),
                            );
                      },
                    );
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

class AdminLoginScreen extends LoginScreen {
  const AdminLoginScreen({super.key});
}