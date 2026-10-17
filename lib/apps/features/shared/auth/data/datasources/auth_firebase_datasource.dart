import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

abstract interface class AuthFirebaseDataSource {
  Future<User> signInWithGoogle();
  Stream<User?> get authStateChanges;

  Future<User> signIn({required String email, required String password});

  Future<User> signUp({required String email, required String password});

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> signOut();
}

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  AuthFirebaseDataSourceImpl({required FirebaseAuth auth}) : _auth = auth;

  final FirebaseAuth _auth;
  Future<void>? _googleInitialization;

  @override
  Future<User> signInWithGoogle() async {
    var appStrings = t;
    UserCredential credential;
    if (kIsWeb) {
      credential = await _auth.signInWithPopup(GoogleAuthProvider());
    } else {
      if (defaultTargetPlatform != TargetPlatform.android &&
          defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.macOS) {
        throw StateError(appStrings.googleAuthErrors.unsupportedPlatform);
      }
      _googleInitialization ??= GoogleSignIn.instance.initialize();
      await _googleInitialization;
      final account = await GoogleSignIn.instance.authenticate();
      credential = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: account.authentication.idToken),
      );
    }
    if (credential.user == null) throw StateError(appStrings.nouser);
    return credential.user!;
  }

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<User> signIn({required String email, required String password}) async {
    var appStrings = t;
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw StateError(appStrings.nouser);
    }

    return user;
  }

  @override
  Future<User> signUp({required String email, required String password}) async {
    var appStrings = t;
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw StateError(appStrings.nouser);
    }

    return user;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _auth.sendPasswordResetEmail(email: email.trim());
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    var appStrings = t;
    final user = _auth.currentUser;

    if (user == null) {
      throw StateError(appStrings.noAuthenticatedUser);
    }

    final email = user.email;

    if (email == null || email.isEmpty) {
      throw StateError(appStrings.noEmailAddress);
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
