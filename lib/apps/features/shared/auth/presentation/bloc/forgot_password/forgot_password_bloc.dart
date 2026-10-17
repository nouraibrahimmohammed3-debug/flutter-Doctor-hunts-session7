import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/send_password_reset_email.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required SendPasswordResetEmail sendPasswordResetEmail})
    : _sendPasswordResetEmail = sendPasswordResetEmail,
      super(const ForgotPasswordState()) {
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  final SendPasswordResetEmail _sendPasswordResetEmail;

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordState(status: ForgotPasswordStatus.loading));

    try {
      await _sendPasswordResetEmail(email: event.email.trim());

      emit(const ForgotPasswordState(status: ForgotPasswordStatus.success));
    } on FirebaseAuthException catch (error) {
      emit(
        ForgotPasswordState(
          status: ForgotPasswordStatus.failure,
          errorCode: error.code,
        ),
      );
    } catch (_) {
      emit(
        const ForgotPasswordState(
          status: ForgotPasswordStatus.failure,
          errorCode: 'unknown',
        ),
      );
    }
  }
}
