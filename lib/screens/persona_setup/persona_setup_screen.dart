// lib/screens/persona_setup/persona_setup_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'persona_setup_notifier.dart';
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
  final _notifier = PersonaSetupNotifier();
  final _pageCtrl = PageController();
  bool _loading = false;

  late final AnimationController _glowCtrl;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..value = 1.0;
    _glowAnim = CurvedAnimation(parent: _glowCtrl, curve: Curves.easeOut);
    _notifier.addListener(_onStepChange);
  }

  void _onStepChange() {
    _pageCtrl.animateToPage(
      _notifier.stepIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
    // Pulse glow on step change
    _glowCtrl.forward(from: 0);
    setState(() {});
  }

  Future<void> _finish() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200)); // replace w/ save
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _onNext() {
    if (!_notifier.canProceed()) return;
    if (_notifier.isLast) {
      _finish();
    } else {
      _notifier.next();
    }
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStepChange);
    _notifier.dispose();
    _pageCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  // Glow color shifts per step
  Color get _accentColor {
    switch (_notifier.value) {
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
    return Scaffold(
      backgroundColor: AppColors.bg100,
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
                colors: [_accentColor.withOpacity(0.08), Colors.transparent],
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
                  child: _TopBar(notifier: _notifier),
                ),

                // ── Progress bar ───────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH,
                  ),
                  child: _ProgressBar(notifier: _notifier, color: _accentColor),
                ),

                const SizedBox(height: AppSpacing.xl3),

                // ── Step pages ─────────────────────────
                Expanded(
                  child: PageView(
                    controller: _pageCtrl,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _StepPage(child: SetupNameStep(notifier: _notifier)),
                      _StepPage(child: SetupAvatarStep(notifier: _notifier)),
                      _StepPage(
                        child: SetupConfidenceStep(notifier: _notifier),
                      ),
                      _StepPage(child: SetupFocusStep(notifier: _notifier)),
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
                  child: ValueListenableBuilder<SetupStep>(
                    valueListenable: _notifier,
                    builder: (_, __, ___) => _CtaButton(
                      label: _notifier.isLast ? 'Build My Persona' : 'Continue',
                      isLast: _notifier.isLast,
                      loading: _loading,
                      enabled: _notifier.canProceed(),
                      accentColor: _accentColor,
                      onTap: _onNext,
                    ),
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
// Sub-widgets
// ─────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final PersonaSetupNotifier notifier;
  const _TopBar({required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button (hidden on first step)
        ValueListenableBuilder<SetupStep>(
          valueListenable: notifier,
          builder: (_, __, ___) => AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: notifier.isFirst ? 0.0 : 1.0,
            child: GestureDetector(
              onTap: notifier.isFirst ? null : notifier.back,
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
        ValueListenableBuilder<SetupStep>(
          valueListenable: notifier,
          builder: (_, __, ___) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.bg300,
              borderRadius: BorderRadius.circular(AppRadius.full),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Text(
              '${notifier.stepIndex + 1} / ${notifier.totalSteps}',
              style: AppTextStyles.labelSM,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final PersonaSetupNotifier notifier;
  final Color color;
  const _ProgressBar({required this.notifier, required this.color});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SetupStep>(
      valueListenable: notifier,
      builder: (_, __, ___) {
        final progress = (notifier.stepIndex + 1) / notifier.totalSteps;
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
                backgroundColor: AppColors.bg400,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Wraps each page with horizontal padding + fade-slide entrance
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
            color: widget.enabled ? null : AppColors.bg400,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: widget.enabled
                ? [
                    BoxShadow(
                      color: widget.accentColor.withOpacity(0.35),
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
                              : AppColors.textDisabled,
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
                              : AppColors.textDisabled,
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
