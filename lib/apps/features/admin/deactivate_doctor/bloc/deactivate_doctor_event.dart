sealed class DeactivateDoctorEvent {
  const DeactivateDoctorEvent();
}

class DeactivateDoctorSubmitted extends DeactivateDoctorEvent {
  const DeactivateDoctorSubmitted(this.doctorId);

  final String doctorId;
}
