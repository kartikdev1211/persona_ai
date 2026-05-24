import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? glowColor;
  final double? borderRadius;
  final Gradient? gradient;
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.glowColor,
    this.borderRadius,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient:
            gradient ??
            const LinearGradient(
              colors: [AppColors.bg200, AppColors.bg300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.lg),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: [
          if (glowColor != null)
            BoxShadow(
              color: glowColor!.withOpacity(0.15),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ...AppShadows.cardShadow,
        ],
      ),
      child: child,
    );
  }
}
