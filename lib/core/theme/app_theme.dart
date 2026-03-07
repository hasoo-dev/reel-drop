// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:video_downloder/core/theme/app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'lufga',
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.orange,
      
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.orange,
        primaryContainer: AppColors.primarySoft,
        secondaryContainer: AppColors.accentSoft,
        tertiaryContainer: AppColors.purpleGlow,
        shadow: Colors.black,
        secondary: AppColors.accent,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightText,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.lightText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.lightText),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.lightText,
          fontSize: 32,
          fontFamily: 'lufga',
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.lightText,
          fontSize: 16,
          fontFamily: 'lufga',
        ),
        bodyMedium: TextStyle(
          fontFamily: 'lufga',
          color: AppColors.lightSecondaryText,
          fontSize: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'lufga',
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      
      scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 249, 128, 59),
        secondary: AppColors.accent,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText, 
        shadow: Colors.white,
        error: AppColors.error,
        background: AppColors.darkBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.darkText),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.darkText,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.darkSecondaryText, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
