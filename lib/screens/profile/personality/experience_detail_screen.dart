// lib/screens/profile/personality/experience_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/common_widget/progress_ring.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/home/home_model.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Growth Level', style: AppTextStyles.titleLG),
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
          children: [
            const SizedBox(height: AppSpacing.xl),

            // Level Ring
            ProgressRing(
              value: kMockUser.xpProgress,
              size: 160,
              strokeWidth: 12,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LVL',
                    style: AppTextStyles.labelSM.copyWith(letterSpacing: 2),
                  ),
                  Text(
                    '${kMockUser.level}',
                    style: AppTextStyles.displayXL.copyWith(fontSize: 48),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl3),

            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('Total XP', '${kMockUser.xp}'),
                  Container(width: 1, height: 40, color: AppColors.glassBorder),
                  _buildStat('To Next', '${kMockUser.xpToNext - kMockUser.xp}'),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl3),

            _buildSectionHeader('Upcoming Rewards'),
            const SizedBox(height: AppSpacing.md),
            _buildRewardItem(
              5,
              'New Archetype: The Social Architect',
              Icons.psychology_rounded,
            ),
            _buildRewardItem(
              6,
              'Premium Badge: Unstoppable',
              Icons.shield_rounded,
            ),
            _buildRewardItem(
              10,
              'Unlock Advanced Social Missions',
              Icons.lock_open_rounded,
            ),

            const SizedBox(height: AppSpacing.xl3),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.titleLG.copyWith(color: AppColors.neonBlue),
        ),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTextStyles.titleMD),
    );
  }

  Widget _buildRewardItem(int level, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: GlassCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.bg300,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                'Lvl $level',
                style: AppTextStyles.labelSM.copyWith(
                  color: AppColors.neonAmber,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: Text(title, style: AppTextStyles.bodyMD)),
            Icon(icon, size: 20, color: AppColors.textDisabled),
          ],
        ),
      ),
    );
  }
}
