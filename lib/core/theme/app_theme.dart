// ─────────────────────────────────────────────
// MATERIAL THEME
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg100,
      colorScheme: const ColorScheme.light(
        surface: AppColors.lightBg200,
        primary: AppColors.neonBlue,
        secondary: AppColors.neonPurple,
        tertiary: AppColors.neonGreen,
        error: AppColors.error,
        onSurface: AppColors.lightTextPrimary,
        outline: AppColors.lightBg400,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayXL.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        displayMedium: AppTextStyles.displayLG.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        displaySmall: AppTextStyles.displayMD.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        headlineLarge: AppTextStyles.titleLG.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        headlineMedium: AppTextStyles.titleMD.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        headlineSmall: AppTextStyles.titleSM.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        bodyLarge: AppTextStyles.bodyLG.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        bodyMedium: AppTextStyles.bodyMD.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        bodySmall: AppTextStyles.bodySM.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        labelLarge: AppTextStyles.labelLG.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        labelSmall: AppTextStyles.labelSM.copyWith(
          color: AppColors.lightTextSecondary,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.lightTextSecondary,
        size: 22,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBg400,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightBg400,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.lightBg400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.lightBg400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.neonBlue, width: 1.5),
        ),
        hintStyle: AppTextStyles.bodyMD.copyWith(
          color: AppColors.lightTextDisabled,
        ),
        labelStyle: AppTextStyles.labelLG.copyWith(
          color: AppColors.lightTextPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightBg200,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.lightBg400),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBg100,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Syne',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBg200,
        elevation: 8,
        selectedItemColor: AppColors.neonBlue,
        unselectedItemColor: AppColors.lightTextDisabled,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg100,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.bg200,
        primary: AppColors.neonBlue,
        secondary: AppColors.neonPurple,
        tertiary: AppColors.neonGreen,
        error: AppColors.error,
        onSurface: AppColors.textPrimary,
        outline: AppColors.glassBorder,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayXL.copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTextStyles.displayLG.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTextStyles.displayMD.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineLarge: AppTextStyles.titleLG.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.titleMD.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineSmall: AppTextStyles.titleSM.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTextStyles.bodyLG.copyWith(
          color: AppColors.textSecondary,
        ),
        bodyMedium: AppTextStyles.bodyMD.copyWith(
          color: AppColors.textSecondary,
        ),
        bodySmall: AppTextStyles.bodySM.copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: AppTextStyles.labelLG.copyWith(
          color: AppColors.textPrimary,
        ),
        labelSmall: AppTextStyles.labelSM.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 22),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bg400,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.neonBlue, width: 1.5),
        ),
        hintStyle: AppTextStyles.bodyMD.copyWith(color: AppColors.textDisabled),
        labelStyle: AppTextStyles.labelLG.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.bg200,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.glassBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bg100,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Syne',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bg200,
        elevation: 0,
        selectedItemColor: AppColors.neonBlue,
        unselectedItemColor: AppColors.textDisabled,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.bg200,
        elevation: 0,
        indicatorColor: AppColors.neonBlue.withOpacity(0.15),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: AppColors.neonBlue, size: 22);
          }
          return const IconThemeData(color: AppColors.textDisabled, size: 22);
        }),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppTextStyles.labelSM.copyWith(color: AppColors.neonBlue);
          }
          return AppTextStyles.labelSM;
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.bg300,
        contentTextStyle: AppTextStyles.bodyMD.copyWith(
          color: AppColors.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.neonBlue,
        linearTrackColor: AppColors.bg400,
        circularTrackColor: AppColors.bg400,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.bg400,
        selectedColor: AppColors.neonBlue.withOpacity(0.2),
        labelStyle: AppTextStyles.labelSM,
        side: const BorderSide(color: AppColors.glassBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}
