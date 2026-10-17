import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/active_role_local_datasource.dart';
import '../../../domain/usecases/sign_in.dart';
import '../../../domain/usecases/sign_out.dart';
import '../../../domain/usecases/validate_active_user.dart';
import '../../../domain/usecases/watch_auth_state.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required WatchAuthState watchAuthState,
    required SignIn signIn,
    required SignOut signOut,
    required ValidateActiveUser validateActiveUser,
    required ActiveRoleLocalDataSource activeRoleLocalDataSource,
  }) : _watchAuthState = watchAuthState,
       _signIn = signIn,
       _signOut = signOut,
       _validateActiveUser = validateActiveUser,
       _activeRoleLocalDataSource = activeRoleLocalDataSource,
       super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthGoogleLoginRequested>(
      (event, emit) => _onLoginRequested(
        const AuthLoginRequested(
          email: '',
          password: '',
          role: UserRole.patient,
          google: true,
        ),
        emit,
      ),
    );
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthUserChanged>(_onUserChanged);
    on<AuthStreamFailed>(_onStreamFailed);
  }

  final WatchAuthState _watchAuthState;
  final SignIn _signIn;
  final SignOut _signOut;
  final ValidateActiveUser _validateActiveUser;
  final ActiveRoleLocalDataSource _activeRoleLocalDataSource;

  StreamSubscription? _authSubscription;
  bool _isLoginInProgress = false;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    if (_authSubscription != null) return;

    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    _authSubscription = _watchAuthState().listen(
      (user) => add(AuthUserChanged(user: user)),
      onError: (Object error, StackTrace stackTrace) {
        add(AuthStreamFailed(message: localizedError(error)));
      },
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    var appStrings = t;
    if (_isLoginInProgress) return;

    _isLoginInProgress = true;

    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearUser: true,
        clearRole: true,
        clearError: true,
      ),
    );

    try {
      final user = event.google
          ? await _signIn.withGoogle()
          : await _signIn(email: event.email, password: event.password);

      _validateActiveUser(user);
      _validateActiveUser.validateRole(user: user, role: event.role);

      await _saveRoleSafely(userId: user.uid, role: event.role);

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          activeRole: event.role,
          clearError: true,
        ),
      );
    } on InactiveUserException {
      await _signOut();
      await _clearRoleSafely();

      emit(
        state.copyWith(
          status: AuthStatus.inactive,
          clearUser: true,
          clearRole: true,
          errorMessage: appStrings.commonUi.inactiveAccount,
        ),
      );
    } on InvalidUserRoleException {
      await _signOut();
      await _clearRoleSafely();

      emit(
        state.copyWith(
          status: AuthStatus.failure,
          clearUser: true,
          clearRole: true,
          errorMessage: _roleErrorMessage(event.role),
        ),
      );
    } catch (error) {
      if (kDebugMode && event.google) {
        final code = error is GoogleSignInException
            ? error.code.name
            : error is FirebaseException
            ? error.code
            : error.runtimeType.toString();
        debugPrint('Google sign-in failed: $code');
        if (error is GoogleSignInException &&
            error.code ==
                GoogleSignInExceptionCode.providerConfigurationError) {
          final description = error.description ?? '';
          // Only report known provider diagnostics; never log credentials or account details.
          if (description.contains('no provider dependencies')) {
            debugPrint(
              'Google provider detail: no provider dependencies found',
            );
          } else if (description.contains('Credential Manager not supported')) {
            debugPrint(
              'Google provider detail: Credential Manager not supported',
            );
          } else {
            debugPrint(
              'Google provider detail: unclassified provider configuration failure',
            );
          }
        }
      }
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          clearUser: true,
          clearRole: true,
          errorMessage: localizedError(error),
        ),
      );
    } finally {
      _isLoginInProgress = false;
    }
  }

  Future<void> _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    var appStrings = t;
    if (_isLoginInProgress) return;

    final user = event.user;

    if (user == null) {
      await _clearRoleSafely();

      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          clearRole: true,
          clearError: true,
        ),
      );
      return;
    }

    try {
      _validateActiveUser(user);

      final savedRole = _activeRoleLocalDataSource.getRole(userId: user.uid);

      UserRole? validRole;

      if (savedRole != null) {
        try {
          _validateActiveUser.validateRole(user: user, role: savedRole);
          validRole = savedRole;
        } on InvalidUserRoleException {
          await _clearRoleSafely();
        }
      }

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          activeRole: validRole,
          clearRole: validRole == null,
          clearError: true,
        ),
      );
    } on InactiveUserException {
      await _signOut();
      await _clearRoleSafely();

      emit(
        state.copyWith(
          status: AuthStatus.inactive,
          clearUser: true,
          clearRole: true,
          errorMessage: appStrings.commonUi.inactiveAccount,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          clearUser: true,
          clearRole: true,
          errorMessage: localizedError(error),
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      await _signOut();
      await _clearRoleSafely();

      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          clearRole: true,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: localizedError(error),
        ),
      );
    }
  }

  Future<void> _saveRoleSafely({
    required String userId,
    required UserRole role,
  }) async {
    try {
      await _activeRoleLocalDataSource.saveRole(userId: userId, role: role);
    } catch (_) {}
  }

  Future<void> _clearRoleSafely() async {
    try {
      await _activeRoleLocalDataSource.clearRole();
    } catch (_) {}
  }

  void _onStreamFailed(AuthStreamFailed event, Emitter<AuthState> emit) {
    if (_isLoginInProgress) return;
    emit(
      state.copyWith(status: AuthStatus.failure, errorMessage: event.message),
    );
  }

  String _roleErrorMessage(UserRole role) {
    var appStrings = t;
    switch (role) {
      case UserRole.patient:
        return appStrings.commonUi.noPatientRole;
      case UserRole.admin:
        return appStrings.commonUi.noAdminRole;
    }
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
