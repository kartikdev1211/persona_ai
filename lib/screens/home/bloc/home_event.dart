// lib/screens/home/bloc/home_event.dart

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeMissionTapped extends HomeEvent {
  final int index;

  const HomeMissionTapped(this.index);

  @override
  List<Object?> get props => [index];
}
