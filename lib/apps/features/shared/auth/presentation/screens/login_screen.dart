import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_event.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_state.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.role, super.key});

  final UserRole role;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get _isAdmin => widget.role == UserRole.admin;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    var appStrings = t;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(appStrings.errors.loginFailed)));
      return;
    }

    context.read<AuthBloc>().add(
      AuthLoginRequested(email: email, password: password, role: widget.role),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.status == AuthStatus.failure ||
            state.status == AuthStatus.inactive) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? appStrings.errors.loginFailed,
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
                const Gap(64),
                Text(
                  _isAdmin
                      ? appStrings.adminLoginTitle
                      : appStrings.commonUi.welcomeBack,
                  style: context.bold24TextMain,
                ),
                const Gap(10),
                Text(appStrings.loginTitle, style: context.regular14TextSub),
                const Gap(64),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: appStrings.email,
                    hintText: appStrings.enterEmail,
                    prefixIcon: const Icon(Icons.email_outlined),
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
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.push(AppRouter.forgotPassword);
                    },
                    child: Text(appStrings.forgotPassword),
                  ),
                ),
                const Gap(10),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    final isLoading = state.status == AuthStatus.loading;

                    final showPatientOptions = !_isAdmin;

                    return Column(
                      children: [
                        if (isLoading)
                          const CircularProgressIndicator()
                        else
                          PrimaryButton(
                            label: appStrings.botnlogin,
                            onPressed: _submitLogin,
                          ),
                        if (showPatientOptions) ...[
                          const Gap(25),
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(appStrings.orDivider),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const Gap(20),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: isLoading
                                ? null
                                : () => context.read<AuthBloc>().add(
                                    const AuthGoogleLoginRequested(),
                                  ),
                            icon: const Icon(Icons.g_mobiledata, size: 28),
                            label: Text(appStrings.signInWithGoogle),
                          ),
                          const Gap(20),
                        ],
                      ],
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
