import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class ProgressRing extends StatelessWidget {
  final double value; // 0.0 - 1.0
  final double size;
  final double strokeWidth;
  final Color? color;
  final Widget? center;

  const ProgressRing({
    super.key,
    required this.value,
    this.size = 80,
    this.strokeWidth = 6,
    this.color,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: AppDurations.slow,
            curve: AppCurves.smooth,
            builder: (_, v, __) => CircularProgressIndicator(
              value: v,
              strokeWidth: strokeWidth,
              backgroundColor: AppColors.bg400,
              valueColor: AlwaysStoppedAnimation(color ?? AppColors.neonBlue),
              strokeCap: StrokeCap.round,
            ),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}
