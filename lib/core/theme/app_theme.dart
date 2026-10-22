import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// App ThemeData configuration for Light and Dark modes
class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.textPrimaryLight,
        centerTitle: true,
        titleTextStyle: AppTypography.titleLarge(
          color: AppColors.textPrimaryLight,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.roundedMd,
          side: BorderSide(color: AppColors.borderLight),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.roundedMd,
          ),
          textStyle: AppTypography.labelLarge(color: Colors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.primary),
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.roundedMd,
          ),
          textStyle: AppTypography.labelLarge(color: AppColors.primary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: const OutlineInputBorder(
          borderRadius: AppSpacing.roundedMd,
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppSpacing.roundedMd,
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppSpacing.roundedMd,
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppSpacing.roundedMd,
          borderSide: BorderSide(color: AppColors.error),
        ),
        hintStyle: AppTypography.bodyMedium(color: AppColors.textTertiaryLight),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.accent,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textPrimaryDark,
        centerTitle: true,
        titleTextStyle: AppTypography.titleLarge(
          color: AppColors.textPrimaryDark,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.roundedMd,
          side: BorderSide(color: AppColors.borderDark),
        ),
      ),
    );
  }
}
