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
    this.phone = '',
    this.photoUrl = '',
    this.dateOfBirth,
    this.gender = '',
    this.notificationsEnabled = true,
    this.language = 'en',
  });

  final String uid;
  final String name;
  final String email;
  final List<UserRole> roles;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String phone;
  final String photoUrl;
  final DateTime? dateOfBirth;
  final String gender;
  final bool notificationsEnabled;
  final String language;

  bool hasRole(UserRole role) {
    return roles.contains(role);
  }
}
