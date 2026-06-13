import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/common_widget/progress_ring.dart';
import 'package:persona_ai/common_widget/gradient_button.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/persona_setup/report_bloc/bloc/persona_report_bloc.dart';
import 'package:persona_ai/screens/persona_setup/report_bloc/state/persona_report_state.dart';
import 'package:persona_ai/screens/persona_setup/report_bloc/event/persona_report_event.dart';

class PersonaReportScreen extends StatelessWidget {
  const PersonaReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: BlocBuilder<PersonaReportBloc, PersonaReportState>(
        builder: (context, state) {
          if (state is PersonaReportLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.neonBlue),
            );
          }

          if (state is PersonaReportError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: AppTextStyles.bodyMD.copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  GradientButton(
                    label: 'Retry',
                    onTap: () => context.read<PersonaReportBloc>().add(
                      const GenerateReport(),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is PersonaReportLoaded) {
            final report = state.report;
            return Stack(
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
                            children: [
                              Expanded(
                                child: _ScoreItem(
                                  label: 'Confidence',
                                  score: report.confidenceScore,
                                  color: AppColors.neonBlue,
                                ),
                              ),
                              Expanded(
                                child: _ScoreItem(
                                  label: 'Discipline',
                                  score: report.disciplineScore,
                                  color: AppColors.neonPurple,
                                ),
                              ),
                              Expanded(
                                child: _ScoreItem(
                                  label: 'Social',
                                  score: report.socialGrowthScore,
                                  color: AppColors.neonGreen,
                                ),
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
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final step = report.roadmap[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.md,
                              ),
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
                                      child: const Icon(
                                        Icons.auto_awesome_rounded,
                                        color: AppColors.textPrimary,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.md),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                        child: SizedBox(height: AppSpacing.xs),
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
            );
          }

          return const SizedBox.shrink();
        },
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
          size: 77,
          strokeWidth: 6,
          color: color,
          center: SizedBox(
            width: 80,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(score * 100).toInt()}%',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.displayMD.copyWith(
                    fontSize: 13,
                    height: 1,
                  ),
                ),
                Text(
                  'SCORE',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 7,
                    height: 1,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: color.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: AppTextStyles.labelSM.copyWith(fontSize: 11),
          textAlign: TextAlign.center,
        ),
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
