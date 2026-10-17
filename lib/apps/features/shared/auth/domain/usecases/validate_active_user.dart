import '../entities/app_user.dart';
import '../entities/user_role.dart';

class ValidateActiveUser {
  const ValidateActiveUser();

  void call(AppUser user) {
    if (!user.isActive) {
      throw const InactiveUserException();
    }
  }

  void validateRole({required AppUser user, required UserRole role}) {
    if (!user.hasRole(role)) {
      throw const InvalidUserRoleException();
    }
  }
}

class InactiveUserException implements Exception {
  const InactiveUserException();
}

class InvalidUserRoleException implements Exception {
  const InvalidUserRoleException();
}
