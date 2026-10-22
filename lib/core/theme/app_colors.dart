import 'package:flutter/material.dart';

/// Semantic color palette for Deen App
class AppColors {
  const AppColors._();

  // Primary Islamic Emerald Palette
  static const Color primary = Color(0xFF104A36);
  static const Color primaryLight = Color(0xFF1B6A4E);
  static const Color primaryDark = Color(0xFF093123);
  static const Color primarySurface = Color(0xFFEAF5EF);

  // Accent Gold Palette
  static const Color accent = Color(0xFFD4AF37);
  static const Color accentLight = Color(0xFFF0DA8A);
  static const Color accentDark = Color(0xFF9E7C1B);

  // Background & Surface (Light)
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE5E7EB);

  // Background & Surface (Dark)
  static const Color backgroundDark = Color(0xFF0F1713);
  static const Color surfaceDark = Color(0xFF16231D);
  static const Color cardDark = Color(0xFF1C2D25);
  static const Color borderDark = Color(0xFF263830);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);

  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textTertiaryDark = Color(0xFF6B7280);

  // Status & Utility Colors
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  // Shimmer / Placeholder
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}
