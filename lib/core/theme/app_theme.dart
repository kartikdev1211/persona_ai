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
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.neonBlue,
        secondary: AppColors.neonPurple,
        tertiary: AppColors.neonGreen,
        error: AppColors.error,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayXL.copyWith(color: Colors.black),
        displayMedium: AppTextStyles.displayLG.copyWith(color: Colors.black),
        displaySmall: AppTextStyles.displayMD.copyWith(color: Colors.black),
        bodyMedium: AppTextStyles.bodyMD.copyWith(color: Colors.black87),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg100,
      colorScheme: const ColorScheme.dark(
        background: AppColors.bg100,
        surface: AppColors.bg200,
        primary: AppColors.neonBlue,
        secondary: AppColors.neonPurple,
        tertiary: AppColors.neonGreen,
        error: AppColors.error,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onPrimary: AppColors.textInverse,
        outline: AppColors.glassBorder,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayXL,
        displayMedium: AppTextStyles.displayLG,
        displaySmall: AppTextStyles.displayMD,
        headlineLarge: AppTextStyles.titleLG,
        headlineMedium: AppTextStyles.titleMD,
        headlineSmall: AppTextStyles.titleSM,
        bodyLarge: AppTextStyles.bodyLG,
        bodyMedium: AppTextStyles.bodyMD,
        bodySmall: AppTextStyles.bodySM,
        labelLarge: AppTextStyles.labelLG,
        labelSmall: AppTextStyles.labelSM,
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
        hintStyle: AppTextStyles.bodyMD,
        labelStyle: AppTextStyles.labelLG,
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
