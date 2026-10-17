import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_up/sign_up_event.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required UserRole role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (_) => getIt<SignUpBloc>(),
      child: const _SignUpForm(),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm();

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return BlocListener<SignUpBloc, SignUpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SignUpStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? appStrings.commonUi.signupFailed,
              ),
            ),
          );
        } else if (state.status == SignUpStatus.success) {
          context.pop();
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
                  appStrings.commonUi.joinUs,
                  style: context.bold24TextMain,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                Text(appStrings.signUpTitle, style: context.regular14TextSub),
                const Gap(64),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: appStrings.fullName,
                    hintText: appStrings.enterFullName,
                    prefixIcon: const Icon(Icons.person_outline),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const Gap(20),
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
                const Gap(25),
                BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == SignUpStatus.loading) {
                      return const CircularProgressIndicator();
                    }

                    return PrimaryButton(
                      label: appStrings.signUp,
                      onPressed: () {
                        final name = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text;

                        if (name.isEmpty || email.isEmpty || password.isEmpty) {
                          return;
                        }

                        context.read<SignUpBloc>().add(
                          SignUpSubmitted(
                            name: name,
                            email: email,
                            password: password,
                          ),
                        );
                      },
                    );
                  },
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appStrings.alreadyHaveAccount,
                      style: context.regular14TextSub,
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(appStrings.botnlogin),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
