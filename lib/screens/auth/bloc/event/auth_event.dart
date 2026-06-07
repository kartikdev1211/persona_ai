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
  final String confirmPassword;
  SignupRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
