import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/network/repository/assessment_repository.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/models/quiz/quiz_model.dart';
import 'package:persona_ai/screens/quiz_screen/bloc/event/quiz_event.dart';
import 'package:persona_ai/screens/quiz_screen/bloc/state/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final AssessmentRepository _repository;

  QuizBloc({AssessmentRepository? repository})
    : _repository = repository ?? AssessmentRepository(),
      super(QuizState(answers: List.filled(kQuizQuestions.length, null))) {
    on<SelectOption>((event, emit) {
      final newAnswers = List<int?>.from(state.answers);
      newAnswers[state.currentIndex] = event.optionIndex;
      emit(state.copyWith(answers: newAnswers));
    });

    on<NextQuestion>((event, emit) async {
      if (state.isLast) {
        emit(state.copyWith(isLoading: true));

        final result = await _repository.submitAssessment(
          socialSituation: kQuizQuestions[0].options[state.answers[0]!],
          currentGoal: kQuizQuestions[1].options[state.answers[1]!],
          selfImprovementConsistency:
              kQuizQuestions[2].options[state.answers[2]!],
          biggestObstacle: kQuizQuestions[3].options[state.answers[3]!],
        );

        if (result case ApiSuccess(:final data)) {
          StorageHelper.isQuizCompleted = data.assessmentCompleted;
          emit(state.copyWith(isLoading: false, isCompleted: true));
        } else if (result case ApiFailure(:final exception)) {
          emit(state.copyWith(isLoading: false, error: exception.message));
        }
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
