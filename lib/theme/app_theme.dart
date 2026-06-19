import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark theme
  static const darkBg = Color(0xFF0C0C0A);
  static const darkBg2 = Color(0xFF131311);
  static const darkBg3 = Color(0xFF1A1A17);
  static const darkInk = Color(0xFFF2F0E8);
  static const darkInk2 = Color(0xFF9B9A93);
  static const darkInk3 = Color(0xFF5C5B55);
  static const darkLine = Color(0x14F2F0E8);
  static const darkLine2 = Color(0x2EF2F0E8);

  // Light theme
  static const lightBg = Color(0xFFF5F4EE);
  static const lightBg2 = Color(0xFFFFFFFF);
  static const lightBg3 = Color(0xFFEFEFEA);
  static const lightInk = Color(0xFF0C0C0A);
  static const lightInk2 = Color(0xFF2A2A25);
  static const lightInk3 = Color(0xFF4A4A44);
  static const lightLine = Color(0x140C0C0A);
  static const lightLine2 = Color(0x2E0C0C0A);

  // Shared accent
  static const accent = Color(0xFFC8FF57);
  static const accentDark = Color(0xFFA8E63C);
  static const accentInk = Color(0xFF0C1A00);
  static const violet = Color(0xFF8B5CF6);
  static const coral = Color(0xFFFF6B4A);
  static const teal = Color(0xFF2DD4BF);
}

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        surface: AppColors.darkBg2,
        onSurface: AppColors.darkInk,
      ),
      textTheme: _textTheme(AppColors.darkInk),
      dividerColor: AppColors.darkLine,
    );
  }

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        surface: AppColors.lightBg2,
        onSurface: AppColors.lightInk,
      ),
      textTheme: _textTheme(AppColors.lightInk),
      dividerColor: AppColors.lightLine,
    );
  }

  static TextTheme _textTheme(Color base) {
    return TextTheme(
      displayLarge: GoogleFonts.fraunces(
        fontSize: 60, fontWeight: FontWeight.w400,
        color: base, letterSpacing: -1.2,
      ),
      displayMedium: GoogleFonts.fraunces(
        fontSize: 44, fontWeight: FontWeight.w400,
        color: base, letterSpacing: -0.8,
      ),
      displaySmall: GoogleFonts.fraunces(
        fontSize: 32, fontWeight: FontWeight.w400,
        color: base, letterSpacing: -0.5,
      ),
      headlineLarge: GoogleFonts.fraunces(
        fontSize: 28, fontWeight: FontWeight.w400,
        color: base,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w600,
        color: base,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w400,
        color: base, height: 1.75,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400,
        color: base,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w400,
        color: base,
      ),
      labelSmall: GoogleFonts.jetBrainsMono(
        fontSize: 11, fontWeight: FontWeight.w400,
        color: base, letterSpacing: 0.5,
      ),
    );
  }
}
