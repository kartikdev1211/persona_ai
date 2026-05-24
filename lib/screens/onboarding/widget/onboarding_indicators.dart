// lib/features/onboarding/widgets/onboarding_indicators.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class OnboardingIndicators extends StatelessWidget {
  final int count;
  final int current;
  final List<Color> activeGradient;

  const OnboardingIndicators({
    super.key,
    required this.count,
    required this.current,
    required this.activeGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 24 : 6,
          height: 6,
          decoration: BoxDecoration(
            gradient: isActive ? LinearGradient(colors: activeGradient) : null,
            color: isActive ? null : AppColors.bg400,
            borderRadius: BorderRadius.circular(AppRadius.full),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: activeGradient.first.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
