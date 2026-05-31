// lib/screens/home/widget/home_header.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/common_widget/chips.dart';
import 'package:persona_ai/models/home/home_model.dart';

class HomeHeader extends StatelessWidget {
  final UserStats user;

  const HomeHeader({super.key, required this.user});

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Top row: greeting + avatar ─────
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _greeting,
                    style: AppTextStyles.bodyMD.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.displayMD.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(text: '${user.name} '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (b) =>
                                const LinearGradient(
                                  colors: AppColors.primaryGradient,
                                ).createShader(
                                  Rect.fromLTWH(0, 0, b.width, b.height),
                                ),
                            child: Text('⚡', style: AppTextStyles.displayMD),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Avatar + level badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonBlue.withOpacity(0.3),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      user.avatarEmoji,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                // Level badge
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Text(
                      'Lv ${user.level}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.neonBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        // ── XP bar ─────────────────────────
        _XpBar(user: user),

        const SizedBox(height: AppSpacing.md),

        // ── Chips row ──────────────────────
        Row(
          children: [
            XpChip(xp: user.xp),
            const SizedBox(width: AppSpacing.sm),
            StreakChip(days: user.streakDays),
            const Spacer(),
            // Confidence score pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.neonPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.full),
                border: Border.all(
                  color: AppColors.neonPurple.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.psychology_rounded,
                    color: AppColors.neonPurple,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${(user.confidenceScore * 100).toInt()} CI',
                    style: AppTextStyles.labelSM.copyWith(
                      color: AppColors.neonPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _XpBar extends StatelessWidget {
  final UserStats user;
  const _XpBar({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'XP Progress',
              style: AppTextStyles.caption.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            Text(
              '${user.xp} / ${user.xpToNext} XP',
              style: AppTextStyles.caption.copyWith(color: AppColors.neonGreen),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: SizedBox(
            height: 5,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: user.xpProgress),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (_, v, __) => LinearProgressIndicator(
                value: v,
                backgroundColor: Theme.of(context).colorScheme.outline,
                valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
