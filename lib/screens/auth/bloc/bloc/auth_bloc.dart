import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/auth/bloc/event/auth_event.dart';
import 'package:persona_ai/screens/auth/bloc/state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<ToggleMode>((event, emit) {
      final newMode = state.mode == AuthMode.login
          ? AuthMode.signup
          : AuthMode.login;
      emit(state.copyWith(mode: newMode, status: AuthStatus.initial));
    });

    on<LoginRequested>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Mock successful login
      StorageHelper.isLoggedIn = true;
      emit(state.copyWith(status: AuthStatus.success));
    });

    on<SignupRequested>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Mock successful signup
      StorageHelper.isLoggedIn = true;
      StorageHelper.userName = event.name;
      emit(state.copyWith(status: AuthStatus.success));
    });
  }
}
