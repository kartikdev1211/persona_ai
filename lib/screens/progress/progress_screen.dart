import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/progress/progress_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = kMockProgressData;

    return Scaffold(
      backgroundColor: AppColors.bg100,
      appBar: AppBar(
        title: Text('Analytics', style: AppTextStyles.displayMD),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenH),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _MiniStatCard(
                    label: 'Consistency',
                    value: '${(data.consistencyScore * 100).toInt()}%',
                    icon: Icons.bolt_rounded,
                    color: AppColors.neonGreen,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _MiniStatCard(
                    label: 'Missions',
                    value: '${data.totalMissionsCompleted}',
                    icon: Icons.check_circle_outline_rounded,
                    color: AppColors.neonBlue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // Growth Chart
            Text('Confidence Growth', style: AppTextStyles.titleMD),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: GlassCard(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: _GrowthChart(data: data.weeklyConfidence),
              ),
            ),

            const SizedBox(height: AppSpacing.xl2),

            // Skill Breakdown
            Text('Skill Mastery', style: AppTextStyles.titleMD),
            const SizedBox(height: AppSpacing.md),
            ...data.skillScores.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: _SkillProgressRow(
                  label: e.key,
                  progress: e.value,
                  color: _getSkillColor(e.key),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl2),

            // AI Suggestion Card
            GlassCard(
              glowColor: AppColors.neonPurple,
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.neonPurple,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI Optimization', style: AppTextStyles.titleSM),
                        const SizedBox(height: 4),
                        Text(
                          'Your discipline is peaking. Focus on Social Skills missions to balance your growth profile.',
                          style: AppTextStyles.bodySM,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl3),
          ],
        ),
      ),
    );
  }

  Color _getSkillColor(String skill) {
    switch (skill) {
      case 'Communication':
        return AppColors.neonBlue;
      case 'Social Skills':
        return AppColors.neonPurple;
      case 'Discipline':
        return AppColors.neonGreen;
      case 'Grooming':
        return AppColors.neonAmber;
      default:
        return AppColors.neonBlue;
    }
  }
}

class _MiniStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MiniStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Text(value, style: AppTextStyles.displayMD.copyWith(fontSize: 24)),
          Text(
            label,
            style: AppTextStyles.labelSM.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillProgressRow extends StatelessWidget {
  final String label;
  final double progress;
  final Color color;

  const _SkillProgressRow({
    required this.label,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.labelLG),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.labelSM.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColors.bg400,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

class _GrowthChart extends StatelessWidget {
  final List<double> data;
  const _GrowthChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ChartPainter(data: data),
      child: Container(),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> data;
  _ChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.neonBlue.withOpacity(0.3), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final fillPath = Path();

    final double stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] * size.height);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        // Simple cubic curve for smoothness
        final prevX = (i - 1) * stepX;
        final prevY = size.height - (data[i - 1] * size.height);
        path.cubicTo(prevX + stepX / 2, prevY, x - stepX / 2, y, x, y);
        fillPath.cubicTo(prevX + stepX / 2, prevY, x - stepX / 2, y, x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw dots
    final dotPaint = Paint()..color = AppColors.neonBlue;
    final dotBorderPaint = Paint()
      ..color = AppColors.bg100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] * size.height);
      canvas.drawCircle(Offset(x, y), 5, dotPaint);
      canvas.drawCircle(Offset(x, y), 5, dotBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
