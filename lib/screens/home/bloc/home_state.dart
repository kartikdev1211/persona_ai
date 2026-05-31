// lib/screens/home/bloc/home_state.dart

import 'package:equatable/equatable.dart';
import 'package:persona_ai/models/home/home_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserStats user;
  final List<DailyMission> missions;
  final List<GoalProgress> goals;
  final List<Insight> insights;
  final Set<int> completedIndices;

  const HomeLoaded({
    required this.user,
    required this.missions,
    required this.goals,
    required this.insights,
    required this.completedIndices,
  });

  @override
  List<Object?> get props => [
    user,
    missions,
    goals,
    insights,
    completedIndices,
  ];

  HomeLoaded copyWith({
    UserStats? user,
    List<DailyMission>? missions,
    List<GoalProgress>? goals,
    List<Insight>? insights,
    Set<int>? completedIndices,
  }) {
    return HomeLoaded(
      user: user ?? this.user,
      missions: missions ?? this.missions,
      goals: goals ?? this.goals,
      insights: insights ?? this.insights,
      completedIndices: completedIndices ?? this.completedIndices,
    );
  }
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
