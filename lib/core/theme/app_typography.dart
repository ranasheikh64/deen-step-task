import 'package:deen_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized Typography definitions matching Figma specifications
class AppTypography {
  const AppTypography._();

  // Button Typography (Figma: Poppins Bold 16px, line-height 1.4, letter-spacing 0.2px)
  static TextStyle buttonLarge({Color? color}) => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.2,
    color: color ?? AppColors.buttonText,
  );

  static TextStyle buttonMedium({Color? color}) => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.2,
    color: color ?? AppColors.buttonText,
  );

  static TextStyle buttonSmall({Color? color}) => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.1,
    color: color ?? AppColors.buttonText,
  );

  // General Text Styles
  static TextStyle displayLarge({Color? color}) => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: color ?? AppColors.textPrimary,
  );

  static TextStyle headlineLarge({Color? color}) => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimary,
  );

  static TextStyle headlineMedium({Color? color}) => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
  );

  static TextStyle titleLarge({Color? color}) => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
  );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
  );

  static TextStyle bodyLarge({Color? color}) => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: color ?? AppColors.textPrimary,
  );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: color ?? AppColors.textSecondary,
  );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color ?? AppColors.textTertiary,
  );
}
