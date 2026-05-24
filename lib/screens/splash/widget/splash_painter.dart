import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';

class SplashPainter extends CustomPainter {
  final double progress;
  SplashPainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawOrbs(canvas, size);
  }

  // Subtle dot-grid
  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.glassBorder.withOpacity(0.3 * progress)
      ..style = PaintingStyle.fill;

    const spacing = 28.0;
    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();

    for (var c = 0; c <= cols; c++) {
      for (var r = 0; r <= rows; r++) {
        canvas.drawCircle(Offset(c * spacing, r * spacing), 0.8, paint);
      }
    }
  }

  // Two animated radial glow orbs
  void _drawOrbs(Canvas canvas, Size size) {
    final pulse = math.sin(progress * math.pi * 2) * 0.08;

    // Top-right blue orb
    final blueOrb = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.neonBlue.withOpacity(0.18 + pulse),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.85, size.height * 0.15),
              radius: size.width * 0.55,
            ),
          );
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.15),
      size.width * 0.55,
      blueOrb,
    );

    // Bottom-left purple orb
    final purpleOrb = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.neonPurple.withOpacity(0.14 + pulse),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.15, size.height * 0.85),
              radius: size.width * 0.5,
            ),
          );
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.85),
      size.width * 0.5,
      purpleOrb,
    );
  }

  @override
  bool shouldRepaint(SplashPainter old) => old.progress != progress;
}
