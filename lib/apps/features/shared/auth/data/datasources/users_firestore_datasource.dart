import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user_model.dart';

abstract interface class UsersFirestoreDataSource {
  Future<AppUserModel> getUser(String uid);
}

class UsersFirestoreDataSourceImpl implements UsersFirestoreDataSource {
  UsersFirestoreDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Future<AppUserModel> getUser(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw StateError('User profile was not found.');
    }

    return AppUserModel.fromMap(uid: uid, map: snapshot.data()!);
  }
}
