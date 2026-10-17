abstract class ForgotPasswordEvent {}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  ForgotPasswordSubmitted({required this.email});

  final String email;
}
