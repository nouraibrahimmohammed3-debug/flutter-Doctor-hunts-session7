import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> watchAuthState();

  Future<AppUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}