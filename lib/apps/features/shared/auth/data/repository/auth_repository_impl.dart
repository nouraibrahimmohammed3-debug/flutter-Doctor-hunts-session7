import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/app_user.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/repositories/auth_repository.dart';

import '../datasources/auth_firebase_datasource.dart';
import '../datasources/users_firestore_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthFirebaseDataSource authDataSource,
    required UsersFirestoreDataSource usersDataSource,
  })  : _authDataSource = authDataSource,
        _usersDataSource = usersDataSource;

  final AuthFirebaseDataSource _authDataSource;
  final UsersFirestoreDataSource _usersDataSource;

  @override
  Stream<AppUser?> watchAuthState() {
    return _authDataSource.authStateChanges.asyncMap(
      (firebaseUser) async {
        if (firebaseUser == null) {
          return null;
        }

        return _usersDataSource.getUser(
          firebaseUser.uid,
        );
      },
    );
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

    return _usersDataSource.getUser(
      firebaseUser.uid,
    );
  }

  @override
  Future<void> signOut() {
    return _authDataSource.signOut();
  }
}