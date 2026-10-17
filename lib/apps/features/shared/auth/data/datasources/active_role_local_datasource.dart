import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_role.dart';

class ActiveRoleLocalDataSource {
  ActiveRoleLocalDataSource(this._preferences);

  final SharedPreferences _preferences;

  static const String _roleKey = 'active_role';
  static const String _userIdKey = 'active_role_user_id';

  Future<void> saveRole({
    required String userId,
    required UserRole role,
  }) async {
    await _preferences.setString(_userIdKey, userId);
    await _preferences.setString(_roleKey, role.name);
  }

  UserRole? getRole({required String userId}) {
    final savedUserId = _preferences.getString(_userIdKey);
    final savedRole = _preferences.getString(_roleKey);

    if (savedUserId != userId || savedRole == null) {
      return null;
    }

    for (final role in UserRole.values) {
      if (role.name == savedRole) {
        return role;
      }
    }

    return null;
  }

  Future<void> clearRole() async {
    await _preferences.remove(_roleKey);
    await _preferences.remove(_userIdKey);
  }
}
