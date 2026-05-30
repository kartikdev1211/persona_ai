import 'package:flutter/material.dart';

class PersonaReport {
  final double confidenceScore;
  final double disciplineScore;
  final double socialGrowthScore;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<RoadmapStep> roadmap;

  PersonaReport({
    required this.confidenceScore,
    required this.disciplineScore,
    required this.socialGrowthScore,
    required this.strengths,
    required this.weaknesses,
    required this.roadmap,
  });
}

class RoadmapStep {
  final String title;
  final String description;
  final IconData icon;

  RoadmapStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}

final kMockPersonaReport = PersonaReport(
  confidenceScore: 0.65,
  disciplineScore: 0.42,
  socialGrowthScore: 0.58,
  strengths: [
    'Empathetic Listener',
    'Clear Articulation',
    'Strategic Thinking',
  ],
  weaknesses: [
    'Public Speaking Anxiety',
    'Inconsistent Morning Routine',
    'Hesitation in Networking',
  ],
  roadmap: [
    RoadmapStep(
      title: 'Confidence Foundation',
      description: 'Master posture and eye contact in low-stakes environments.',
      icon: Icons.accessibility_new_rounded,
    ),
    RoadmapStep(
      title: 'Social Expansion',
      description: 'Initiate 3 conversations per day with strangers.',
      icon: Icons.forum_rounded,
    ),
    RoadmapStep(
      title: 'Leadership & Tone',
      description: 'Refine vocal clarity and projection for meetings.',
      icon: Icons.record_voice_over_rounded,
    ),
  ],
);
