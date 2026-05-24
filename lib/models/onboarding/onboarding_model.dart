// lib/features/onboarding/models/onboarding_data.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';

class OnboardingSlide {
  final String tag;
  final String title;
  final String titleAccent; // gradient word
  final String body;
  final IconData icon;
  final List<Color> gradient;
  final List<Color> glowColors;

  const OnboardingSlide({
    required this.tag,
    required this.title,
    required this.titleAccent,
    required this.body,
    required this.icon,
    required this.gradient,
    required this.glowColors,
  });
}

const List<OnboardingSlide> kSlides = [
  OnboardingSlide(
    tag: 'SELF-AWARENESS',
    title: 'Know Your',
    titleAccent: 'True Self',
    body:
        'AI analyses your personality, confidence, communication style and habits — then builds a detailed growth blueprint unique to you.',
    icon: Icons.psychology_rounded,
    gradient: AppColors.primaryGradient,
    glowColors: [AppColors.neonBlue, AppColors.neonPurple],
  ),
  OnboardingSlide(
    tag: 'DAILY GROWTH',
    title: 'Train Like',
    titleAccent: 'An Athlete',
    body:
        'Adaptive daily missions, confidence challenges, and communication exercises that evolve as you grow — never the same routine twice.',
    icon: Icons.bolt_rounded,
    gradient: AppColors.greenGradient,
    glowColors: [AppColors.neonGreen, AppColors.neonBlue],
  ),
  OnboardingSlide(
    tag: 'TRANSFORMATION',
    title: 'Become Who',
    titleAccent: "You're Meant To Be",
    body:
        'Track confidence scores, communication progress, grooming habits, and social skills with real metrics that prove your transformation.',
    icon: Icons.auto_awesome_rounded,
    gradient: AppColors.amberGradient,
    glowColors: [AppColors.neonAmber, AppColors.neonPink],
  ),
];

class GoalOption {
  final String emoji;
  final String label;
  final String sublabel;

  const GoalOption({
    required this.emoji,
    required this.label,
    required this.sublabel,
  });
}

const List<GoalOption> kGoals = [
  GoalOption(
    emoji: '💬',
    label: 'Communication',
    sublabel: 'Speak clearly & confidently',
  ),
  GoalOption(
    emoji: '🧠',
    label: 'Self-Discipline',
    sublabel: 'Build lasting habits',
  ),
  GoalOption(emoji: '🪞', label: 'Grooming', sublabel: 'Look & feel your best'),
  GoalOption(
    emoji: '🤝',
    label: 'Social Skills',
    sublabel: 'Connect with anyone',
  ),
  GoalOption(emoji: '🎯', label: 'Confidence', sublabel: 'Own every room'),
  GoalOption(
    emoji: '💼',
    label: 'Career Growth',
    sublabel: 'Interview & network better',
  ),
];
