abstract class ChangePasswordEvent {}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  ChangePasswordSubmitted({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;
}
