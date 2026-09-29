import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/validate_active_user.dart';
import '../../domain/usecases/watch_auth_state.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required WatchAuthState watchAuthState,
    required SignIn signIn,
    required SignOut signOut,
    required ValidateActiveUser validateActiveUser,
  })  : _watchAuthState = watchAuthState,
        _signIn = signIn,
        _signOut = signOut,
        _validateActiveUser = validateActiveUser,
        super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthActiveRoleSelected>(_onActiveRoleSelected);
    on<AuthLogoutRequested>(_onLogoutRequested);

    on<AuthUserChanged>(_onUserChanged);
    on<AuthStreamFailed>(_onStreamFailed);
  }

  final WatchAuthState _watchAuthState;
  final SignIn _signIn;
  final SignOut _signOut;
  final ValidateActiveUser _validateActiveUser;

  StreamSubscription<AppUser?>? _authSubscription;

  bool _isLoginInProgress = false;

  /// Used to ignore the null event emitted by Firebase
  /// after we intentionally sign the user out.
  bool _ignoreNextUnauthenticatedEvent = false;

  Future<void> _onStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    if (_authSubscription != null) {
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearError: true,
      ),
    );

    _authSubscription = _watchAuthState().listen(
      (user) {
        add(
          AuthUserChanged(user),
        );
      },
      onError: (error) {
        add(
          AuthStreamFailed(
            error.toString(),
          ),
        );
      },
    );
  }

  Future<void> _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (_isLoginInProgress) {
      return;
    }

    final user = event.user;

    if (user == null) {
      if (_ignoreNextUnauthenticatedEvent) {
        _ignoreNextUnauthenticatedEvent = false;
        return;
      }

      emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
        ),
      );

      return;
    }

    await _handleAuthenticatedUser(
      user,
      emit,
    );
  }

  Future<void> _handleAuthenticatedUser(
    AppUser user,
    Emitter<AuthState> emit,
  ) async {
    // Ignore duplicate authenticated events
    // for the same user.
    if (state.status == AuthStatus.authenticated &&
        state.user?.uid == user.uid) {
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearError: true,
      ),
    );

    try {
      _validateActiveUser(user);
    } on InactiveUserException {
      _ignoreNextUnauthenticatedEvent = true;

      await _signOut();

      emit(
        state.copyWith(
          status: AuthStatus.inactive,
          user: user,
          clearRole: true,
          errorMessage: 'This account is inactive.',
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        clearRole: true,
        clearError: true,
      ),
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    _isLoginInProgress = true;

    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearError: true,
        clearRole: true,
      ),
    );

    try {
      final user = await _signIn(
        email: event.email,
        password: event.password,
      );

      try {
        _validateActiveUser(user);
      } on InactiveUserException {
        _ignoreNextUnauthenticatedEvent = true;

        await _signOut();

        emit(
          state.copyWith(
            status: AuthStatus.inactive,
            user: user,
            clearRole: true,
            errorMessage: 'This account is inactive.',
          ),
        );

        return;
      }

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          clearRole: true,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: error.toString(),
          clearRole: true,
        ),
      );
    } finally {
      _isLoginInProgress = false;
    }
  }

  void _onActiveRoleSelected(
    AuthActiveRoleSelected event,
    Emitter<AuthState> emit,
  ) {
    final user = state.user;

    if (state.status != AuthStatus.authenticated ||
        user == null) {
      return;
    }

    if (!user.hasRole(event.role)) {
      return;
    }

    emit(
      state.copyWith(
        activeRole: event.role,
        clearError: true,
      ),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearError: true,
        clearRole: true,
      ),
    );

    try {
      _ignoreNextUnauthenticatedEvent = true;

      await _signOut();

      emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
        ),
      );
    } catch (error) {
      _ignoreNextUnauthenticatedEvent = false;

      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: error.toString(),
          clearRole: true,
        ),
      );
    }
  }

  void _onStreamFailed(
    AuthStreamFailed event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: AuthStatus.failure,
        errorMessage: event.message,
        clearRole: true,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}