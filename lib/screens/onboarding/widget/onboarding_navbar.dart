// lib/screens/onboarding/widget/onboarding_navbar.dart
// CHANGES: removed _isGoalsPage logic, canProceed always true,
//          indicators and skip always visible, last page label = 'Get Started'

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/onboarding/widget/onboarding_indicators.dart';

class OnboardingNavBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final List<Color> gradient;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingNavBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.gradient,
    required this.onNext,
    required this.onSkip,
  });

  bool get _isLastPage => currentPage == totalPages - 1;

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
          // Dot indicators — always visible
          OnboardingIndicators(
            count: totalPages,
            current: currentPage,
            activeGradient: gradient,
          ),
          const SizedBox(height: AppSpacing.xl2),

          // Primary CTA
          _NextButton(
            label: _isLastPage ? 'Get Started' : 'Continue',
            gradient: gradient,
            onTap: onNext,
            isLast: _isLastPage,
          ),

          // Skip — hidden on last slide (the CTA already exits)
          if (!_isLastPage) ...[
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
  final VoidCallback onTap;
  final bool isLast;

  const _NextButton({
    required this.label,
    required this.gradient,
    required this.onTap,
    required this.isLast,
  });

  @override
  State<_NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<_NextButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      upperBound: 1.0,
    )..value = 1.0;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.reverse(),
      onTapUp: (_) {
        _ctrl.forward();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.forward(),
      child: ScaleTransition(
        scale: _ctrl,
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
                  color: AppColors.textInverse,
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
    );
  }
}
