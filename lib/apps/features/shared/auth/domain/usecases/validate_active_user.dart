import '../entities/app_user.dart';

class ValidateActiveUser {
  const ValidateActiveUser();

  void call(AppUser user) {
    if (!user.isActive) {
      throw const InactiveUserException();
    }
  }
}

class InactiveUserException implements Exception {
  const InactiveUserException();
}