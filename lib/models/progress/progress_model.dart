class ProgressData {
  final List<double> weeklyConfidence;
  final Map<String, double> skillScores;
  final int totalMissionsCompleted;
  final double consistencyScore;

  ProgressData({
    required this.weeklyConfidence,
    required this.skillScores,
    required this.totalMissionsCompleted,
    required this.consistencyScore,
  });
}

final kMockProgressData = ProgressData(
  weeklyConfidence: [0.55, 0.58, 0.57, 0.62, 0.60, 0.65, 0.68],
  skillScores: {
    'Communication': 0.72,
    'Social Skills': 0.48,
    'Discipline': 0.85,
    'Grooming': 0.60,
  },
  totalMissionsCompleted: 24,
  consistencyScore: 0.92,
);
