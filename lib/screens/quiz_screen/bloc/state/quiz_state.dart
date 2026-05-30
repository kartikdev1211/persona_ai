class QuizState {
  final int currentIndex;
  final List<int?> answers;
  final bool isCompleted;

  QuizState({
    this.currentIndex = 0,
    required this.answers,
    this.isCompleted = false,
  });

  bool get canProceed => answers[currentIndex] != null;
  bool get isLast => currentIndex == answers.length - 1;

  QuizState copyWith({
    int? currentIndex,
    List<int?>? answers,
    bool? isCompleted,
  }) {
    return QuizState(
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
