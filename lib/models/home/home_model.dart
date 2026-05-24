// lib/screens/home/home_model.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';

class UserStats {
  final String name;
  final String avatarEmoji;
  final int xp;
  final int xpToNext;
  final int level;
  final int streakDays;
  final double confidenceScore; // 0.0–1.0

  const UserStats({
    required this.name,
    required this.avatarEmoji,
    required this.xp,
    required this.xpToNext,
    required this.level,
    required this.streakDays,
    required this.confidenceScore,
  });

  double get xpProgress => xp / xpToNext;
}

class DailyMission {
  final String title;
  final String description;
  final String category;
  final int xpReward;
  final int durationMinutes;
  final IconData icon;
  final List<Color> gradient;
  final bool isCompleted;

  const DailyMission({
    required this.title,
    required this.description,
    required this.category,
    required this.xpReward,
    required this.durationMinutes,
    required this.icon,
    required this.gradient,
    this.isCompleted = false,
  });
}

class GoalProgress {
  final String label;
  final String emoji;
  final double progress; // 0.0–1.0
  final Color color;

  const GoalProgress({
    required this.label,
    required this.emoji,
    required this.progress,
    required this.color,
  });
}

class Insight {
  final String text;
  final IconData icon;
  final Color color;

  const Insight({required this.text, required this.icon, required this.color});
}

// ── Mock data ────────────────────────────────

const kMockUser = UserStats(
  name: 'Alex',
  avatarEmoji: '🧑‍💻',
  xp: 340,
  xpToNext: 500,
  level: 4,
  streakDays: 7,
  confidenceScore: 0.62,
);

const kTodayMissions = [
  DailyMission(
    title: 'Mirror Talk',
    description:
        'Speak to yourself in the mirror for 2 minutes. Maintain eye contact and speak your goals aloud.',
    category: 'Confidence',
    xpReward: 50,
    durationMinutes: 5,
    icon: Icons.record_voice_over_rounded,
    gradient: AppColors.primaryGradient,
  ),
  DailyMission(
    title: 'Cold Opener',
    description:
        'Start a conversation with a stranger today — cashier, colleague, or anyone nearby.',
    category: 'Social Skills',
    xpReward: 80,
    durationMinutes: 10,
    icon: Icons.waving_hand_rounded,
    gradient: AppColors.greenGradient,
  ),
  DailyMission(
    title: 'Power Posture',
    description:
        'Set 3 posture reminders today. Each time: shoulders back, chin level, chest open.',
    category: 'Grooming',
    xpReward: 30,
    durationMinutes: 2,
    icon: Icons.accessibility_new_rounded,
    gradient: AppColors.amberGradient,
    isCompleted: true,
  ),
];

const kGoalProgresses = [
  GoalProgress(
    label: 'Confidence',
    emoji: '🎯',
    progress: 0.62,
    color: AppColors.neonBlue,
  ),
  GoalProgress(
    label: 'Social',
    emoji: '🤝',
    progress: 0.45,
    color: AppColors.neonPurple,
  ),
  GoalProgress(
    label: 'Discipline',
    emoji: '🧠',
    progress: 0.78,
    color: AppColors.neonGreen,
  ),
  GoalProgress(
    label: 'Grooming',
    emoji: '🪞',
    progress: 0.55,
    color: AppColors.neonAmber,
  ),
];

const kInsights = [
  Insight(
    text: 'Your consistency is in the top 12% this week',
    icon: Icons.trending_up_rounded,
    color: AppColors.neonGreen,
  ),
  Insight(
    text: 'Confidence score up +8 points since Monday',
    icon: Icons.auto_awesome_rounded,
    color: AppColors.neonBlue,
  ),
  Insight(
    text: 'Best streak day: Tuesday — keep it up!',
    icon: Icons.local_fire_department_rounded,
    color: AppColors.neonAmber,
  ),
];
