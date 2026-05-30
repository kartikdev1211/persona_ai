abstract class AuthEvent {}

class ToggleMode extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

class SignupRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  SignupRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}
