// lib/screens/quiz/quiz_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/quiz/quiz_model.dart';
import 'widget/quiz_option_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<int?> _answers = List.filled(kQuizQuestions.length, null);

  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    )..value = 1.0;
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0.06, 0),
      end: Offset.zero,
    ).animate(_fadeAnim);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  QuizQuestion get _current => kQuizQuestions[_currentIndex];
  bool get _isLast => _currentIndex == kQuizQuestions.length - 1;
  bool get _canProceed => _answers[_currentIndex] != null;

  void _selectOption(int optionIndex) {
    setState(() => _answers[_currentIndex] = optionIndex);
  }

  Future<void> _next() async {
    if (!_canProceed) return;

    if (_isLast) {
      Navigator.of(context).pushReplacementNamed('/persona-setup');
      return;
    }

    // Animate out
    await _fadeCtrl.reverse();
    setState(() => _currentIndex++);
    // Animate in
    _fadeCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentIndex + 1) / kQuizQuestions.length;

    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: Stack(
        children: [
          // Ambient glow — shifts subtly per question
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 0.9,
                colors: [
                  AppColors.neonBlue.withOpacity(0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top bar ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenH,
                    AppSpacing.lg,
                    AppSpacing.screenH,
                    0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: _currentIndex > 0
                            ? () async {
                                await _fadeCtrl.reverse();
                                setState(() => _currentIndex--);
                                _fadeCtrl.forward();
                              }
                            : null,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _currentIndex > 0 ? 1.0 : 0.0,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.bg300,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              border: Border.all(color: AppColors.glassBorder),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.textSecondary,
                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      // Step counter pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.bg300,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Text(
                          '${_currentIndex + 1} of ${kQuizQuestions.length}',
                          style: AppTextStyles.labelSM,
                        ),
                      ),

                      // Skip — invisible placeholder for balance
                      const SizedBox(width: 38),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Progress bar ────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH,
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    builder: (_, v, __) => ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      child: LinearProgressIndicator(
                        value: v,
                        minHeight: 4,
                        backgroundColor: AppColors.bg400,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.neonBlue,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl3),

                // ── Question ────────────────────────────
                FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenH,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _current.emoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            _current.question,
                            style: AppTextStyles.displayMD,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl2),

                // ── Options ─────────────────────────────
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenH,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _current.options.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (_, i) => QuizOptionCard(
                          label: _current.options[i],
                          isSelected: _answers[_currentIndex] == i,
                          onTap: () => _selectOption(i),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── CTA button ──────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenH,
                    AppSpacing.lg,
                    AppSpacing.screenH,
                    AppSpacing.xl2,
                  ),
                  child: _NextButton(
                    label: _isLast ? 'Build My Profile' : 'Next',
                    isLast: _isLast,
                    enabled: _canProceed,
                    onTap: _next,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CTA Button
// ─────────────────────────────────────────────
class _NextButton extends StatefulWidget {
  final String label;
  final bool isLast;
  final bool enabled;
  final VoidCallback onTap;

  const _NextButton({
    required this.label,
    required this.isLast,
    required this.enabled,
    required this.onTap,
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
      lowerBound: 0.97,
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
      onTapDown: widget.enabled ? (_) => _ctrl.reverse() : null,
      onTapUp: widget.enabled
          ? (_) {
              _ctrl.forward();
              widget.onTap();
            }
          : null,
      onTapCancel: () => _ctrl.forward(),
      child: ScaleTransition(
        scale: _ctrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 54,
          decoration: BoxDecoration(
            gradient: widget.enabled
                ? LinearGradient(
                    colors: widget.isLast
                        ? AppColors.greenGradient
                        : AppColors.primaryGradient,
                  )
                : null,
            color: widget.enabled ? null : AppColors.bg400,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: widget.enabled
                ? [
                    BoxShadow(
                      color:
                          (widget.isLast
                                  ? AppColors.neonGreen
                                  : AppColors.neonBlue)
                              .withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: AppTextStyles.titleMD.copyWith(
                    color: widget.enabled
                        ? AppColors.textInverse
                        : AppColors.textDisabled,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  widget.isLast
                      ? Icons.auto_awesome_rounded
                      : Icons.arrow_forward_rounded,
                  color: widget.enabled
                      ? AppColors.textInverse
                      : AppColors.textDisabled,
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
