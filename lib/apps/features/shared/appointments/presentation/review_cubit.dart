import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/appointment_service.dart';

class ReviewState {
  const ReviewState({this.saving = false, this.saved = false, this.error});
  final bool saving;
  final bool saved;
  final String? error;
}

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this.service) : super(const ReviewState());
  final AppointmentService service;
  Future<void> submit({
    required Appointment appointment,
    required String patientId,
    required int rating,
    required String comment,
  }) async {
    var appStrings = t;
    if (state.saving || state.saved) return;
    emit(const ReviewState(saving: true));
    try {
      await service.submitReview(
        appointmentId: appointment.id,
        patientId: patientId,
        rating: rating,
        comment: comment,
      );
      if (!isClosed) emit(const ReviewState(saved: true));
    } catch (error) {
      final message = error is FirebaseException
          ? appStrings.commonUi.reviewSaveFailed
          : error is StateError
          ? error.message.toString()
          : appStrings.commonUi.reviewSaveFailed;
      if (!isClosed) emit(ReviewState(error: message));
    }
  }
}
