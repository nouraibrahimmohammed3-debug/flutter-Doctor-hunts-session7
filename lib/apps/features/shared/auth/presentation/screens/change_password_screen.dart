import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/change_password/change_password_event.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/change_password/change_password_state.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _errorMessage(String? code) {
    var appStrings = t;
    switch (code) {
      case 'wrong-password':
      case 'invalid-credential':
        return appStrings.wrongCurrentPassword;
      case 'weak-password':
        return appStrings.passwordTooShort;
      case 'requires-recent-login':
        return appStrings.requiresRecentLogin;
      case 'too-many-requests':
        return appStrings.tooManyRequests;
      case 'network-request-failed':
        return appStrings.networkError;
      default:
        return appStrings.changePasswordFailed;
    }
  }

  InputDecoration _decoration({
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return BlocProvider(
      create: (_) => getIt<ChangePasswordBloc>(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(appStrings.changePasswordTitle)),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                    listener: (context, state) {
                      if (state.status == ChangePasswordStatus.success) {
                        _currentPasswordController.clear();
                        _newPasswordController.clear();
                        _confirmPasswordController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(appStrings.passwordChanged)),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading =
                          state.status == ChangePasswordStatus.loading;

                      return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              appStrings.changePasswordDescription,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(24),
                            TextFormField(
                              controller: _currentPasswordController,
                              obscureText: _obscureCurrent,
                              decoration: _decoration(
                                label: appStrings.currentPassword,
                                obscure: _obscureCurrent,
                                onToggle: () => setState(
                                  () => _obscureCurrent = !_obscureCurrent,
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? appStrings.requiredField
                                  : null,
                            ),
                            const Gap(16),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: _obscureNew,
                              decoration: _decoration(
                                label: appStrings.newPassword,
                                obscure: _obscureNew,
                                onToggle: () =>
                                    setState(() => _obscureNew = !_obscureNew),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return appStrings.requiredField;
                                }
                                if (value.length < 6) {
                                  return appStrings.passwordTooShort;
                                }
                                if (value == _currentPasswordController.text) {
                                  return appStrings.newPasswordMustBeDifferent;
                                }
                                return null;
                              },
                            ),
                            const Gap(16),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirm,
                              decoration: _decoration(
                                label: appStrings.confirmNewPassword,
                                obscure: _obscureConfirm,
                                onToggle: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return appStrings.requiredField;
                                }
                                if (value != _newPasswordController.text) {
                                  return appStrings.passwordsDoNotMatch;
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            if (state.status ==
                                ChangePasswordStatus.failure) ...[
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
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }

                                      context.read<ChangePasswordBloc>().add(
                                        ChangePasswordSubmitted(
                                          currentPassword:
                                              _currentPasswordController.text,
                                          newPassword:
                                              _newPasswordController.text,
                                        ),
                                      );
                                    },
                              child: isLoading
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(appStrings.changePasswordTitle),
                            ),
                          ],
                        ),
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
