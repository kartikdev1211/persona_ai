// lib/models/quiz/quiz_model.dart

class QuizQuestion {
  final String question;
  final String emoji;
  final List<String> options;

  const QuizQuestion({
    required this.question,
    required this.emoji,
    required this.options,
  });
}

const List<QuizQuestion> kQuizQuestions = [
  QuizQuestion(
    question: 'How do you usually feel in social situations?',
    emoji: '👥',
    options: [
      'Confident and outgoing',
      'Comfortable but reserved',
      'Nervous but I push through',
      'I tend to avoid them',
    ],
  ),
  QuizQuestion(
    question: 'What best describes your current goal?',
    emoji: '🎯',
    options: [
      'Build confidence & presence',
      'Improve social & dating life',
      'Develop discipline & habits',
      'Level up my overall image',
    ],
  ),
  QuizQuestion(
    question: 'How consistent are you with self-improvement?',
    emoji: '⚡',
    options: [
      'Very — I have daily routines',
      'Mostly — a few times a week',
      'Sometimes — when motivated',
      'Just getting started',
    ],
  ),
  QuizQuestion(
    question: 'What holds you back the most?',
    emoji: '🧱',
    options: [
      'Fear of judgment',
      'Lack of motivation',
      'Not knowing where to start',
      'Old habits and mindset',
    ],
  ),
];
