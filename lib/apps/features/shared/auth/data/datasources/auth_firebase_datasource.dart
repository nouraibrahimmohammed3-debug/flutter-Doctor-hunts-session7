import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthFirebaseDataSource {
  Stream<User?> get authStateChanges;

  Future<User> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class AuthFirebaseDataSourceImpl
    implements AuthFirebaseDataSource {
  AuthFirebaseDataSourceImpl({
    required FirebaseAuth auth,
  }) : _auth = auth;

  final FirebaseAuth _auth;

  @override
  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    final credential =
        await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw StateError(
        'Authentication returned no user.',
      );
    }

    return user;
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }
}