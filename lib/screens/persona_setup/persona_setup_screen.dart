// lib/screens/persona_setup/persona_setup_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'bloc/bloc/persona_setup_bloc.dart';
import 'bloc/event/persona_setup_event.dart';
import 'bloc/state/persona_setup_state.dart';
import 'widget/setup_avatar_step.dart';
import 'widget/setup_confidence_step.dart';
import 'widget/setup_focus_step.dart';
import 'widget/setup_name_step.dart';

class PersonaSetupScreen extends StatefulWidget {
  const PersonaSetupScreen({super.key});

  @override
  State<PersonaSetupScreen> createState() => _PersonaSetupScreenState();
}

class _PersonaSetupScreenState extends State<PersonaSetupScreen>
    with SingleTickerProviderStateMixin {
  final _pageCtrl = PageController();

  late final AnimationController _glowCtrl;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..value = 1.0;
  }

  void _onStepChange(int index) {
    _pageCtrl.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
    // Pulse glow on step change
    _glowCtrl.forward(from: 0);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  // Glow color shifts per step
  Color _getAccentColor(SetupStep step) {
    switch (step) {
      case SetupStep.name:
        return AppColors.neonBlue;
      case SetupStep.avatar:
        return AppColors.neonPurple;
      case SetupStep.confidence:
        return AppColors.neonGreen;
      case SetupStep.focus:
        return AppColors.neonAmber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonaSetupBloc(),
      child: BlocConsumer<PersonaSetupBloc, PersonaSetupState>(
        listenWhen: (prev, curr) =>
            prev.currentStep != curr.currentStep || curr.isCompleted,
        listener: (context, state) {
          if (state.isCompleted) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.personaReport);
          } else {
            _onStepChange(state.stepIndex);
          }
        },
        builder: (context, state) {
          final accentColor = _getAccentColor(state.currentStep);

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(
              children: [
                // ── Ambient glow (shifts per step) ─────────────
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topRight,
                      radius: 0.8,
                      colors: [
                        accentColor.withValues(
                          alpha: Theme.of(context).brightness == Brightness.dark
                              ? 0.08
                              : 0.04,
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                SafeArea(
                  child: Column(
                    children: [
                      // ── Top bar ────────────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenH,
                          vertical: AppSpacing.lg,
                        ),
                        child: _TopBar(state: state),
                      ),

                      // ── Progress bar ───────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenH,
                        ),
                        child: _ProgressBar(state: state, color: accentColor),
                      ),

                      const SizedBox(height: AppSpacing.xl3),

                      // ── Step pages ─────────────────────────
                      Expanded(
                        child: PageView(
                          controller: _pageCtrl,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            _StepPage(child: SetupNameStep()),
                            _StepPage(child: SetupAvatarStep()),
                            _StepPage(child: SetupConfidenceStep()),
                            _StepPage(child: SetupFocusStep()),
                          ],
                        ),
                      ),

                      // ── Bottom CTA ─────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screenH,
                          AppSpacing.lg,
                          AppSpacing.screenH,
                          AppSpacing.xl2,
                        ),
                        child: _CtaButton(
                          label: state.isLast ? 'Build My Persona' : 'Continue',
                          isLast: state.isLast,
                          loading: state.isLoading,
                          enabled: state.canProceed(),
                          accentColor: accentColor,
                          onTap: () {
                            if (state.canProceed()) {
                              if (state.isLast) {
                                context.read<PersonaSetupBloc>().add(
                                  FinishSetup(),
                                );
                              } else {
                                context.read<PersonaSetupBloc>().add(
                                  NextStep(),
                                );
                              }
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

// ─────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final PersonaSetupState state;
  const _TopBar({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button (hidden on first step)
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: state.isFirst ? 0.0 : 1.0,
          child: GestureDetector(
            onTap: state.isFirst
                ? null
                : () => context.read<PersonaSetupBloc>().add(PreviousStep()),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
                size: 18,
              ),
            ),
          ),
        ),

        const Spacer(),

        // Mini logo
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (b) => const LinearGradient(
            colors: AppColors.primaryGradient,
          ).createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
          child: Text('PersonaAI', style: AppTextStyles.titleSM),
        ),

        const Spacer(),

        // Step counter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Text(
            '${state.stepIndex + 1} / ${state.totalSteps}',
            style: AppTextStyles.labelSM.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final PersonaSetupState state;
  final Color color;
  const _ProgressBar({required this.state, required this.color});

  @override
  Widget build(BuildContext context) {
    final progress = (state.stepIndex + 1) / state.totalSteps;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: SizedBox(
        height: 4,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: progress),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          builder: (_, v, __) => LinearProgressIndicator(
            value: v,
            backgroundColor: Theme.of(context).colorScheme.outline,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ),
    );
  }
}

// Wraps each page with horizontal padding
class _StepPage extends StatelessWidget {
  final Widget child;
  const _StepPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
      child: child,
    );
  }
}

class _CtaButton extends StatefulWidget {
  final String label;
  final bool isLast;
  final bool loading;
  final bool enabled;
  final Color accentColor;
  final VoidCallback onTap;

  const _CtaButton({
    required this.label,
    required this.isLast,
    required this.loading,
    required this.enabled,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton>
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
          duration: const Duration(milliseconds: 300),
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
                      color: widget.accentColor.withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.loading
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
                      if (!widget.loading) ...[
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
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
