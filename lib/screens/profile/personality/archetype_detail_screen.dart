// lib/screens/profile/personality/archetype_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class ArchetypeDetailScreen extends StatelessWidget {
  const ArchetypeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Archetype', style: AppTextStyles.titleLG),
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
            const SizedBox(height: AppSpacing.lg),
            // Header Image/Icon
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.neonPurple.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 80,
                color: AppColors.neonPurple,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('The Modern Stoic', style: AppTextStyles.displayLG),
            const SizedBox(height: 8),
            Text(
              'RELIABLE • ANALYTICAL • COMPOSED',
              style: AppTextStyles.labelSM.copyWith(
                color: AppColors.neonPurple,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: AppSpacing.xl3),

            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Overview', style: AppTextStyles.titleMD),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'The Modern Stoic balances deep emotional intelligence with logical precision. You excel at maintaining composure in high-pressure social situations while remaining authentically yourself.',
                    style: AppTextStyles.bodyMD,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl2),

            _buildTraitSection('Core Strengths', [
              'Emotional Resilience',
              'Strategic Communication',
              'Observation Skills',
            ], AppColors.neonGreen),

            const SizedBox(height: AppSpacing.xl2),

            _buildTraitSection('Growth Areas', [
              'Spontaneous Expression',
              'Vulnerability Sharing',
              'Social Initiative',
            ], AppColors.neonAmber),

            const SizedBox(height: AppSpacing.xl3),
          ],
        ),
      ),
    );
  }

  Widget _buildTraitSection(String title, List<String> traits, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(title, style: AppTextStyles.titleSM),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: traits
              .map(
                (trait) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    trait,
                    style: AppTextStyles.labelSM.copyWith(color: color),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
