import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/app_user.dart';

import '../../domain/entities/user_role.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class AuthActiveRoleSelected extends AuthEvent {
  const AuthActiveRoleSelected(this.role);

  final UserRole role;
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final AppUser? user;
}

class AuthStreamFailed extends AuthEvent {
  const AuthStreamFailed(this.message);

  final String message;
}