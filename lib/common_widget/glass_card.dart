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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient:
            gradient ??
            LinearGradient(
              colors: isDark
                  ? [AppColors.bg200, AppColors.bg300]
                  : [AppColors.lightBg200, AppColors.lightBg300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.lg),
        border: Border.all(
          color: isDark ? AppColors.glassBorder : AppColors.lightBg400,
        ),
        boxShadow: [
          if (glowColor != null)
            BoxShadow(
              color: glowColor!.withOpacity(isDark ? 0.15 : 0.1),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          else
            ...AppShadows.cardShadow,
        ],
      ),
      child: child,
    );
  }
}
