import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesFirestoreService {
  FavoritesFirestoreService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Stream<Set<String>> watchFavorites(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map(
          (snapshot) => Set<String>.from(
            (snapshot.data()?['favoriteDoctorIds'] as List?)
                    ?.whereType<String>() ??
                const <String>[],
          ),
        );
  }

  Future<void> setFavorite(String userId, String doctorId, bool favorite) {
    return _firestore.collection('users').doc(userId).update({
      'favoriteDoctorIds': favorite
          ? FieldValue.arrayUnion([doctorId])
          : FieldValue.arrayRemove([doctorId]),
    });
  }
}
