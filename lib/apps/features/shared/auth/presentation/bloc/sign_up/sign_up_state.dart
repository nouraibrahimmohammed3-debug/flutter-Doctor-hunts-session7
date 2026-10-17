enum SignUpStatus { initial, loading, success, failure }

final class SignUpState {
  const SignUpState({this.status = SignUpStatus.initial, this.errorMessage});

  final SignUpStatus status;
  final String? errorMessage;

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
