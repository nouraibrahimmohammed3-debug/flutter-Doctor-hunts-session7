enum DeactivateDoctorStatus { initial, loading, success, failure }

class DeactivateDoctorState {
  const DeactivateDoctorState({
    this.status = DeactivateDoctorStatus.initial,
    this.deactivatingDoctorId,
    this.successMessage,
    this.errorMessage,
  });

  final DeactivateDoctorStatus status;
  final String? deactivatingDoctorId;
  final String? successMessage;
  final String? errorMessage;

  DeactivateDoctorState copyWith({
    DeactivateDoctorStatus? status,
    String? deactivatingDoctorId,
    String? successMessage,
    String? errorMessage,
  }) {
    return DeactivateDoctorState(
      status: status ?? this.status,
      deactivatingDoctorId: deactivatingDoctorId ?? this.deactivatingDoctorId,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
