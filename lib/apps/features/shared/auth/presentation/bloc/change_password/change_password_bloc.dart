import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/change_password.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({required ChangePassword changePassword})
    : _changePassword = changePassword,
      super(const ChangePasswordState()) {
    on<ChangePasswordSubmitted>(_onSubmitted);
  }

  final ChangePassword _changePassword;

  Future<void> _onSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(const ChangePasswordState(status: ChangePasswordStatus.loading));

    try {
      await _changePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );

      emit(const ChangePasswordState(status: ChangePasswordStatus.success));
    } on FirebaseAuthException catch (error) {
      emit(
        ChangePasswordState(
          status: ChangePasswordStatus.failure,
          errorCode: error.code,
        ),
      );
    } catch (_) {
      emit(
        const ChangePasswordState(
          status: ChangePasswordStatus.failure,
          errorCode: 'unknown',
        ),
      );
    }
  }
}
