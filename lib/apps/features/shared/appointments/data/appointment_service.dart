import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/domain/entities/app_user.dart';
import '../../doctors/data/models/doctor_model.dart';
import '../../doctors/data/models/doctor_specialty.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

DateTime riyadhNow() => DateTime.now().toUtc().add(const Duration(hours: 3));
DateTime riyadhTime(DateTime utc) => utc.toUtc().add(const Duration(hours: 3));

class Appointment {
  Appointment({required this.id, required this.data});
  final String id;
  final Map<String, dynamic> data;
  String get doctorId => data['doctorId'] as String;
  String get patientId => data['patientId'] as String;
  String get doctorName => data['doctorName'] as String;
  String get specialty => data['specialization'] as String;
  String get specialtyLabel => DoctorSpecialty.label(specialty);
  String get patientName => data['patientName'] as String;
  String get patientEmail => data['patientEmail'] as String;
  double get fee => (data['fee'] as num).toDouble();
  DateTime get startsAt => (data['startsAt'] as Timestamp).toDate();
  DateTime get endsAt => (data['endsAt'] as Timestamp).toDate();
  String get slotId => data['slotId'] as String;
  int? get reviewRating => data['reviewRating'] as int?;
  String get reviewComment => data['reviewComment'] as String? ?? '';
  AppointmentStatus get status =>
      AppointmentStatus.values.byName(data['status'] as String);
}

class AppointmentService {
  AppointmentService({required FirebaseFirestore firestore}) : _db = firestore;
  final FirebaseFirestore _db;

