import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/network/repository/assessment_repository.dart';
import 'package:persona_ai/core/network/repository/persona_repository.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/splash/bloc/event/splash_event.dart';
import 'package:persona_ai/screens/splash/bloc/state/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AssessmentRepository _assessmentRepository;
  final PersonaRepository _personaRepository;

  SplashBloc({
    AssessmentRepository? assessmentRepository,
    PersonaRepository? personaRepository,
  }) : _assessmentRepository = assessmentRepository ?? AssessmentRepository(),
       _personaRepository = personaRepository ?? PersonaRepository(),
       super(SplashInitial()) {
    on<AppStarted>((event, emit) async {
      emit(SplashLoading());

      // Simulate minimal loading time (fetching config, etc.)
      await Future.delayed(const Duration(seconds: 2));

      if (!StorageHelper.isOnboardingCompleted) {
        emit(SplashNavigateTo(AppRoutes.onboarding));
        return;
      }

      if (!StorageHelper.isLoggedIn) {
        emit(SplashNavigateTo(AppRoutes.auth));
        return;
      }

      // Sync status with backend if logged in
      final assessmentResult = await _assessmentRepository
          .getAssessmentStatus();
      if (assessmentResult case ApiSuccess(:final data)) {
        StorageHelper.isQuizCompleted = data.assessmentCompleted;

        if (data.assessmentCompleted) {
          final personaResult = await _personaRepository.getPersonaStatus();
          if (personaResult case ApiSuccess(:final data)) {
            StorageHelper.isPersonaSetupCompleted = data.personaSetupCompleted;
          }
        }
      }

      // Navigate based on synced state
      if (!StorageHelper.isQuizCompleted) {
        emit(SplashNavigateTo(AppRoutes.quiz));
      } else if (!StorageHelper.isPersonaSetupCompleted) {
        emit(SplashNavigateTo(AppRoutes.personaSetup));
      } else {
        emit(SplashNavigateTo(AppRoutes.home));
      }
    });
  }
}
