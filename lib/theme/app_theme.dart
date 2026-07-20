import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark theme (Deep Navy & Electric Sky)
  static const darkBg = Color(0xFF0B132B);      // Deepest Midnight Navy
  static const darkBg2 = Color(0xFF1C2541);     // Rich Navy Slate
  static const darkBg3 = Color(0xFF263252);     // Soft Navy Slate
  static const darkInk = Color(0xFFF4F6FC);     // Primary Text (14.8:1 contrast)
  static const darkInk2 = Color(0xFFA0AEC0);    // Secondary Text (6.2:1 contrast)
  static const darkInk3 = Color(0xFF64748B);    // Muted Text (4.6:1 contrast)
  static const darkLine = Color(0x1AFFFFFF);    // 10% White Line
  static const darkLine2 = Color(0x33FFFFFF);   // 20% White Line

  // Light theme (Cool Slate Off-White & Deep Ocean Blue)
  static const lightBg = Color(0xFFF8FAFC);     // Cool Slate Off-White
  static const lightBg2 = Color(0xFFFFFFFF);    // Pure White surface
  static const lightBg3 = Color(0xFFEDF2F7);    // Soft Blue-Gray
  static const lightInk = Color(0xFF0F172A);    // Deep Slate Black/Navy (17.5:1 contrast)
  static const lightInk2 = Color(0xFF334155);   // Secondary Slate Text (9.8:1 contrast)
  static const lightInk3 = Color(0xFF64748B);   // Muted Slate Text (4.8:1 contrast)
  static const lightLine = Color(0x1A0F172A);   // 10% Dark Slate Line
  static const lightLine2 = Color(0x330F172A);  // 20% Dark Slate Line

  // Light theme specific accents
  static const lightAccent = Color(0xFF0284C7);     // Rich Deep Sky Ocean Blue (4.6:1 contrast)
  static const lightAccentDark = Color(0xFF0369A1); // Deepest Sky Blue
  static const lightAccentInk = Color(0xFFFFFFFF);  // White text on primary CTA
  static const lightAccentHover = Color(0xFF0C4A6E); // Darker Sky Hover
  static const lightViolet = Color(0xFF4F46E5);     // Deep Indigo Violet
  static const lightCoral = Color(0xFFEA580C);      // Deeper Coral/Orange
  static const lightTeal = Color(0xFF0D9488);       // Deep Ocean Teal

  // Shared accent (dark theme defaults)
  static const accent = Color(0xFF38BDF8);          // Electric Sky Cyan
  static const accentDark = Color(0xFF0284C7);      // Deeper Sky Blue
  static const accentInk = Color(0xFF07101E);       // Dark Navy text on accent CTA (12.1:1 contrast)
  static const accentHover = Color(0xFF7DD3FC);     // Glow Cyan Hover
  static const violet = Color(0xFF818CF8);          // Indigo Violet
  static const coral = Color(0xFFFB923C);           // Warm Coral
  static const teal = Color(0xFF2DD4BF);            // Bright Teal
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
        primary: AppColors.lightAccent,
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
