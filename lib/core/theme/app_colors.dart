import 'package:flutter/material.dart';

/// Single source of truth for all application colors.
/// All colors must be declared here — no hardcoded colors allowed in widgets.
class AppColors {
  const AppColors._();

  // Primary Lime/Neon Accent (Figma: Secondary/300 #B9EB42)
  static const Color primary = Color(0xFFB9EB42);
  static const Color primaryLight = Color(0xFFD4F772);
  static const Color primaryDark = Color(0xFF9CCE2B);
  static const Color primarySurface = Color(0x1FB9EB42);

  // Button Colors
  static const Color buttonPrimary = Color(0xFFB9EB42);
  static const Color buttonText = Color(0xFF111827);
  static const Color buttonSecondaryBackground = Color(0xFF060B09);
  static const Color buttonSecondaryText = Color(0xFFF9FAFB);
  static const Color buttonDisabled = Color(0xFF273824);
  static const Color buttonDisabledText = Color(0xFF6B7280);
  static const Color buttonBorder = Color(0xFFB9EB42);
  static const Color starParticle = Color(0xFFF9FAFB);

  // Checkbox Colors (Figma node 1:780)
  static const Color checkboxWhite = Color(0xFFFFFFFF);
  static const Color checkboxCheckmark = Color(0xFF111827);

  // Background & Surface (Theme-aware dark first)
  static const Color background = Color(0xFF0C100E);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFF141C18);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color card = Color(0xFF19241F);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFF1A1A1A);
  static const Color inputBackgroundLight = Color(0xFFF3F4F6);
  static const Color inputBorder = Color(0xFF2C2E2D);
  static const Color inputFocusedBorder = Color(0xFFB9EB42);
  static const Color inputHint = Color(0xFF6B7280);

  // Borders & Dividers
  static const Color border = Color(0xFF2C2E2D);
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFF1F2B24);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textPrimaryDark = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF4B5563);

  // Status & Feedback Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Overlay & Shadows
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);
  static const Color primaryGlow = Color(0x4DB9EB42);
  static const Color slateDot = Color(0xFF475569);
  static const Color transparent = Colors.transparent;
}
