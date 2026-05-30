// lib/screens/auth/auth_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/auth/bloc/bloc/auth_bloc.dart';
import 'package:persona_ai/screens/auth/bloc/event/auth_event.dart';
import 'package:persona_ai/screens/auth/bloc/state/auth_state.dart';
import 'package:persona_ai/screens/auth/widget/auth_form.dart';
import 'package:persona_ai/screens/auth/widget/submit_button.dart';
import 'package:persona_ai/screens/auth/widget/tab_switcher.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

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
  }

  void _onModeChange(AuthMode mode) {
    mode == AuthMode.signup ? _tabCtrl.forward() : _tabCtrl.reverse();
  }

  void _submit(BuildContext context, AuthState state) {
    if (!_formKey.currentState!.validate()) return;

    if (state.mode == AuthMode.login) {
      context.read<AuthBloc>().add(
        LoginRequested(email: _emailCtrl.text, password: _passwordCtrl.text),
      );
    } else {
      context.read<AuthBloc>().add(
        SignupRequested(
          name: _nameCtrl.text,
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            prev.mode != curr.mode || prev.status != curr.status,
        listener: (context, state) {
          _onModeChange(state.mode);
          if (state.status == AuthStatus.success) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.quiz);
          }
          if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication failed'),
              ),
            );
          }
        },
        builder: (context, state) {
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
                        TabSwitcher(
                          mode: state.mode,
                          slideAnim: _tabSlide,
                          onToggle: () =>
                              context.read<AuthBloc>().add(ToggleMode()),
                        ),
                        const SizedBox(height: AppSpacing.xl3),
                        AuthForm(
                          mode: state.mode,
                          formKey: _formKey,
                          emailCtrl: _emailCtrl,
                          passwordCtrl: _passwordCtrl,
                          nameCtrl: _nameCtrl,
                          confirmCtrl: _confirmCtrl,
                        ),
                        const SizedBox(height: AppSpacing.xl2),
                        SubmitButton(
                          label: state.mode == AuthMode.login
                              ? 'Sign In'
                              : 'Create Account',
                          loading: state.status == AuthStatus.loading,
                          onTap: () => _submit(context, state),
                        ),
                        const SizedBox(height: AppSpacing.xl2),
                        _OrDivider(),
                        const SizedBox(height: AppSpacing.xl2),
                        _SocialButtons(),
                        const SizedBox(height: AppSpacing.xl3),
                        Center(
                          child: GestureDetector(
                            onTap: () =>
                                context.read<AuthBloc>().add(ToggleMode()),
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyles.bodyMD,
                                children: [
                                  TextSpan(
                                    text: state.mode == AuthMode.login
                                        ? "Don't have an account? "
                                        : 'Already have an account? ',
                                  ),
                                  TextSpan(
                                    text: state.mode == AuthMode.login
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
                        const SizedBox(height: AppSpacing.xl3),
                      ],
                    ),
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

// ────────────────────────────────────────────
// Sub-widgets
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
