import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class XpChip extends StatelessWidget {
  final int xp;
  const XpChip({super.key, required this.xp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neonGreen.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt, color: AppColors.neonGreen, size: 12),
          const SizedBox(width: 3),
          Text(
            '$xp XP',
            style: AppTextStyles.labelSM.copyWith(color: AppColors.neonGreen),
          ),
        ],
      ),
    );
  }
}

/// Streak chip
class StreakChip extends StatelessWidget {
  final int days;
  const StreakChip({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neonAmber.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.neonAmber.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 11)),
          const SizedBox(width: 4),
          Text(
            '$days day streak',
            style: AppTextStyles.labelSM.copyWith(color: AppColors.neonAmber),
          ),
        ],
      ),
    );
  }
}
