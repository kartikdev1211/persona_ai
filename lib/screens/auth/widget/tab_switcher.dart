import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/auth/bloc/state/auth_state.dart';

class TabSwitcher extends StatelessWidget {
  final AuthMode mode;
  final Animation<double> slideAnim;
  final VoidCallback onToggle;

  const TabSwitcher({
    super.key,
    required this.mode,
    required this.slideAnim,
    required this.onToggle,
  });

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
                        if (mode == AuthMode.signup) onToggle();
                      },
                      child: Center(
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
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (mode == AuthMode.login) onToggle();
                      },
                      child: Center(
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
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
