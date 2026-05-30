// lib/screens/persona_setup/widget/setup_focus_step.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import '../bloc/bloc/persona_setup_bloc.dart';
import '../bloc/event/persona_setup_event.dart';
import '../bloc/state/persona_setup_state.dart';
import 'setup_name_step.dart';

const _kFocusGoals = [
  (
    emoji: '💬',
    label: 'Communication',
    desc: 'Speak clearly & persuasively',
    color: AppColors.neonBlue,
  ),
  (
    emoji: '🎯',
    label: 'Confidence',
    desc: 'Own every room you enter',
    color: AppColors.neonPurple,
  ),
  (
    emoji: '🧠',
    label: 'Self-Discipline',
    desc: 'Build unbreakable habits',
    color: AppColors.neonGreen,
  ),
  (
    emoji: '🤝',
    label: 'Social Skills',
    desc: 'Connect with anyone instantly',
    color: AppColors.neonBlue,
  ),
  (
    emoji: '🪞',
    label: 'Grooming',
    desc: 'Look & feel your absolute best',
    color: AppColors.neonAmber,
  ),
  (
    emoji: '💼',
    label: 'Career Growth',
    desc: 'Interview, network & lead better',
    color: AppColors.neonPink,
  ),
];

class SetupFocusStep extends StatelessWidget {
  const SetupFocusStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonaSetupBloc, PersonaSetupState>(
      builder: (context, state) {
        final selected = state.focusGoalIndex;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepHeading(
              tag: 'STEP 4 OF 4',
              title: 'Your primary',
              accent: 'focus',
              subtitle: 'Pick one area to master first. You can expand later.',
            ),
            const SizedBox(height: AppSpacing.xl3),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _kFocusGoals.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, i) {
                final goal = _kFocusGoals[i];
                final isSelected = selected == i;
                return GestureDetector(
                  onTap: () =>
                      context.read<PersonaSetupBloc>().add(FocusGoalChanged(i)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? goal.color.withOpacity(0.08)
                          : AppColors.bg300,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(
                        color: isSelected
                            ? goal.color.withOpacity(0.5)
                            : AppColors.glassBorder,
                        width: isSelected ? 1.5 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: goal.color.withOpacity(0.1),
                                blurRadius: 16,
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Text(goal.emoji, style: const TextStyle(fontSize: 26)),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                goal.label,
                                style: AppTextStyles.titleSM.copyWith(
                                  color: isSelected
                                      ? goal.color
                                      : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(goal.desc, style: AppTextStyles.bodySM),
                            ],
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isSelected ? 1.0 : 0.0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: goal.color,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: AppColors.textInverse,
                              size: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
