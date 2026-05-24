// lib/features/onboarding/widgets/onboarding_goals.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/onboarding/onboarding_model.dart';

class OnboardingGoalsPage extends StatefulWidget {
  final ValueChanged<List<int>> onSelectionChanged;

  const OnboardingGoalsPage({super.key, required this.onSelectionChanged});

  @override
  State<OnboardingGoalsPage> createState() => _OnboardingGoalsPageState();
}

class _OnboardingGoalsPageState extends State<OnboardingGoalsPage> {
  final Set<int> _selected = {};

  void _toggle(int i) {
    setState(() {
      _selected.contains(i) ? _selected.remove(i) : _selected.add(i);
    });
    widget.onSelectionChanged(_selected.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl2),
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.glassFill,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Text(
                    'YOUR GOALS',
                    style: AppTextStyles.labelSM.copyWith(
                      letterSpacing: 1.6,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.displayLG,
                    children: [
                      const TextSpan(text: "What do you want to\n"),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (b) =>
                              const LinearGradient(
                                colors: AppColors.primaryGradient,
                              ).createShader(
                                Rect.fromLTWH(0, 0, b.width, b.height),
                              ),
                          child: Text(
                            'improve?',
                            style: AppTextStyles.displayLG,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text('Select all that apply', style: AppTextStyles.bodyMD),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl2),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kGoals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 2.6,
            ),
            itemBuilder: (_, i) => _GoalTile(
              goal: kGoals[i],
              selected: _selected.contains(i),
              onTap: () => _toggle(i),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalTile extends StatelessWidget {
  final GoalOption goal;
  final bool selected;
  final VoidCallback onTap;

  const _GoalTile({
    required this.goal,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: [Color(0x2200D4FF), Color(0x14AB5CF7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected ? null : AppColors.bg300,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected
                ? AppColors.neonBlue.withOpacity(0.5)
                : AppColors.glassBorder,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.neonBlue.withOpacity(0.12),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Text(goal.emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    goal.label,
                    style: AppTextStyles.titleSM.copyWith(
                      color: selected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.neonBlue,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
