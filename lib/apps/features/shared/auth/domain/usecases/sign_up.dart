import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

final class SignUp {
  const SignUp(this._repository);

  final AuthRepository _repository;

  Future<AppUser> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
  }
}
