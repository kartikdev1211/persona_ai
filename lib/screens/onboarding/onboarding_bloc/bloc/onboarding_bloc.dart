import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/onboarding/onboarding_bloc/event/onboarding_event.dart';
import 'package:persona_ai/screens/onboarding/onboarding_bloc/state/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState()) {
    on<PageChanged>((event, emit) {
      emit(OnboardingState(currentPage: event.index));
    });

    on<CompleteOnboarding>((event, emit) {
      StorageHelper.isOnboardingCompleted = true; // Save to System specific
      emit(OnboardingState(currentPage: state.currentPage, isCompleted: true));
    });
  }
}
