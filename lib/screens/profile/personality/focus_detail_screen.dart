// lib/screens/profile/personality/focus_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class FocusDetailScreen extends StatelessWidget {
  const FocusDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Primary Focus', style: AppTextStyles.titleLG),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            Text('Confidence Building', style: AppTextStyles.displayLG),
            const SizedBox(height: 8),
            Text(
              'CURRENT MASTER PLAN',
              style: AppTextStyles.labelSM.copyWith(
                color: AppColors.neonBlue,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: AppSpacing.xl2),

            GlassCard(
              glowColor: AppColors.neonBlue,
              child: Column(
                children: [
                  _buildProgressRow('Social Presence', 0.65),
                  const SizedBox(height: AppSpacing.lg),
                  _buildProgressRow('Vocal Projection', 0.42),
                  const SizedBox(height: AppSpacing.lg),
                  _buildProgressRow('Body Language', 0.88),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl3),

            Text('Active Goals', style: AppTextStyles.titleMD),
            const SizedBox(height: AppSpacing.md),

            _buildGoalItem(
              'Maintain eye contact for 3s',
              'Social Presence',
              true,
            ),
            _buildGoalItem(
              'Speak from the diaphragm',
              'Vocal Projection',
              false,
            ),
            _buildGoalItem('Open posture in meetings', 'Body Language', true),
            _buildGoalItem('Join 1 networking event', 'Social Presence', false),

            const SizedBox(height: AppSpacing.xl3),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow(String label, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.labelLG),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.labelSM.copyWith(color: AppColors.neonBlue),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.bg400,
            valueColor: const AlwaysStoppedAnimation(AppColors.neonBlue),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalItem(String title, String category, bool isDone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(
              isDone
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isDone ? AppColors.neonGreen : AppColors.textDisabled,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleSM.copyWith(
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      color: isDone
                          ? AppColors.textDisabled
                          : AppColors.textPrimary,
                    ),
                  ),
                  Text(category, style: AppTextStyles.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
