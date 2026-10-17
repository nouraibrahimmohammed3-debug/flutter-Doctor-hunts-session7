enum ForgotPasswordStatus { initial, loading, success, failure }

class ForgotPasswordState {
  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.errorCode,
  });

  final ForgotPasswordStatus status;
  final String? errorCode;
}
