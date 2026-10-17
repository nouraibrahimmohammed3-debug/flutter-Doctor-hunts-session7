enum EditDoctorStatus { initial, loading, success, failure }

class EditDoctorState {
  const EditDoctorState({
    this.status = EditDoctorStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  final EditDoctorStatus status;
  final String? errorMessage;
  final String? successMessage;

  EditDoctorState copyWith({
    EditDoctorStatus? status,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return EditDoctorState(
      status: status ?? this.status,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      successMessage: clearSuccess
          ? null
          : successMessage ?? this.successMessage,
    );
  }
}
