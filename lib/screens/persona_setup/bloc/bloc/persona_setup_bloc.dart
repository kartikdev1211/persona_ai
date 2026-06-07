// lib/screens/persona_setup/bloc/bloc/persona_setup_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/network/repository/persona_repository.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/persona_setup/bloc/event/persona_setup_event.dart';
import 'package:persona_ai/screens/persona_setup/bloc/state/persona_setup_state.dart';

class PersonaSetupBloc extends Bloc<PersonaSetupEvent, PersonaSetupState> {
  final PersonaRepository _personaRepository;

  PersonaSetupBloc({required PersonaRepository personaRepository})
    : _personaRepository = personaRepository,
      super(PersonaSetupState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(userName: event.name));
    });

    on<AvatarChanged>((event, emit) {
      emit(state.copyWith(avatarIndex: event.index));
    });

    on<ConfidenceChanged>((event, emit) {
      emit(state.copyWith(confidenceLevel: event.level));
    });

    on<FocusGoalChanged>((event, emit) {
      emit(state.copyWith(focusGoalIndex: event.index));
    });

    on<NextStep>((event, emit) {
      if (!state.isLast) {
        final nextIdx = state.currentStep.index + 1;
        emit(state.copyWith(currentStep: SetupStep.values[nextIdx]));
      }
    });

    on<PreviousStep>((event, emit) {
      if (!state.isFirst) {
        final prevIdx = state.currentStep.index - 1;
        emit(state.copyWith(currentStep: SetupStep.values[prevIdx]));
      }
    });

    on<FinishSetup>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // Extract string labels for API
      final confidenceLevels = [
        'Beginner',
        'Developing',
        'Intermediate',
        'Confident',
        'Elite',
      ];
      final focusGoals = [
        'Communication',
        'Confidence',
        'Self-Discipline',
        'Social Skills',
        'Grooming',
        'Career Growth',
      ];

      final levelIndex = (state.confidenceLevel * 4).round().clamp(0, 4);
      final confidenceLabel = confidenceLevels[levelIndex];
      final focusGoalLabel = focusGoals[state.focusGoalIndex];

      final result = await _personaRepository.setupPersona(
        personaName: state.userName,
        avatarIndex: state.avatarIndex,
        confidenceLevel: confidenceLabel,
        focusGoal: focusGoalLabel,
      );

      switch (result) {
        case ApiSuccess(:final data):
          // Persist data
          StorageHelper.userName = state.userName;
          StorageHelper.isPersonaSetupCompleted = data.personaSetupCompleted;

          emit(state.copyWith(isLoading: false, isCompleted: true));

        case ApiFailure(:final exception):
          emit(
            state.copyWith(isLoading: false, errorMessage: exception.message),
          );
      }
    });
  }
}
