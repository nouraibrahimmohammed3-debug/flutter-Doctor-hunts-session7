import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../auth/domain/entities/app_user.dart';
import '../../doctors/data/services/doctor_photo_service.dart';

class ProfileService {
  ProfileService({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required DoctorPhotoService photos,
  }) : _db = firestore,
       _auth = auth,
       _photos = photos;
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  final DoctorPhotoService _photos;

  Future<String?> pickPhoto() =>
      _photos.pickAndUpload(userId: _auth.currentUser!.uid);

  Future<void> save({
    required AppUser user,
    required String name,
    required String phone,
    required String photoUrl,
    required DateTime? birthDate,
    required String gender,
  }) async {
    var appStrings = t;
    final current = _auth.currentUser;
    if (current == null || current.uid != user.uid) {
      throw StateError(appStrings.commonUi.signInAgain);
    }
    await _db.collection('users').doc(user.uid).update({
      'name': name.trim(),
      'phone': phone.trim(),
      'photoUrl': photoUrl,
      'gender': gender,
      'dateOfBirth': birthDate == null ? null : Timestamp.fromDate(birthDate),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> setLanguage(String language) =>
      _db.collection('users').doc(_auth.currentUser!.uid).update({
        'language': language,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<void> setNotifications(bool enabled) async {
    var appStrings = t;
    final messaging = FirebaseMessaging.instance;
    if (enabled) {
      final permission = await messaging.requestPermission();
      if (permission.authorizationStatus == AuthorizationStatus.denied) {
        throw StateError(appStrings.commonUi.notificationPermission);
      }
    }
    final currentToken = await messaging.getToken();
    await _db.collection('users').doc(_auth.currentUser!.uid).update({
      'notificationsEnabled': enabled,
      if (currentToken != null)
        'notificationTokens': enabled
            ? FieldValue.arrayUnion([currentToken])
            : FieldValue.arrayRemove([currentToken]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await messaging.setAutoInitEnabled(enabled);
    if (!enabled) await messaging.deleteToken();
  }
}
