sealed class SignUpEvent {
  const SignUpEvent();
}

final class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}
