// lib/screens/home/widget/goal_progress_row.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/common_widget/progress_ring.dart';
import 'package:persona_ai/models/home/home_model.dart';

class GoalProgressRow extends StatelessWidget {
  final List<GoalProgress> goals;

  const GoalProgressRow({super.key, required this.goals});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: goals.map((g) => _GoalRingTile(goal: g)).toList(),
      ),
    );
  }
}

class _GoalRingTile extends StatelessWidget {
  final GoalProgress goal;
  const _GoalRingTile({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProgressRing(
          value: goal.progress,
          size: 60,
          strokeWidth: 5,
          color: goal.color,
          center: Text(goal.emoji, style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(goal.label, style: AppTextStyles.caption),
        const SizedBox(height: 2),
        Text(
          '${(goal.progress * 100).toInt()}%',
          style: AppTextStyles.labelSM.copyWith(color: goal.color),
        ),
      ],
    );
  }
}
