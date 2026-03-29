import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1A3A2A);      // أخضر غامق
  static const Color secondary = Color(0xFF2D5A3D);    // أخضر وسط
  static const Color golden = Color(0xFFC9A84C);       // ذهبي
  static const Color background = Color(0xFFF5EDD8);   // كريمي
  static const Color white = Color(0xFFFFFFFF);

  // Additional derived colors
  static const Color surface = Color(0xFFFDF6E8);
  static const Color textPrimary = Color(0xFF1A3A2A);
  static const Color textSecondary = Color(0xFF4A6B5A);
  static const Color divider = Color(0xFFD4C4A0);
}

class AppTheme {
  static ThemeData get lightTheme {
    final tajawal = GoogleFonts.tajawal;
    final amiri = GoogleFonts.amiri;

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        tertiary: AppColors.golden,
        onTertiary: AppColors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: Colors.red,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.tajawalTextTheme().copyWith(
        headlineLarge: amiri(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: amiri(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        bodyLarge: amiri(
          fontSize: 18,
          color: AppColors.textPrimary,
          height: 2.0,
        ),
        bodyMedium: tajawal(
          fontSize: 15,
          color: AppColors.textSecondary,
        ),
        labelLarge: tajawal(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: tajawal(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
