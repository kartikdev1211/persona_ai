// lib/screens/auth/widget/auth_form.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/auth/bloc/state/auth_state.dart';
import 'package:persona_ai/screens/auth/widget/auth_textfield.dart';

class AuthForm extends StatefulWidget {
  final AuthMode mode;
  final GlobalKey<FormState> formKey;

  // Controllers exposed so parent can read values
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController nameCtrl;
  final TextEditingController confirmCtrl;

  const AuthForm({
    super.key,
    required this.mode,
    required this.formKey,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.nameCtrl,
    required this.confirmCtrl,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fade = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));

    _animCtrl.forward();
  }

  @override
  void didUpdateWidget(covariant AuthForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) {
      _animCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSignup = widget.mode == AuthMode.signup;
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Heading ─────────────────────────
              Text(
                isSignup ? 'Create Account' : 'Welcome Back',
                style: AppTextStyles.displayMD,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                isSignup
                    ? 'Start your transformation today'
                    : 'Continue your growth journey',
                style: AppTextStyles.bodyMD,
              ),
              const SizedBox(height: AppSpacing.xl3),

              // ── Name field (signup only) ─────────
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: isSignup
                    ? Column(
                        children: [
                          AuthField(
                            hint: 'Full name',
                            icon: Icons.person_outline_rounded,
                            controller: widget.nameCtrl,
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Enter your name'
                                : null,
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              // ── Email ────────────────────────────
              AuthField(
                hint: 'Email address',
                icon: Icons.mail_outline_rounded,
                controller: widget.emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Enter email';
                  if (!v.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Password ─────────────────────────
              AuthField(
                hint: 'Password',
                icon: Icons.lock_outline_rounded,
                controller: widget.passwordCtrl,
                isPassword: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter password';
                  if (v.length < 6) return 'Min 6 characters';
                  return null;
                },
              ),

              // ── Confirm password (signup only) ───
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: isSignup
                    ? Column(
                        children: [
                          const SizedBox(height: AppSpacing.md),
                          AuthField(
                            hint: 'Confirm password',
                            icon: Icons.lock_outline_rounded,
                            controller: widget.confirmCtrl,
                            isPassword: true,
                            validator: (v) {
                              if (v != widget.passwordCtrl.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              // ── Forgot password (login only) ─────
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: !isSignup
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.md),
                          child: GestureDetector(
                            onTap: () {
                              // TODO: forgot password
                            },
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyles.labelSM.copyWith(
                                color: AppColors.neonBlue,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
