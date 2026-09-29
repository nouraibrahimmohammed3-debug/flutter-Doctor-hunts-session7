import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/app_user.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  inactive,
  failure,
}

class AuthState {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.activeRole,
    this.errorMessage,
  });

  final AuthStatus status;
  final AppUser? user;
  final UserRole? activeRole;
  final String? errorMessage;

  bool get isAuthenticated =>
      status == AuthStatus.authenticated && user != null;

  AuthState copyWith({
    AuthStatus? status,
    AppUser? user,
    UserRole? activeRole,
    String? errorMessage,
    bool clearUser = false,
    bool clearRole = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      activeRole: clearRole
          ? null
          : activeRole ?? this.activeRole,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}