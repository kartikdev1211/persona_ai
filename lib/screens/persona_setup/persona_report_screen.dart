import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/common_widget/progress_ring.dart';
import 'package:persona_ai/common_widget/gradient_button.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/persona/persona_report_model.dart';

class PersonaReportScreen extends StatelessWidget {
  const PersonaReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final report = kMockPersonaReport;

    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -50,
            child: _Glow(color: AppColors.neonPurple.withOpacity(0.15)),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _Glow(color: AppColors.neonBlue.withOpacity(0.1)),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.screenH),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your AI Analysis',
                          style: AppTextStyles.labelSM.copyWith(
                            color: AppColors.neonBlue,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Personality Report',
                          style: AppTextStyles.displayLG,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Based on your inputs, we\'ve mapped your current growth profile and long-term roadmap.',
                          style: AppTextStyles.bodyMD,
                        ),
                      ],
                    ),
                  ),
                ),

                // Scores Row
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ScoreItem(
                          label: 'Confidence',
                          score: report.confidenceScore,
                          color: AppColors.neonBlue,
                        ),
                        _ScoreItem(
                          label: 'Discipline',
                          score: report.disciplineScore,
                          color: AppColors.neonPurple,
                        ),
                        _ScoreItem(
                          label: 'Social',
                          score: report.socialGrowthScore,
                          color: AppColors.neonGreen,
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xl),
                ),

                // Strengths & Weaknesses
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _AnalysisList(
                            title: 'Strengths',
                            items: report.strengths,
                            color: AppColors.neonGreen,
                            icon: Icons.add_task_rounded,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _AnalysisList(
                            title: 'Challenges',
                            items: report.weaknesses,
                            color: AppColors.neonAmber,
                            icon: Icons.auto_graph_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xl),
                ),

                // Roadmap Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: Text(
                      'Personalized Roadmap',
                      style: AppTextStyles.displayMD,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
                ),

                // Roadmap List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final step = report.roadmap[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: GlassCard(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.bg300,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.md,
                                  ),
                                  border: Border.all(
                                    color: AppColors.glassBorder,
                                  ),
                                ),
                                child: Icon(
                                  step.icon,
                                  color: AppColors.textPrimary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      step.title,
                                      style: AppTextStyles.titleSM,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      step.description,
                                      style: AppTextStyles.bodySM,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: report.roadmap.length),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xl2),
                ),

                // CTA
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.screenH),
                    child: GradientButton(
                      label: 'Begin My Transformation',
                      onTap: () => Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.home),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xl),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreItem extends StatelessWidget {
  final String label;
  final double score;
  final Color color;

  const _ScoreItem({
    required this.label,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProgressRing(
          value: score,
          size: 96,
          strokeWidth: 7,
          color: color,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(score * 100).toInt()}%',
                style: AppTextStyles.displayMD.copyWith(
                  fontSize: 22,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'SCORE',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 8,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(label, style: AppTextStyles.labelSM),
      ],
    );
  }
}

class _AnalysisList extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  final IconData icon;

  const _AnalysisList({
    required this.title,
    required this.items,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(title, style: AppTextStyles.titleSM.copyWith(color: color)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•', style: TextStyle(color: color)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: AppTextStyles.bodySM.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  final Color color;
  const _Glow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