  Future<void> submitReview({
    required String appointmentId,
    required String patientId,
    required int rating,
    required String comment,
  }) async {
    var appStrings = t;
    final text = comment.trim();
    if (rating < 1 || rating > 5 || text.length > 1000) {
      throw ArgumentError(appStrings.commonUi.invalidReview);
    }
    final ref = _db.collection('appointments').doc(appointmentId);
    final reviewRef = _db.collection('reviews').doc(appointmentId);
    await _db.runTransaction((transaction) async {
      var appStrings = t;
      final snapshot = await transaction.get(ref);
      final existingReview = await transaction.get(reviewRef);
      if (!snapshot.exists) {
        throw StateError(appStrings.commonUi.appointmentNotFound);
      }
      final appointment = Appointment(id: snapshot.id, data: snapshot.data()!);
      if (appointment.patientId != patientId ||
          appointment.status != AppointmentStatus.completed) {
        throw StateError(appStrings.commonUi.completedReviewOnly);
      }
      if (appointment.reviewRating != null || existingReview.exists) {
        throw StateError(appStrings.commonUi.alreadyReviewed);
      }
      final doctorRef = _db.collection('doctors').doc(appointment.doctorId);
      final doctor = await transaction.get(doctorRef);
      if (!doctor.exists) throw StateError(appStrings.commonUi.doctorNotFound);
      final data = doctor.data()!;
      final count =
          (data['reviewsCount'] as num? ?? data['patientStories'] as num? ?? 0)
              .toInt();
      final average = (data['rating'] as num? ?? 0).toDouble();
      transaction.update(ref, {
        'reviewRating': rating,
        'reviewComment': text,
        'reviewedAt': FieldValue.serverTimestamp(),
      });
      transaction.set(reviewRef, {
        'appointmentId': appointmentId,
        'patientId': patientId,
        'doctorId': appointment.doctorId,
        'patientName': appointment.patientName,
        'rating': rating,
        'comment': text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.update(doctorRef, {
        'patientStories': count + 1,
        'reviewsCount': count + 1,
        'rating': (average * count + rating) / (count + 1),
        'reviewMutationId': appointmentId,
      });
    });
  }

  Stream<List<Appointment>> watchAppointments({
    String? patientId,
    String? doctorId,
  }) {
    Query<Map<String, dynamic>> query = _db.collection('appointments');
    if (patientId != null) {
      query = query.where('patientId', isEqualTo: patientId);
    }
    if (doctorId != null) query = query.where('doctorId', isEqualTo: doctorId);
    return query.snapshots().map(
      (snapshot) =>
          snapshot.docs
              .map((doc) => Appointment(id: doc.id, data: doc.data()))
              .toList()
            ..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
    );
  }

  Stream<List<Map<String, dynamic>>> watchReviews(String doctorId) => _db
      .collection('reviews')
      .where('doctorId', isEqualTo: doctorId)
      .snapshots()
      .map((snapshot) {
        final reviews = snapshot.docs.map((doc) => doc.data()).toList();
        reviews.sort(
          (a, b) => ((b['createdAt'] as Timestamp?)?.toDate() ?? DateTime(1970))
              .compareTo(
                (a['createdAt'] as Timestamp?)?.toDate() ?? DateTime(1970),
              ),
        );
        return reviews.take(5).toList();
      });

  Stream<List<DateTime>> watchBookedSlots(String doctorId) => _db
      .collection('booking_slots')
      .where('doctorId', isEqualTo: doctorId)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .where((doc) => doc.data()['active'] == true)
            .map((doc) => (doc.data()['startsAt'] as Timestamp).toDate())
            .toList(),
      );

  Stream<String> watchClinicLocation() => _db
      .collection('settings')
      .doc('clinic')
      .snapshots()
      .map((snapshot) => snapshot.data()?['location'] as String? ?? '');
  Future<void> saveClinicLocation(String location) => _db
      .collection('settings')
      .doc('clinic')
      .set({'location': location.trim()});

  /// Called from the admin settings; preserve an existing clinic address.
  Future<void> initializeClinicLocation() async {
    final ref = _db.collection('settings').doc('clinic');
    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      final location = snapshot.data()?['location'] as String? ?? '';
      if (location.trim().isEmpty) {
        transaction.set(ref, {'location': 'الرياض، حي العليا، شارع العليا'});
      }
    });
  }

  Future<void> book({
    required DoctorModel doctor,
    required AppUser patient,
    required DateTime startsAt,
  }) async {
    final appointmentRef = _db.collection('appointments').doc();
    final slotId = '${doctor.id}_${startsAt.toUtc().millisecondsSinceEpoch}';
    final slotRef = _db.collection('booking_slots').doc(slotId);
    final doctorRef = _db.collection('doctors').doc(doctor.id);
    await _db.runTransaction((transaction) async {
      var appStrings = t;
      final slot = await transaction.get(slotRef);
      final doctorSnapshot = await transaction.get(doctorRef);
      final clinic = await transaction.get(
        _db.collection('settings').doc('clinic'),
      );
      if (slot.data()?['active'] == true) {
        throw StateError(appStrings.commonUi.slotTaken);
      }
      if (!doctorSnapshot.exists) {
        throw StateError(appStrings.commonUi.doctorNotFound);
      }
      final current = DoctorModel.fromMap(
        id: doctor.id,
        map: doctorSnapshot.data()!,
      );
      final local = riyadhTime(startsAt);
      final validSlot = current.availability
          .slotsForDate(local)
          .any((slot) => slot.isAtSameMomentAs(startsAt));
      if (!current.isAvailable || !validSlot) {
        throw StateError(appStrings.commonUi.doctorUnavailable);
      }
      if (doctor.price != current.price) {
        throw StateError(appStrings.commonUi.feeChanged);
      }
      final location = clinic.data()?['location'] as String? ?? '';
      if (location.trim().isEmpty) {
        throw StateError(appStrings.commonUi.clinicNotConfigured);
      }
      final end = startsAt.add(
        Duration(minutes: current.availability.slotMinutes),
      );
      transaction.set(appointmentRef, {
        'doctorId': doctor.id,
        'patientId': patient.uid,
        'doctorName': current.name,
        'specialization': current.specialization,
        'patientName': patient.name,
        'patientEmail': patient.email,
        'fee': current.price,
        'currency': 'USD',
        'startsAt': Timestamp.fromDate(startsAt.toUtc()),
        'endsAt': Timestamp.fromDate(end.toUtc()),
        'status': 'upcoming',
        'slotId': slotId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.set(slotRef, {
        'appointmentId': appointmentRef.id,
        'doctorId': doctor.id,
        'active': true,
        'startsAt': Timestamp.fromDate(startsAt.toUtc()),
      });
      transaction.update(doctorRef, {
        'activeBookingCount':
            (doctorSnapshot.data()?['activeBookingCount'] as num? ?? 0)
                .toInt() +
            1,
        'bookingMutationId': appointmentRef.id,
      });
    });
  }

  Future<void> changeStatus(
    Appointment appointment,
    AppointmentStatus status,
  ) async {
    var appStrings = t;
    if (status == AppointmentStatus.upcoming) {
      throw ArgumentError(appStrings.commonUi.cannotReopen);
    }
    final ref = _db.collection('appointments').doc(appointment.id);
    await _db.runTransaction((transaction) async {
      var appStrings = t;
      final snapshot = await transaction.get(ref);
      if (!snapshot.exists || snapshot.data()?['status'] != 'upcoming') {
        throw StateError(appStrings.commonUi.upcomingOnly);
      }
      final current = Appointment(id: snapshot.id, data: snapshot.data()!);
      if (status == AppointmentStatus.completed &&
          current.endsAt.isAfter(DateTime.now())) {
        throw StateError(appStrings.commonUi.completionTooEarly);
      }
      final doctorRef = _db.collection('doctors').doc(current.doctorId);
      final doctor = await transaction.get(doctorRef);
      transaction.update(ref, {
        'status': status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      transaction.update(_db.collection('booking_slots').doc(current.slotId), {
        'active': false,
      });
      transaction.update(doctorRef, {
        'activeBookingCount':
            (doctor.data()?['activeBookingCount'] as num? ?? 0).toInt() - 1,
        'bookingMutationId': appointment.id,
      });
    });
  }
}
