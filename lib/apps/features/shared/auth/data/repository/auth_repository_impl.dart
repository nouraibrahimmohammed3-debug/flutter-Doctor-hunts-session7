import 'dart:async';
import 'package:doctor_hunt/apps/features/shared/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:doctor_hunt/apps/features/shared/auth/data/datasources/users_firestore_datasource.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/app_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthFirebaseDataSource authDataSource,
    required UsersFirestoreDataSource usersDataSource,
  }) : _authDataSource = authDataSource,
       _usersDataSource = usersDataSource;

  final AuthFirebaseDataSource _authDataSource;
  final UsersFirestoreDataSource _usersDataSource;

  @override
  Future<AppUser> signInWithGoogle() async {
    final firebaseUser = await _authDataSource.signInWithGoogle();
    try {
      final user = await _usersDataSource.getUser(firebaseUser.uid);
      if (firebaseUser.email != null && user.email != firebaseUser.email) {
        await _usersDataSource.syncEmail(firebaseUser.uid, firebaseUser.email!);
        return _usersDataSource.getUser(firebaseUser.uid);
      }
      return user;
    } on StateError {
      final user = AppUserModel(
        uid: firebaseUser.uid,
        name:
            firebaseUser.displayName ??
            firebaseUser.email?.split('@').first ??
            '',
        email: firebaseUser.email ?? '',
        photoUrl: firebaseUser.photoURL ?? '',
        roles: const [UserRole.patient],
        isActive: true,
      );
      await _usersDataSource.createUser(user);
      return user;
    }
  }

  @override
  Future<AppUser> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final firebaseUser = await _authDataSource.signUp(
      email: email,
      password: password,
    );

    final now = DateTime.now();

    final userModel = AppUserModel(
      uid: firebaseUser.uid,
      name: name,
      email: email,
      roles: const [UserRole.patient],
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    await _usersDataSource.createUser(userModel);

    return userModel;
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final firebaseUser = await _authDataSource.signIn(
      email: email,
      password: password,
    );

    final user = await _usersDataSource.getUser(firebaseUser.uid);
    if (firebaseUser.email != null && user.email != firebaseUser.email) {
      await _usersDataSource.syncEmail(firebaseUser.uid, firebaseUser.email!);
      return _usersDataSource.getUser(firebaseUser.uid);
    }
    return user;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _authDataSource.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _authDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> signOut() => _authDataSource.signOut();

  @override
  Stream<AppUser?> watchAuthState() {
    late StreamController<AppUser?> controller;
    StreamSubscription? authSubscription;
    StreamSubscription<AppUserModel>? profileSubscription;
    var generation = 0;
    controller = StreamController<AppUser?>(
      onListen: () {
        authSubscription = _authDataSource.authStateChanges.listen(
          (firebaseUser) async {
            final current = ++generation;
            await profileSubscription?.cancel();
            profileSubscription = null;
            if (current != generation || controller.isClosed) return;
            if (firebaseUser == null) {
              controller.add(null);
            } else {
              profileSubscription = _usersDataSource
                  .watchUser(firebaseUser.uid)
                  .listen(
                    (user) {
                      if (current == generation && !controller.isClosed) {
                        controller.add(user);
                      }
                    },
                    onError: (Object error, StackTrace stack) {
                      if (current == generation && !controller.isClosed) {
                        controller.addError(error, stack);
                      }
                    },
                  );
            }
          },
          onError: (Object error, StackTrace stack) =>
              controller.addError(error, stack),
        );
      },
      onCancel: () async {
        generation++;
        await authSubscription?.cancel();
        await profileSubscription?.cancel();
      },
    );
    return controller.stream;
  }
}
