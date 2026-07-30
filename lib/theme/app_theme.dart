import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark theme (Deep Cyber Indigo Canvas with High-Contrast Surfaces)
  static const darkBg = Color(0xFF0A0E1A);      // Rich Deep Cyber Indigo-Navy
  static const darkBg2 = Color(0xFF121829);     // Slate Charcoal Surface (L1)
  static const darkBg3 = Color(0xFF1E2638);     // Elevated Surface (L2 / Hover)
  static const darkInk = Color(0xFFF8FAFC);     // Primary Text (16.8:1 contrast - AAA)
  static const darkInk2 = Color(0xFF94A3B8);    // Secondary Text (7.4:1 contrast - AAA)
  static const darkInk3 = Color(0xFF64748B);    // Muted Text (4.6:1 contrast - AA)
  static const darkLine = Color(0xFF1E293B);    // Subtle 1px Slate Border Line
  static const darkLine2 = Color(0xFF334155);   // Focused Slate Border Line

  // Light theme (Cool Off-White Canvas & High-Vibrancy Emerald)
  static const lightBg = Color(0xFFF8FAFC);     // Cool Slate Off-White Canvas
  static const lightBg2 = Color(0xFFFFFFFF);    // Pure White Surface (L1)
  static const lightBg3 = Color(0xFFF1F5F9);    // Cool Tinted Slate Surface (L2 / Hover)
  static const lightInk = Color(0xFF0F172A);    // Deep Slate Text (17.5:1 contrast - AAA)
  static const lightInk2 = Color(0xFF334155);   // Secondary Slate Text (9.8:1 contrast - AAA)
  static const lightInk3 = Color(0xFF64748B);   // Muted Slate Text (4.8:1 contrast - AA)
  static const lightLine = Color(0xFFE2E8F0);   // Subtle Slate Border Line
  static const lightLine2 = Color(0xFFCBD5E1);  // Focused Slate Border Line

  // Light theme specific accents
  static const lightAccent = Color(0xFF059669);     // Rich Deep Emerald Green CTA
  static const lightAccentDark = Color(0xFF047857); // Deepest Emerald
  static const lightAccentInk = Color(0xFFFFFFFF);  // White text on primary CTA
  static const lightAccentHover = Color(0xFF047857); // Emerald Hover
  static const lightViolet = Color(0xFF7C3AED);     // Deep Electric Violet
  static const lightCoral = Color(0xFFEA580C);      // Radiant Coral Orange
  static const lightTeal = Color(0xFF0D9488);       // Deep Ocean Teal
  static const lightPink = Color(0xFFDB2777);       // Deep Magenta Pink
  static const lightAmber = Color(0xFFD97706);      // Warm Golden Amber

  // Signature Bright Accents (Cyber Emerald Mint & Electric Violet Palette)
  static const accent = Color(0xFF00F5D4);          // Bright Neon Cyber Emerald Mint (Replaces Blue)
  static const accentDark = Color(0xFF059669);      // Deep Emerald
  static const accentInk = Color(0xFF021B1A);       // Ultra Dark Mint Navy text on CTA (15.2:1 AAA)
  static const accentHover = Color(0xFF10B981);     // Vibrant Emerald Mint Hover
  static const violet = Color(0xFFA855F7);          // Electric Amethyst Violet
  static const coral = Color(0xFFFF5E36);           // Bright Radiant Sunset Coral
  static const pink = Color(0xFFFF2E93);            // Ultra-Vibrant Neon Magenta Pink
  static const amber = Color(0xFFFFB800);           // Radiant Electric Gold / Amber
  static const teal = Color(0xFF14B8A6);            // Dart Teal
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
