import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/models/quiz/quiz_model.dart';
import 'package:persona_ai/screens/quiz_screen/bloc/event/quiz_event.dart';
import 'package:persona_ai/screens/quiz_screen/bloc/state/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc()
    : super(QuizState(answers: List.filled(kQuizQuestions.length, null))) {
    on<SelectOption>((event, emit) {
      final newAnswers = List<int?>.from(state.answers);
      newAnswers[state.currentIndex] = event.optionIndex;
      emit(state.copyWith(answers: newAnswers));
    });

    on<NextQuestion>((event, emit) {
      if (state.isLast) {
        StorageHelper.isQuizCompleted = true;
        emit(state.copyWith(isCompleted: true));
      } else {
        emit(state.copyWith(currentIndex: state.currentIndex + 1));
      }
    });

    on<PreviousQuestion>((event, emit) {
      if (state.currentIndex > 0) {
        emit(state.copyWith(currentIndex: state.currentIndex - 1));
      }
    });
  }
}
