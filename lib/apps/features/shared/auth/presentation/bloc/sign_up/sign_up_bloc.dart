import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/sign_up.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required SignUp signUp})
    : _signUp = signUp,
      super(const SignUpState()) {
    on<SignUpSubmitted>(_onSubmitted);
  }

  final SignUp _signUp;

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SignUpStatus.loading, clearError: true));

    try {
      await _signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: SignUpStatus.success, clearError: true));
    } catch (error) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: localizedError(error),
        ),
      );
    }
  }
}
