import 'package:doctor_hunt/apps/features/shared/auth/domain/repositories/auth_repository.dart';

import '../entities/app_user.dart';

class SignIn {
  const SignIn(this._repository);

  final AuthRepository _repository;

  Future<AppUser> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(
      email: email,
      password: password,
    );
  }
}