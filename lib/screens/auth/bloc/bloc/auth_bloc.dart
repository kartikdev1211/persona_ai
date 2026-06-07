import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/network/repository/auth_repository.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/auth/bloc/event/auth_event.dart';
import 'package:persona_ai/screens/auth/bloc/state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc({AuthRepository? repo})
    : _repo = repo ?? AuthRepository(),
      super(AuthState()) {
    on<ToggleMode>(_onToggleMode);
    on<LoginRequested>(_onLogin);
    on<SignupRequested>(_onSignup);
  }

  void _onToggleMode(ToggleMode event, Emitter<AuthState> emit) {
    final newMode = state.mode == AuthMode.login
        ? AuthMode.signup
        : AuthMode.login;
    emit(
      state.copyWith(
        mode: newMode,
        status: AuthStatus.initial,
        clearError: true,
      ),
    );
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _repo.login(
      email: event.email,
      password: event.password,
    );

    switch (result) {
      case ApiSuccess():
        emit(state.copyWith(status: AuthStatus.success));
      case ApiFailure(:final exception):
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: exception.message,
          ),
        );
    }
  }

  Future<void> _onSignup(SignupRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _repo.signup(
      fullName: event.name,
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
    );

    switch (result) {
      case ApiSuccess(:final data):
        StorageHelper.userName = data.fullName;
        emit(state.copyWith(status: AuthStatus.success));
      case ApiFailure(:final exception):
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: exception.message,
          ),
        );
    }
  }
}
