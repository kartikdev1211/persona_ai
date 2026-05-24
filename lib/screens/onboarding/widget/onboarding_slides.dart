// lib/features/onboarding/widgets/onboarding_slide.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/onboarding/onboarding_model.dart';

class OnboardingSlideView extends StatelessWidget {
  final OnboardingSlide slide;
  final double opacity; // driven by page scroll

  const OnboardingSlideView({
    super.key,
    required this.slide,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _IllustrationCard(slide: slide),
            const SizedBox(height: AppSpacing.xl3),
            _TagLine(tag: slide.tag),
            const SizedBox(height: AppSpacing.md),
            _TitleBlock(slide: slide),
            const SizedBox(height: AppSpacing.lg),
            Text(
              slide.body,
              style: AppTextStyles.bodyLG.copyWith(height: 1.65),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _IllustrationCard extends StatelessWidget {
  final OnboardingSlide slide;
  const _IllustrationCard({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            slide.glowColors[0].withOpacity(0.12),
            slide.glowColors[1].withOpacity(0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl2),
        border: Border.all(color: slide.glowColors[0].withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: slide.glowColors[0].withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: slide.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Icon(slide.icon, size: 80, color: Colors.white),
        ),
      ),
    );
  }
}

class _TagLine extends StatelessWidget {
  final String tag;
  const _TagLine({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        tag,
        style: AppTextStyles.labelSM.copyWith(
          letterSpacing: 1.6,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  final OnboardingSlide slide;
  const _TitleBlock({required this.slide});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.displayLG,
        children: [
          TextSpan(text: '${slide.title} '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                colors: slide.gradient,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(slide.titleAccent, style: AppTextStyles.displayLG),
            ),
          ),
        ],
      ),
    );
  }
}
