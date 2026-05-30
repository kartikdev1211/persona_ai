abstract class QuizEvent {}

class SelectOption extends QuizEvent {
  final int optionIndex;
  SelectOption(this.optionIndex);
}

class NextQuestion extends QuizEvent {}

class PreviousQuestion extends QuizEvent {}
