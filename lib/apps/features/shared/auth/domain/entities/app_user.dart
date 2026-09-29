import 'user_role.dart';

class AppUser {
  const AppUser({
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

  bool hasRole(UserRole role) {
    return roles.contains(role);
  }
}