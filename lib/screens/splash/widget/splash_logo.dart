// lib/features/splash/widgets/splash_logo.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class SplashLogo extends StatelessWidget {
  final Animation<double> fadeAnim;
  final Animation<double> slideAnim;

  const SplashLogo({
    super.key,
    required this.fadeAnim,
    required this.slideAnim,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
        ).animate(slideAnim),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LogoMark(),
            const SizedBox(height: AppSpacing.xl),
            _WordMark(),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your AI-powered growth companion',
              style: AppTextStyles.bodyMD.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Hexagonal icon mark with gradient
class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withOpacity(0.35),
            blurRadius: 28,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'P',
          style: TextStyle(
            fontFamily: 'Syne',
            fontSize: 44,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
    );
  }
}

// "PersonaAI" gradient wordmark
class _WordMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: AppColors.primaryGradient,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        'PersonaAI',
        style: AppTextStyles.displayLG.copyWith(
          letterSpacing: -1.0,
          color: Colors.white, // overridden by ShaderMask
        ),
      ),
    );
  }
}
