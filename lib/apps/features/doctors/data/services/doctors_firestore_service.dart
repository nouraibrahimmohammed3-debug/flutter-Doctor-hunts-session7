import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor_model.dart';
class DoctorsFirestoreService {
  DoctorsFirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>>
      get _doctorsCollection {
    return _firestore.collection('doctors');
  }
  Future<String> addDoctor(
  DoctorModel doctor,
) async {
  final document = await _doctorsCollection.add(
    doctor.toMap(),
  );

  return document.id;
}
}