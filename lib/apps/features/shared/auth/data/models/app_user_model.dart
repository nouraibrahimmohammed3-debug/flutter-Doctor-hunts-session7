import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/app_user.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.roles,
    required super.isActive,
    super.createdAt,
    super.updatedAt,
    super.phone,
    super.photoUrl,
    super.dateOfBirth,
    super.gender,
    super.notificationsEnabled,
    super.language,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone, 'photoUrl': photoUrl, 'gender': gender,
      'dateOfBirth': dateOfBirth == null
          ? null
          : Timestamp.fromDate(dateOfBirth!),
      'notificationsEnabled': notificationsEnabled, 'language': language,
      'roles': roles.map((role) => role.name).toList(), // حفظ الـ Enum كنص
      'isActive': isActive,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': updatedAt != null
          ? Timestamp.fromDate(updatedAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  factory AppUserModel.fromMap({
    required String uid,
    required Map<String, dynamic> map,
  }) {
    return AppUserModel(
      uid: uid,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      photoUrl: map['photoUrl'] as String? ?? '',
      gender: map['gender'] as String? ?? '',
      dateOfBirth: (map['dateOfBirth'] as Timestamp?)?.toDate(),
      notificationsEnabled: map['notificationsEnabled'] as bool? ?? true,
      language: map['language'] as String? ?? 'en',
      roles:
          (map['roles'] as List<dynamic>?)
              ?.map(
                (role) => UserRole.values.firstWhere(
                  (e) => e.name == role,
                  orElse: () => UserRole.patient,
                ),
              )
              .toList() ??
          const [UserRole.patient],
      isActive: map['isActive'] as bool? ?? true,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }
}
