// lib/screens/persona_setup/bloc/bloc/persona_setup_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/screens/persona_setup/bloc/event/persona_setup_event.dart';
import 'package:persona_ai/screens/persona_setup/bloc/state/persona_setup_state.dart';

class PersonaSetupBloc extends Bloc<PersonaSetupEvent, PersonaSetupState> {
  PersonaSetupBloc() : super(PersonaSetupState()) {
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
      emit(state.copyWith(isLoading: true));

      // Persist data
      StorageHelper.userName = state.userName;
      StorageHelper.isPersonaSetupCompleted = true;

      // Simulate network/processing delay
      await Future.delayed(const Duration(milliseconds: 1200));

      emit(state.copyWith(isLoading: false, isCompleted: true));
    });
  }
}
