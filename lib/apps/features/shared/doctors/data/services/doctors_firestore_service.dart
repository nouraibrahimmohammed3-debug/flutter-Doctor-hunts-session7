import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/doctor_model.dart';

class DoctorsFirestoreService {
  DoctorsFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _doctorsCollection =>
      _firestore.collection('doctors');

  Stream<List<DoctorModel>> watchDoctors() {
    return _doctorsCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (document) => DoctorModel.fromMap(
                  id: document.id,
                  map: document.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> addDoctor(DoctorModel doctor) async {
    final document = _doctorsCollection.doc();
    await document.set(doctor.copyWith(id: document.id).toMap());
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    if (doctor.id.isEmpty) {
      throw ArgumentError('Doctor id is required for update.');
    }

    await _doctorsCollection.doc(doctor.id).update(doctor.toMap());
  }

  Future<void> deleteDoctor(String doctorId) async {
    if (doctorId.isEmpty) {
      throw ArgumentError('Doctor id is required for delete.');
    }

    await _doctorsCollection.doc(doctorId).delete();
  }

  Future<void> updateDoctorAvailability(
    String doctorId,
    bool isAvailable,
  ) async {
    if (doctorId.isEmpty) {
      throw ArgumentError('Doctor id is required.');
    }

    await _doctorsCollection.doc(doctorId).update({
      'isAvailable': isAvailable,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
