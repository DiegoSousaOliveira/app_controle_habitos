import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color accentColor = Color(0xFF10B981);
  static const Color dangerColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFFB923C);

  // Cores neutras
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color backgroundColor = Color(0xFFF9FAFB);
  static const Color surfaceColor = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _titleTextStyle,
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dangerColor),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(0),
      ),
      textTheme: TextTheme(
        displayLarge: _titleTextStyle.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: _titleTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
        displaySmall: _titleTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        headlineLarge: _titleTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
        headlineMedium: _titleTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        headlineSmall: _titleTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        titleLarge: _titleTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: _titleTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
        titleSmall: _titleTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
        bodyLarge: const TextStyle(color: textPrimary, fontSize: 16),
        bodyMedium: const TextStyle(color: textPrimary, fontSize: 14),
        bodySmall: const TextStyle(color: textSecondary, fontSize: 12),
        labelLarge: const TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF111827),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1F2937),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _titleTextStyle.copyWith(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1F2937),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static const TextStyle _titleTextStyle = TextStyle(
    color: textPrimary,
  );
}
