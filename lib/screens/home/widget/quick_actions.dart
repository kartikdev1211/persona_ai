// lib/screens/home/widget/quick_actions.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuickTile(
          label: 'AI Coach',
          icon: Icons.psychology_rounded,
          color: AppColors.neonPurple,
          onTap: () {},
        ),
        const SizedBox(width: AppSpacing.md),
        _QuickTile(
          label: 'Progress',
          icon: Icons.bar_chart_rounded,
          color: AppColors.neonGreen,
          onTap: () {},
        ),
        const SizedBox(width: AppSpacing.md),
        _QuickTile(
          label: 'Challenge',
          icon: Icons.local_fire_department_rounded,
          color: AppColors.neonPink,
          onTap: () {},
        ),
      ],
    );
  }
}

class _QuickTile extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_QuickTile> createState() => _QuickTileState();
}

class _QuickTileState extends State<_QuickTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.94,
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
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _ctrl.reverse(),
        onTapUp: (_) {
          _ctrl.forward();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.forward(),
        child: ScaleTransition(
          scale: _ctrl,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: widget.color.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Icon(widget.icon, color: widget.color, size: 22),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  widget.label,
                  style: AppTextStyles.caption.copyWith(
                    color: widget.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
