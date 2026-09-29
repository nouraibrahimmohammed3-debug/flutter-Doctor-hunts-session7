enum AddDoctorStatus {
  initial,
  loading,
  success,
  failure,
}

class AddDoctorState {
  const AddDoctorState({
    this.status = AddDoctorStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  final AddDoctorStatus status;
  final String? errorMessage;
  final String? successMessage;

  AddDoctorState copyWith({
    AddDoctorStatus? status,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return AddDoctorState(
      status: status ?? this.status,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
      successMessage: clearSuccess
          ? null
          : successMessage ?? this.successMessage,
    );
  }
}