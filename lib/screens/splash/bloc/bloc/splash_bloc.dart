import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/network/repository/assessment_repository.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/splash/bloc/event/splash_event.dart';
import 'package:persona_ai/screens/splash/bloc/state/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AssessmentRepository _assessmentRepository;

  SplashBloc({AssessmentRepository? assessmentRepository})
    : _assessmentRepository = assessmentRepository ?? AssessmentRepository(),
      super(SplashInitial()) {
    on<AppStarted>((event, emit) async {
      emit(SplashLoading());

      await Future.delayed(const Duration(seconds: 2));

      if (!StorageHelper.isOnboardingCompleted) {
        emit(SplashNavigateTo(AppRoutes.onboarding));
        return;
      }

      if (!StorageHelper.isLoggedIn) {
        emit(SplashNavigateTo(AppRoutes.auth));
        return;
      }

      final statusResult = await _assessmentRepository.getAssessmentStatus();

      if (statusResult case ApiSuccess(:final data)) {
        if (!data.assessmentCompleted) {
          emit(SplashNavigateTo(AppRoutes.quiz));
        } else if (!data.isPersonaSetupCompleted) {
          emit(SplashNavigateTo(AppRoutes.personaSetup));
        } else if (!data.isReportGenerated) {
          emit(SplashNavigateTo(AppRoutes.personaReport));
        } else {
          emit(SplashNavigateTo(AppRoutes.home));
        }
      } else {
        await StorageHelper.clearUserSession();
        emit(SplashNavigateTo(AppRoutes.auth));
      }
    });
  }
}
