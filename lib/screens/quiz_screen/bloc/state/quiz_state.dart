// lib/screens/quiz_screen/bloc/state/quiz_state.dart

class QuizState {
  QuizState({
    this.currentIndex = 0,
    required this.answers,
    this.isCompleted = false,
    this.isLoading = false,
    this.error,
  });

  final int currentIndex;
  final List<int?> answers;
  final bool isCompleted;
  final bool isLoading;
  final String? error;

  bool get canProceed => answers[currentIndex] != null;
  bool get isLast => currentIndex == answers.length - 1;

  QuizState copyWith({
    int? currentIndex,
    List<int?>? answers,
    bool? isCompleted,
    bool? isLoading,
    String? error,
  }) {
    return QuizState(
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
