enum AuthMode { login, signup }

enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final AuthMode mode;
  final AuthStatus status;
  final String? errorMessage;

  AuthState({
    this.mode = AuthMode.login,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthMode? mode,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      mode: mode ?? this.mode,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
