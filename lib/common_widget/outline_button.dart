import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final double? width;

  const OutlineButton({
    super.key,
    required this.label,
    required this.onTap,
    this.borderColor,
    this.textColor,
    this.height = 52,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.glassFill,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: borderColor ?? AppColors.glassBorder),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.titleMD.copyWith(
              color: textColor ?? AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
