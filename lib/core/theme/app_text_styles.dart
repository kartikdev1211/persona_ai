// ─────────────────────────────────────────────
// TYPOGRAPHY
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';

class AppTextStyles {
  // Display — Syne (geometric, futuristic)
  static const String _displayFont = 'Syne';
  static const String _bodyFont = 'DM Sans';

  static TextStyle displayXL = const TextStyle(
    fontFamily: _displayFont,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.2,
    height: 1.1,
  );

  static TextStyle displayLG = const TextStyle(
    fontFamily: _displayFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    height: 1.2,
  );

  static TextStyle displayMD = const TextStyle(
    fontFamily: _displayFont,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    height: 1.25,
  );

  static TextStyle titleLG = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
  );

  static TextStyle titleMD = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.35,
  );

  static TextStyle titleSM = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static TextStyle bodyLG = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static TextStyle bodyMD = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  static TextStyle bodySM = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle labelLG = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.6,
  );

  static TextStyle labelSM = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
  );

  static TextStyle caption = const TextStyle(
    fontFamily: _bodyFont,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  // Gradient text helper — use with ShaderMask
  static TextStyle gradientDisplay = displayXL;
}
