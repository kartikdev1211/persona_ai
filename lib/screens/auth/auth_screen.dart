// lib/screens/auth/auth_screen.dart
// CHANGE: _submit() now pushes '/quiz' instead of '/persona-setup'

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/auth/widget/auth_form.dart';
import 'auth_notifier.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _notifier = AuthNotifier();
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _loading = false;

  late final AnimationController _tabCtrl;
  late final Animation<double> _tabSlide;

  @override
  void initState() {
    super.initState();
    _tabCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _tabSlide = CurvedAnimation(parent: _tabCtrl, curve: Curves.easeInOutCubic);
    _notifier.addListener(_onModeChange);
  }

  void _onModeChange() {
    _notifier.isSignup ? _tabCtrl.forward() : _tabCtrl.reverse();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _loading = false);
    // ── UPDATED: go to quiz, not persona-setup directly ──
    Navigator.of(context).pushReplacementNamed('/quiz');
  }

  @override
  void dispose() {
    _notifier.removeListener(_onModeChange);
    _notifier.dispose();
    _tabCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: Stack(
        children: [
          const _AuthGlow(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xl2),
                  _MiniLogo(),
                  const SizedBox(height: AppSpacing.xl3),
                  _TabSwitcher(notifier: _notifier, slideAnim: _tabSlide),
                  const SizedBox(height: AppSpacing.xl3),
                  AuthForm(
                    notifier: _notifier,
                    formKey: _formKey,
                    emailCtrl: _emailCtrl,
                    passwordCtrl: _passwordCtrl,
                    nameCtrl: _nameCtrl,
                    confirmCtrl: _confirmCtrl,
                  ),
                  const SizedBox(height: AppSpacing.xl2),
                  ValueListenableBuilder<AuthMode>(
                    valueListenable: _notifier,
                    builder: (_, mode, __) => _SubmitButton(
                      label: mode == AuthMode.login
                          ? 'Sign In'
                          : 'Create Account',
                      loading: _loading,
                      onTap: _submit,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl2),
                  _OrDivider(),
                  const SizedBox(height: AppSpacing.xl2),
                  _SocialButtons(),
                  const SizedBox(height: AppSpacing.xl3),
                  ValueListenableBuilder<AuthMode>(
                    valueListenable: _notifier,
                    builder: (_, mode, __) => Center(
                      child: GestureDetector(
                        onTap: _notifier.toggleMode,
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodyMD,
                            children: [
                              TextSpan(
                                text: mode == AuthMode.login
                                    ? "Don't have an account? "
                                    : 'Already have an account? ',
                              ),
                              TextSpan(
                                text: mode == AuthMode.login
                                    ? 'Sign Up'
                                    : 'Sign In',
                                style: AppTextStyles.bodyMD.copyWith(
                                  color: AppColors.neonBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────
// Sub-widgets (unchanged)
// ────────────────────────────────────────────

class _AuthGlow extends StatelessWidget {
  const _AuthGlow();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -80,
      right: -80,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [AppColors.neonBlue.withOpacity(0.1), Colors.transparent],
          ),
        ),
      ),
    );
  }
}

class _MiniLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonBlue.withOpacity(0.3),
                blurRadius: 12,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'P',
              style: TextStyle(
                fontFamily: 'Syne',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (b) => const LinearGradient(
            colors: AppColors.primaryGradient,
          ).createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
          child: Text(
            'PersonaAI',
            style: AppTextStyles.titleLG.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _TabSwitcher extends StatelessWidget {
  final AuthNotifier notifier;
  final Animation<double> slideAnim;

  const _TabSwitcher({required this.notifier, required this.slideAnim});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bg300,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final slotW = (constraints.maxWidth - 8) / 2;
          return Stack(
            children: [
              AnimatedBuilder(
                animation: slideAnim,
                builder: (_, __) => Transform.translate(
                  offset: Offset(slideAnim.value * slotW, 0),
                  child: Container(
                    width: slotW,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (notifier.isSignup) notifier.toggleMode();
                      },
                      child: ValueListenableBuilder<AuthMode>(
                        valueListenable: notifier,
                        builder: (_, mode, __) => Center(
                          child: Text(
                            'Sign In',
                            style: AppTextStyles.titleSM.copyWith(
                              color: mode == AuthMode.login
                                  ? AppColors.textInverse
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (notifier.isLogin) notifier.toggleMode();
                      },
                      child: ValueListenableBuilder<AuthMode>(
                        valueListenable: notifier,
                        builder: (_, mode, __) => Center(
                          child: Text(
                            'Sign Up',
                            style: AppTextStyles.titleSM.copyWith(
                              color: mode == AuthMode.signup
                                  ? AppColors.textInverse
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final String label;
  final bool loading;
  final VoidCallback onTap;

  const _SubmitButton({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton>
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
            gradient: const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonBlue.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
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
                : Text(
                    widget.label,
                    style: AppTextStyles.titleMD.copyWith(
                      color: AppColors.textInverse,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text('or continue with', style: AppTextStyles.caption),
        ),
        const Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialBtn(label: 'Google', icon: Icons.g_mobiledata_rounded),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SocialBtn(label: 'Apple', icon: Icons.apple_rounded),
        ),
      ],
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SocialBtn({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.bg300,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: AppTextStyles.titleSM),
          ],
        ),
      ),
    );
  }
}
