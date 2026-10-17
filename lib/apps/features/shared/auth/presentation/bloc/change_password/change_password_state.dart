enum ChangePasswordStatus { initial, loading, success, failure }

class ChangePasswordState {
  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.errorCode,
  });

  final ChangePasswordStatus status;
  final String? errorCode;
}
