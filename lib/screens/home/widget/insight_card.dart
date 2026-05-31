// lib/screens/home/widget/insight_card.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/home/home_model.dart';

class InsightCard extends StatefulWidget {
  final List<Insight> insights;

  const InsightCard({super.key, required this.insights});

  @override
  State<InsightCard> createState() => _InsightCardState();
}

class _InsightCardState extends State<InsightCard> {
  int _index = 0;

  void _next() {
    setState(() => _index = (_index + 1) % widget.insights.length);
  }

  @override
  Widget build(BuildContext context) {
    final insight = widget.insights[_index];
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _next,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              insight.color.withOpacity(0.08),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: insight.color.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: insight.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(insight.icon, color: insight.color, size: 18),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  insight.text,
                  key: ValueKey(_index),
                  style: AppTextStyles.bodySM.copyWith(
                    color: theme.colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              children: List.generate(
                widget.insights.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  width: 4,
                  height: i == _index ? 16 : 4,
                  decoration: BoxDecoration(
                    color: i == _index
                        ? insight.color
                        : (isDark
                              ? AppColors.textDisabled
                              : AppColors.lightTextDisabled),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
