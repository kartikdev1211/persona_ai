import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: color ?? AppColors.textSecondary,
            size: 20,
          ),
          title: Text(
            title,
            style: AppTextStyles.bodyMD.copyWith(color: color),
          ),
          trailing:
              trailing ?? const Icon(Icons.chevron_right_rounded, size: 20),
        ),
      ),
    );
  }
}
