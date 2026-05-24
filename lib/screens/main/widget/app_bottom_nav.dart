// lib/screens/main/widget/app_bottom_nav.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import '../main_nav_items.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bg200,
        border: const Border(top: BorderSide(color: AppColors.glassBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(kNavItems.length, (i) {
              final item = kNavItems[i];
              final isActive = i == currentIndex;
              return Expanded(
                child: _NavTile(
                  item: item,
                  isActive: isActive,
                  onTap: () => onTap(i),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavTile extends StatefulWidget {
  final NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavTile({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _labelFade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.isActive ? 1.0 : 0.0,
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
    _labelFade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(_NavTile old) {
    super.didUpdateWidget(old);
    if (widget.isActive != old.isActive) {
      widget.isActive ? _ctrl.forward() : _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon + pill indicator
          Stack(
            alignment: Alignment.center,
            children: [
              // Pill bg
              AnimatedBuilder(
                animation: _ctrl,
                builder: (_, __) => Container(
                  width: 44 * _ctrl.value,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.neonBlue.withOpacity(0.12 * _ctrl.value),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
              ),

              // Icon
              ScaleTransition(
                scale: _scale,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    widget.isActive ? widget.item.activeIcon : widget.item.icon,
                    key: ValueKey(widget.isActive),
                    size: 22,
                    color: widget.isActive
                        ? AppColors.neonBlue
                        : AppColors.textDisabled,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 3),

          // Label
          FadeTransition(
            opacity: _labelFade,
            child: Text(
              widget.item.label,
              style: AppTextStyles.labelSM.copyWith(
                color: widget.isActive
                    ? AppColors.neonBlue
                    : AppColors.textDisabled,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
