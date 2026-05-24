// lib/screens/home/widget/mission_card.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/common_widget/chips.dart';
import 'package:persona_ai/models/home/home_model.dart';

class MissionCard extends StatefulWidget {
  final DailyMission mission;
  final VoidCallback? onTap;

  const MissionCard({super.key, required this.mission, this.onTap});

  @override
  State<MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<MissionCard>
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
    final m = widget.mission;
    final isCompleted = m.isCompleted;

    return GestureDetector(
      onTapDown: (_) => _ctrl.reverse(),
      onTapUp: (_) {
        _ctrl.forward();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.forward(),
      child: ScaleTransition(
        scale: _ctrl,
        child: Opacity(
          opacity: isCompleted ? 0.6 : 1.0,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.bg200,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: isCompleted
                    ? AppColors.glassBorder
                    : m.gradient.first.withOpacity(0.3),
              ),
              boxShadow: isCompleted
                  ? []
                  : [
                      BoxShadow(
                        color: m.gradient.first.withOpacity(0.08),
                        blurRadius: 20,
                      ),
                    ],
            ),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: isCompleted
                        ? null
                        : LinearGradient(colors: m.gradient),
                    color: isCompleted ? AppColors.bg400 : null,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(
                            Icons.check_rounded,
                            color: AppColors.neonGreen,
                            size: 22,
                          )
                        : Icon(m.icon, color: Colors.white, size: 22),
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              m.title,
                              style: AppTextStyles.titleSM.copyWith(
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor: AppColors.textDisabled,
                              ),
                            ),
                          ),
                          if (isCompleted)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.neonGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.full,
                                ),
                              ),
                              child: Text(
                                'Done',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.neonGreen,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        m.description,
                        style: AppTextStyles.bodySM,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          XpChip(xp: m.xpReward),
                          const SizedBox(width: AppSpacing.sm),
                          Icon(
                            Icons.timer_outlined,
                            size: 11,
                            color: AppColors.textDisabled,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${m.durationMinutes} min',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (!isCompleted) ...[
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.textDisabled,
                    size: 14,
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
