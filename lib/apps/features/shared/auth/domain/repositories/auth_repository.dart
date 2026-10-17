import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser> signInWithGoogle();
  Stream<AppUser?> watchAuthState();

  Future<AppUser> signIn({required String email, required String password});

  Future<AppUser> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> signOut();
}
