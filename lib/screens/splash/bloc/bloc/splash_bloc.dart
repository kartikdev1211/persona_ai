import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/splash/bloc/event/splash_event.dart';
import 'package:persona_ai/screens/splash/bloc/state/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AppStarted>((event, emit) async {
      emit(SplashLoading());

      // Simulate minimal loading time (fetching config, etc.)
      await Future.delayed(const Duration(seconds: 2));

      if (!StorageHelper.isOnboardingCompleted) {
        emit(SplashNavigateTo(AppRoutes.onboarding));
      } else if (!StorageHelper.isLoggedIn) {
        emit(SplashNavigateTo(AppRoutes.auth));
      } else if (!StorageHelper.isQuizCompleted) {
        emit(SplashNavigateTo(AppRoutes.quiz));
      } else if (!StorageHelper.isPersonaSetupCompleted) {
        emit(SplashNavigateTo(AppRoutes.personaSetup));
      } else {
        emit(SplashNavigateTo(AppRoutes.home));
      }
    });
  }
}
