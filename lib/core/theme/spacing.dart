// ─────────────────────────────────────────────
// SPACING & RADIUS
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xl2 = 24;
  static const double xl3 = 32;
  static const double xl4 = 40;
  static const double xl5 = 48;
  static const double xl6 = 64;

  // Screen horizontal padding
  static const double screenH = 20;
}

// ─────────────────────────────────────────────
// SHADOWS & GLOWS
// ─────────────────────────────────────────────
class AppShadows {
  static List<BoxShadow> glowBlue = [
    BoxShadow(
      color: AppColors.neonBlue.withOpacity(0.25),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> glowPurple = [
    BoxShadow(
      color: AppColors.neonPurple.withOpacity(0.25),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> glowGreen = [
    BoxShadow(
      color: AppColors.neonGreen.withOpacity(0.2),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonGlow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.4),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
}

// ─────────────────────────────────────────────
// GRADIENTS
// ─────────────────────────────────────────────
class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: AppColors.primaryGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient green = LinearGradient(
    colors: AppColors.greenGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient amber = LinearGradient(
    colors: AppColors.amberGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bgFade = LinearGradient(
    colors: [AppColors.bg100, AppColors.bg200],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient spotlight = RadialGradient(
    center: Alignment.topCenter,
    radius: 0.8,
    colors: [Color(0x2200D4FF), Colors.transparent],
  );
}

// ─────────────────────────────────────────────
// DURATIONS & CURVES
// ─────────────────────────────────────────────
class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration xSlow = Duration(milliseconds: 900);
}

class AppCurves {
  static const Curve standard = Curves.easeInOut;
  static const Curve enter = Curves.easeOut;
  static const Curve exit = Curves.easeIn;
  static const Curve spring = Curves.elasticOut;
  static const Curve smooth = Curves.fastOutSlowIn;
}

class AppRadius {
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double xl2 = 32;
  static const double full = 999;
}
