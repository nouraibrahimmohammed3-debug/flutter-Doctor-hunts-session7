enum CreateDoctorStatus {
  initial,
  loading,
  success,
  failure,
}
class CreateDoctorState {
  const CreateDoctorState({
    this.status = CreateDoctorStatus.initial,
    this.errorMessage,
  });

  final CreateDoctorStatus status;
  final String? errorMessage;

  CreateDoctorState copyWith({
    CreateDoctorStatus? status,
    String? errorMessage,
  }) {
    return CreateDoctorState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}