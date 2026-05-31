// lib/screens/home/bloc/home_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/models/home/home_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeMissionTapped>(_onHomeMissionTapped);
  }

  void _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) {
    emit(HomeLoading());
    // Simulate data loading
    emit(
      HomeLoaded(
        user: kMockUser,
        missions: kTodayMissions,
        goals: kGoalProgresses,
        insights: kInsights,
        completedIndices: {2}, // index 2 pre-completed from model
      ),
    );
  }

  void _onHomeMissionTapped(HomeMissionTapped event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      if (currentState.missions[event.index].isCompleted) return;
      if (currentState.completedIndices.contains(event.index)) return;

      final updatedCompletedIndices = Set<int>.from(
        currentState.completedIndices,
      )..add(event.index);

      emit(currentState.copyWith(completedIndices: updatedCompletedIndices));
    }
  }
}
