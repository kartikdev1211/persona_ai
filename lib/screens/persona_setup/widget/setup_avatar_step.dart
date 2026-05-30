// lib/screens/persona_setup/widget/setup_avatar_step.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import '../bloc/bloc/persona_setup_bloc.dart';
import '../bloc/event/persona_setup_event.dart';
import '../bloc/state/persona_setup_state.dart';
import 'setup_name_step.dart';

// Each avatar is an emoji + gradient combo
const _kAvatars = [
  (emoji: '🧑‍💻', colors: AppColors.primaryGradient),
  (emoji: '🦁', colors: AppColors.amberGradient),
  (emoji: '🥷', colors: AppColors.primaryGradient),
  (emoji: '🧠', colors: AppColors.greenGradient),
  (emoji: '🚀', colors: AppColors.primaryGradient),
  (emoji: '🎯', colors: AppColors.amberGradient),
  (emoji: '⚡', colors: AppColors.greenGradient),
  (emoji: '🔥', colors: AppColors.amberGradient),
  (emoji: '💎', colors: AppColors.primaryGradient),
];

class SetupAvatarStep extends StatelessWidget {
  const SetupAvatarStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonaSetupBloc, PersonaSetupState>(
      builder: (context, state) {
        final firstName = state.userName.trim().split(' ').first;
        final selected = state.avatarIndex;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepHeading(
              tag: 'STEP 2 OF 4',
              title: 'Choose your',
              accent: 'avatar',
              subtitle: firstName.isNotEmpty
                  ? 'Pick what represents you, $firstName.'
                  : 'Pick what represents you.',
            ),
            const SizedBox(height: AppSpacing.xl3),

            // Selected preview
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutCubic,
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: _AvatarPreview(
                  key: ValueKey(selected),
                  emoji: _kAvatars[selected].emoji,
                  colors: _kAvatars[selected].colors,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl2),

            // Grid picker
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1,
              ),
              itemCount: _kAvatars.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () =>
                    context.read<PersonaSetupBloc>().add(AvatarChanged(i)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: selected == i
                        ? AppColors.neonBlue.withOpacity(0.1)
                        : AppColors.bg300,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: selected == i
                          ? AppColors.neonBlue
                          : AppColors.glassBorder,
                      width: selected == i ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _kAvatars[i].emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AvatarPreview extends StatelessWidget {
  final String emoji;
  final List<Color> colors;

  const _AvatarPreview({super.key, required this.emoji, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.35),
            blurRadius: 28,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 48))),
    );
  }
}
