import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/doctor_model.dart';
import '../models/doctor_availability.dart';
import '../models/doctor_specialty.dart';

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
            (document) =>
                DoctorModel.fromMap(id: document.id, map: document.data()),
          )
          .toList(),
    );
  }

  Future<void> addDoctor(DoctorModel doctor) async {
    final document = _doctorsCollection.doc();
    await document.set(
      doctor
          .copyWith(
            id: document.id,
            specialization: DoctorSpecialty.id(doctor.specialization),
          )
          .toMap(),
    );
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    var appStrings = t;
    if (doctor.id.isEmpty) {
      throw ArgumentError(appStrings.commonUi.doctorIdRequired);
    }

    await _doctorsCollection.doc(doctor.id).update({
      'name': doctor.name,
      'specialization': DoctorSpecialty.id(doctor.specialization),
      'price': doctor.price,
      'imagePath': doctor.imagePath,
    });
  }

  Stream<DoctorModel?> watchDoctor(String id) => _doctorsCollection
      .doc(id)
      .snapshots()
      .map(
        (snapshot) => snapshot.exists
            ? DoctorModel.fromMap(id: snapshot.id, map: snapshot.data()!)
            : null,
      );

  Future<void> saveAvailability(
    String doctorId,
    DoctorAvailability availability,
  ) {
    var appStrings = t;
    if (!availability.isValid) {
      throw ArgumentError(appStrings.commonUi.invalidAvailability);
    }
    final ref = _doctorsCollection.doc(doctorId);
    return _firestore.runTransaction((transaction) async {
      var appStrings = t;
      final doctor = await transaction.get(ref);
      if ((doctor.data()?['activeBookingCount'] as num? ?? 0) > 0) {
        throw StateError(appStrings.commonUi.existingBookings);
      }
      transaction.update(ref, {'availability': availability.toMap()});
    });
  }

  Future<void> deactivateDoctor(String doctorId) async {
    var appStrings = t;
    if (doctorId.isEmpty) {
      throw ArgumentError(appStrings.commonUi.doctorIdRequired);
    }

    await updateDoctorAvailability(doctorId, false);
  }

  Future<void> updateDoctorAvailability(
    String doctorId,
    bool isAvailable,
  ) async {
    var appStrings = t;
    if (doctorId.isEmpty) {
      throw ArgumentError(appStrings.commonUi.doctorIdRequired);
    }

    await _doctorsCollection.doc(doctorId).update({
      'isAvailable': isAvailable,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
