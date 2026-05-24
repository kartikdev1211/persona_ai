// lib/features/onboarding/widgets/onboarding_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/onboarding/onboarding_model.dart';
import 'package:persona_ai/screens/onboarding/widget/onboarding_indicators.dart';

class OnboardingNavBar extends StatelessWidget {
  final int currentPage; // 0-3 (3 slides + 1 goals)
  final int totalPages;
  final List<Color> gradient;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final bool canProceed; // false when goals page has 0 selections

  const OnboardingNavBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.gradient,
    required this.onNext,
    required this.onSkip,
    this.canProceed = true,
  });

  bool get _isLastPage => currentPage == totalPages - 1;
  bool get _isGoalsPage => currentPage == totalPages - 1;

  String get _buttonLabel {
    if (_isLastPage) return 'Get Started';
    return 'Continue';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenH,
        AppSpacing.lg,
        AppSpacing.screenH,
        MediaQuery.of(context).padding.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Indicators — hidden on goals page
          if (!_isGoalsPage) ...[
            OnboardingIndicators(
              count: kSlides.length,
              current: currentPage,
              activeGradient: gradient,
            ),
            const SizedBox(height: AppSpacing.xl2),
          ] else
            const SizedBox(height: AppSpacing.lg),

          // Primary button
          _NextButton(
            label: _buttonLabel,
            gradient: gradient,
            enabled: canProceed,
            onTap: onNext,
            isLast: _isLastPage,
          ),

          // Skip — only on slide pages
          if (!_isGoalsPage) ...[
            const SizedBox(height: AppSpacing.md),
            GestureDetector(
              onTap: onSkip,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  'Skip intro',
                  style: AppTextStyles.labelSM.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NextButton extends StatefulWidget {
  final String label;
  final List<Color> gradient;
  final bool enabled;
  final VoidCallback onTap;
  final bool isLast;

  const _NextButton({
    required this.label,
    required this.gradient,
    required this.enabled,
    required this.onTap,
    required this.isLast,
  });

  @override
  State<_NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<_NextButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      upperBound: 1.0,
    )..value = 1.0;
    _scale = _ctrl;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => _ctrl.reverse() : null,
      onTapUp: widget.enabled
          ? (_) {
              _ctrl.forward();
              widget.onTap();
            }
          : null,
      onTapCancel: () => _ctrl.forward(),
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: widget.enabled ? 1.0 : 0.4,
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: widget.gradient),
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: widget.gradient.first.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: AppTextStyles.titleMD.copyWith(
                    color: widget.isLast
                        ? AppColors.textInverse
                        : AppColors.textInverse,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  widget.isLast
                      ? Icons.rocket_launch_rounded
                      : Icons.arrow_forward_rounded,
                  color: AppColors.textInverse,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
