import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography definitions for Deen App
class AppTypography {
  const AppTypography._();

  // Arabic Quranic Typography
  static TextStyle arabicHeader({Color? color}) => GoogleFonts.amiri(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    height: 1.8,
    color: color,
  );

  static TextStyle arabicBody({Color? color}) => GoogleFonts.amiri(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.6,
    color: color,
  );

  // English / Standard Display Typography
  static TextStyle displayLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: color,
  );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: color,
  );

  static TextStyle headlineLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle headlineMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle titleLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle bodyLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: color,
  );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: color,
  );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle labelLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: color,
  );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: color,
  );
}
