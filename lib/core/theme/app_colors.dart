// ─────────────────────────────────────────────
// COLORS
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds - Dark
  static const Color bg100 = Color(0xFF090B10); // deepest bg
  static const Color bg200 = Color(0xFF0F1218); // card bg
  static const Color bg300 = Color(0xFF161B24); // elevated card
  static const Color bg400 = Color(0xFF1E2530); // input / chip bg

  // Backgrounds - Light
  static const Color lightBg100 = Color(0xFFF8F9FD); // light scaffold
  static const Color lightBg200 = Color(0xFFFFFFFF); // light card
  static const Color lightBg300 = Color(0xFFF0F2F8); // light elevated
  static const Color lightBg400 = Color(0xFFE2E8F0); // light input

  // Neon Accents
  static const Color neonBlue = Color(0xFF00D4FF); // primary CTA
  static const Color neonPurple = Color(0xFFAB5CF7); // secondary
  static const Color neonGreen = Color(0xFF00F5A0); // success / XP
  static const Color neonAmber = Color(0xFFFFB830); // streak / warn
  static const Color neonPink = Color(0xFFFF4FAD); // challenge

  // Gradients
  static const List<Color> primaryGradient = [
    Color(0xFF00D4FF),
    Color(0xFFAB5CF7),
  ];
  static const List<Color> greenGradient = [
    Color(0xFF00F5A0),
    Color(0xFF00D4FF),
  ];
  static const List<Color> amberGradient = [
    Color(0xFFFFB830),
    Color(0xFFFF4FAD),
  ];
  static const List<Color> cardGlowBlue = [
    Color(0x1A00D4FF),
    Color(0x0000D4FF),
  ];
  static const List<Color> cardGlowPurple = [
    Color(0x1AAB5CF7),
    Color(0x00AB5CF7),
  ];

  // Text - Dark
  static const Color textPrimary = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF8A95A8);
  static const Color textDisabled = Color(0xFF3D4655);

  // Text - Light
  static const Color lightTextPrimary = Color(0xFF1A1F26);
  static const Color lightTextSecondary = Color(0xFF4A5568);
  static const Color lightTextDisabled = Color(0xFF94A3B8);

  static const Color textInverse = Color(0xFF090B10);

  // Semantic
  static const Color success = Color(0xFF00F5A0);
  static const Color warning = Color(0xFFFFB830);
  static const Color error = Color(0xFFFF4F6B);
  static const Color info = Color(0xFF00D4FF);

  // Misc
  static const Color divider = Color(0xFF1E2530);
  static const Color overlay = Color(0x80090B10);
  static const Color glassFill = Color(0x14FFFFFF);
  static const Color glassBorder = Color(0x1AFFFFFF);
}
