// lib/features/splash/widgets/splash_loader.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class SplashLoader extends StatelessWidget {
  final Animation<double> fadeAnim;
  final Animation<double> progressAnim; // 0.0 – 1.0

  const SplashLoader({
    super.key,
    required this.fadeAnim,
    required this.progressAnim,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnim,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Preparing your growth plan...',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textDisabled,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: 200,
            child: AnimatedBuilder(
              animation: progressAnim,
              builder: (_, __) =>
                  _GradientProgressBar(value: progressAnim.value),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientProgressBar extends StatelessWidget {
  final double value;
  const _GradientProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.bg400,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonBlue.withOpacity(0.5),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
