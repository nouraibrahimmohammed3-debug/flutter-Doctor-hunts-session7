import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/app_user.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthStarted extends AuthEvent {
  const AuthStarted();
}

final class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({
    required this.email,
    required this.password,
    required this.role,
    this.google = false,
  });

  final String email;
  final String password;
  final UserRole role;
  final bool google;
}

final class AuthGoogleLoginRequested extends AuthEvent {
  const AuthGoogleLoginRequested();
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

final class AuthUserChanged extends AuthEvent {
  const AuthUserChanged({required this.user});

  final AppUser? user;
}

final class AuthStreamFailed extends AuthEvent {
  const AuthStreamFailed({required this.message});

  final String message;
}
