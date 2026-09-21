import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../data/models/app_user_model.dart";
import "../../data/models/user_role.dart";
import "../../data/repository/auth_repository.dart";

sealed class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});
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

class _AuthFirebaseUserChanged extends AuthEvent {
  const _AuthFirebaseUserChanged(this.user);
  final User? user;
}

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
  final AppUserModel? user;
  final UserRole? activeRole;
  final String? errorMessage;

  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;

  AuthState copyWith({
    AuthStatus? status,
    AppUserModel? user,
    UserRole? activeRole,
    String? errorMessage,
    bool clearUser = false,
    bool clearRole = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      activeRole: clearRole ? null : activeRole ?? this.activeRole,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthActiveRoleSelected>(_onActiveRoleSelected);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<_AuthFirebaseUserChanged>(_onFirebaseUserChanged);
    _authSubscription = _repository.authStateChanges.listen(
      (user) => add(_AuthFirebaseUserChanged(user)),
    );
  }

  final AuthRepository _repository;
  late final StreamSubscription<User?> _authSubscription;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
      return;
    }

    await _loadFirebaseUser(firebaseUser, emit);
  }

  Future<void> _onFirebaseUserChanged(
    _AuthFirebaseUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user == null) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
      return;
    }

    // Ignore the transient Firebase callback during an active login operation.
    if (state.status == AuthStatus.loading) return;
    await _loadFirebaseUser(event.user!, emit);
  }

  Future<void> _loadFirebaseUser(User firebaseUser, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));
    try {
      final user = await _repository.getCurrentUser(firebaseUser.uid);
      if (!user.isActive) {
        await _repository.signOut();
        emit(state.copyWith(
          status: AuthStatus.inactive,
          user: user,
          clearRole: true,
          errorMessage: 'This account is inactive.',
        ));
        return;
      }

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        clearRole: true,
        clearError: true,
      ));
    } catch (error) {
      await _repository.signOut();
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: error.toString(),
        clearRole: true,
      ));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true, clearRole: true));
    try {
      final user = await _repository.signIn(
        email: event.email,
        password: event.password,
      );

      if (!user.isActive) {
        await _repository.signOut();
        emit(state.copyWith(
          status: AuthStatus.inactive,
          user: user,
          clearRole: true,
          errorMessage: 'This account is inactive.',
        ));
        return;
      }

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        clearRole: true,
        clearError: true,
      ));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: error.message ?? 'Login failed.',
        clearRole: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: error.toString(),
        clearRole: true,
      ));
    }
  }

  void _onActiveRoleSelected(
    AuthActiveRoleSelected event,
    Emitter<AuthState> emit,
  ) {
    final user = state.user;
    if (state.status != AuthStatus.authenticated || user == null) return;
    if (!user.hasRole(event.role)) return;
    emit(state.copyWith(activeRole: event.role, clearError: true));
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.signOut();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    return super.close();
  }
}
