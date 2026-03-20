import 'package:flutter/material.dart';

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
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
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
      fontFamily: 'Tajawal',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 18,
          color: AppColors.textPrimary,
          height: 2.0,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 15,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
