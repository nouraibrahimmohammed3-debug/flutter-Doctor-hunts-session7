import "user_role.dart";

class AppUserModel {
  const AppUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.roles,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  final String uid;
  final String name;
  final String email;
  final List<UserRole> roles;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  bool hasRole(UserRole role) => roles.contains(role);

  factory AppUserModel.fromMap({required String uid, required Map<String, dynamic> map}) {
    final rawRoles = (map['roles'] as List?) ?? const [];
    final roles = rawRoles
        .map((value) => UserRoleX.fromValue(value.toString()))
        .whereType<UserRole>()
        .toList(growable: false);

    return AppUserModel(
      uid: uid,
      name: (map['name'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      roles: roles,
      isActive: map['isActive'] as bool? ?? false,
      createdAt: UserRoleX.readDate(map['createdAt']),
      updatedAt: UserRoleX.readDate(map['updatedAt']),
    );
  }
}

extension UserRoleX on UserRole {
  static UserRole? fromValue(String value) {
    switch (value) {
      case 'patient':
        return UserRole.patient;
      case 'admin':
        return UserRole.admin;
      default:
        return null;
    }
  }

  static DateTime? readDate(dynamic value) {
    if (value is DateTime) return value;
    final dynamic toDate = value;
    if (toDate != null) {
      try {
        final result = toDate.toDate();
        if (result is DateTime) return result;
      } catch (_) {}
    }
    return null;
  }
}
