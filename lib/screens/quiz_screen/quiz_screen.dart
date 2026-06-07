// lib/screens/quiz_screen/quiz_screen.dart

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/core/utils/ui_utils.dart';
import 'package:persona_ai/models/quiz/quiz_model.dart';
import 'package:persona_ai/screens/quiz_screen/bloc/bloc/quiz_bloc.dart';
import 'package:persona_ai/screens/quiz_screen/bloc/event/quiz_event.dart';
import 'package:persona_ai/screens/quiz_screen/bloc/state/quiz_state.dart';
import 'widget/quiz_option_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
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

  Future<void> _handlePageTransition(VoidCallback action) async {
    await _fadeCtrl.reverse();
    action();
    _fadeCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: BlocConsumer<QuizBloc, QuizState>(
        listenWhen: (prev, curr) =>
            prev.isLoading != curr.isLoading ||
            prev.isCompleted != curr.isCompleted ||
            prev.error != curr.error,
        listener: (context, state) {
          if (state.isLoading) {
            UIUtils.showLoader(context);
          } else {
            UIUtils.hideLoader(context);
          }

          if (state.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              UIUtils.showSnackBar(
                context: context,
                title: 'Assessment Completed',
                message: 'Your profile has been built successfully!',
                contentType: ContentType.success,
              );
            });
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.personaSetup);
            });
          }

          if (state.error != null) {
            UIUtils.showSnackBar(
              context: context,
              title: 'Submission Failed',
              message: state.error!,
              contentType: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          final current = kQuizQuestions[state.currentIndex];
          final progress = (state.currentIndex + 1) / kQuizQuestions.length;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(
              children: [
                // Ambient glow
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 0.9,
                      colors: [
                        AppColors.neonBlue.withValues(
                          alpha: Theme.of(context).brightness == Brightness.dark
                              ? 0.06
                              : 0.03,
                        ),
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
                              onTap: state.currentIndex > 0
                                  ? () => _handlePageTransition(() {
                                      context.read<QuizBloc>().add(
                                        PreviousQuestion(),
                                      );
                                    })
                                  : null,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: state.currentIndex > 0 ? 1.0 : 0.0,
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.sm,
                                    ),
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
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
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.full,
                                ),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              child: Text(
                                '${state.currentIndex + 1} of ${kQuizQuestions.length}',
                                style: AppTextStyles.labelSM.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ),

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
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.outline,
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
                                  current.emoji,
                                  style: const TextStyle(fontSize: 40),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                Text(
                                  current.question,
                                  style: AppTextStyles.displayMD.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
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
                              itemCount: current.options.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: AppSpacing.md),
                              itemBuilder: (_, i) => QuizOptionCard(
                                label: current.options[i],
                                isSelected:
                                    state.answers[state.currentIndex] == i,
                                onTap: () => context.read<QuizBloc>().add(
                                  SelectOption(i),
                                ),
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
                          label: state.isLast ? 'Build My Profile' : 'Next',
                          isLast: state.isLast,
                          isLoading: state.isLoading,
                          enabled: state.canProceed && !state.isLoading,
                          onTap: () {
                            if (state.isLast) {
                              context.read<QuizBloc>().add(NextQuestion());
                            } else {
                              _handlePageTransition(() {
                                context.read<QuizBloc>().add(NextQuestion());
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NextButton extends StatefulWidget {
  final String label;
  final bool isLast;
  final bool enabled;
  final bool isLoading;
  final VoidCallback onTap;

  const _NextButton({
    required this.label,
    required this.isLast,
    required this.enabled,
    this.isLoading = false,
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
            color: widget.enabled
                ? null
                : Theme.of(context).colorScheme.outline,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: widget.enabled
                ? [
                    BoxShadow(
                      color:
                          (widget.isLast
                                  ? AppColors.neonGreen
                                  : AppColors.neonBlue)
                              .withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(AppColors.textInverse),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.label,
                        style: AppTextStyles.titleMD.copyWith(
                          color: widget.enabled
                              ? AppColors.textInverse
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.4),
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
                            : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.4),
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
