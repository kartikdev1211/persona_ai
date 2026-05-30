import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';

abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc()
    : super(StorageHelper.isDarkMode ? ThemeMode.dark : ThemeMode.light) {
    on<ToggleTheme>((event, emit) {
      final nextMode = state == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
      StorageHelper.isDarkMode = (nextMode == ThemeMode.dark);
      emit(nextMode);
    });
  }
}
