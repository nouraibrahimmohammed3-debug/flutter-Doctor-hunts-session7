import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user_model.dart';

abstract interface class UsersFirestoreDataSource {
  Future<AppUserModel> getUser(String uid);
  Stream<AppUserModel> watchUser(String uid);
  Future<void> syncEmail(String uid, String email);

  Future<void> createUser(AppUserModel userModel) async {}
}

class UsersFirestoreDataSourceImpl implements UsersFirestoreDataSource {
  UsersFirestoreDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Future<void> syncEmail(String uid, String email) => _firestore
      .collection('users')
      .doc(uid)
      .update({'email': email, 'updatedAt': FieldValue.serverTimestamp()});

  @override
  Stream<AppUserModel> watchUser(String uid) =>
      _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
        var appStrings = t;
        if (!snapshot.exists || snapshot.data() == null) {
          throw StateError(appStrings.commonUi.profileNotFound);
        }
        return AppUserModel.fromMap(uid: uid, map: snapshot.data()!);
      });

  @override
  Future<AppUserModel> getUser(String uid) async {
    var appStrings = t;
    final snapshot = await _firestore.collection('users').doc(uid).get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw StateError(appStrings.commonUi.profileNotFound);
    }

    return AppUserModel.fromMap(uid: uid, map: snapshot.data()!);
  }

  @override
  Future<void> createUser(AppUserModel userModel) async {
    await _firestore
        .collection('users')
        .doc(userModel.uid)
        .set(userModel.toMap());
  }
}
