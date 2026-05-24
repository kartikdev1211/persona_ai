import 'package:flutter/cupertino.dart';

enum AuthMode { login, signup }

class AuthNotifier extends ValueNotifier<AuthMode> {
  AuthNotifier() : super(AuthMode.login);
  bool get isLogin => value == AuthMode.login;
  bool get isSignup => value == AuthMode.signup;
  void toggleMode() {
    value = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
