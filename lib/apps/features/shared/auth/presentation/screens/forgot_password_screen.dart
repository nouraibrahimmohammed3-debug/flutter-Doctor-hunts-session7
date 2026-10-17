import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String _errorMessage(String? code) {
    var appStrings = t;
    switch (code) {
      case 'invalid-email':
        return appStrings.invalidEmail;
      case 'too-many-requests':
        return appStrings.tooManyRequests;
      case 'network-request-failed':
        return appStrings.networkError;
      default:
        return appStrings.resetPasswordFailed;
    }
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return BlocProvider(
      create: (_) => getIt<ForgotPasswordBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Form(
                  key: _formKey,
                  child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                    listener: (context, state) {
                      if (state.status == ForgotPasswordStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(appStrings.resetEmailSent)),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading =
                          state.status == ForgotPasswordStatus.loading;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(Icons.lock_reset, size: 72),
                          const Gap(24),
                          Text(
                            appStrings.resetPasswordTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const Gap(12),
                          Text(
                            appStrings.resetPasswordDescription,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(32),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.email],
                            decoration: InputDecoration(
                              labelText: appStrings.email,
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              final email = value?.trim() ?? '';

                              if (email.isEmpty) {
                                return appStrings.requiredField;
                              }

                              if (!RegExp(
                                r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                              ).hasMatch(email)) {
                                return appStrings.invalidEmail;
                              }

                              return null;
                            },
                            onFieldSubmitted: (_) {
                              if (!isLoading &&
                                  _formKey.currentState!.validate()) {
                                context.read<ForgotPasswordBloc>().add(
                                  ForgotPasswordSubmitted(
                                    email: _emailController.text,
                                  ),
                                );
                              }
                            },
                          ),
                          const Gap(20),
                          if (state.status == ForgotPasswordStatus.failure) ...[
                            Text(
                              _errorMessage(state.errorCode),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(12),
                          ],
                          FilledButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<ForgotPasswordBloc>().add(
                                        ForgotPasswordSubmitted(
                                          email: _emailController.text,
                                        ),
                                      );
                                    }
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(appStrings.sendResetLink),
                          ),
                          const Gap(12),
                          TextButton(
                            onPressed: isLoading ? null : () => context.pop(),
                            child: Text(appStrings.cancel),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
