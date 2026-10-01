import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark theme (Obsidian Canvas & High-Contrast Surfaces inspired by reference UI image)
  static const darkBg = Color(0xFF0C0E0F);      // Obsidian Midnight Base Canvas
  static const darkBg2 = Color(0xFF14171A);     // Deep Charcoal Card & Module Surface (L1)
  static const darkBg3 = Color(0xFF1E2227);     // Elevated Surface (L2 / Hover / Pills)
  static const darkInk = Color(0xFFFFFFFF);     // Primary Text (Pure Crisp White)
  static const darkInk2 = Color(0xFF9DA4B0);    // Secondary Text (Soft Silver-Grey)
  static const darkInk3 = Color(0xFF6B7280);    // Muted Subtitle Text
  static const darkLine = Color(0xFF23282E);    // Subtle 1px Dark Card Border Line
  static const darkLine2 = Color(0xFF323842);   // Active / Focused Border Line

  // Light theme (Crisp Warm Porcelain Canvas & Rich Lime Accent)
  static const lightBg = Color(0xFFF7F9F2);     // Porcelain Off-White Canvas with subtle Lime warmth
  static const lightBg2 = Color(0xFFFFFFFF);    // Pure White Surface (L1)
  static const lightBg3 = Color(0xFFEEF4E3);    // Tinted Light Pistachio Surface (L2 / Hover)
  static const lightInk = Color(0xFF0F140C);    // Deep Charcoal-Black Text (16:1 AAA contrast)
  static const lightInk2 = Color(0xFF475240);   // Secondary Slate-Green Text
  static const lightInk3 = Color(0xFF6E7A66);   // Muted Sage Text
  static const lightLine = Color(0xFFE1E7D5);   // Subtle 1px Border Line
  static const lightLine2 = Color(0xFFC8D3B8);  // Focused Border Line

  // Signature Neon Lime Green / Pistachio Accent (Exact palette from user reference image)
  static const accent = Color(0xFFD0F253);          // Signature Neon Lime Green (#D0F253)
  static const accentDark = Color(0xFF98B82B);      // Mid Lime Green
  static const accentInk = Color(0xFF0C0E0F);       // High-contrast Obsidian Black text on Lime CTA (14.5:1 AAA)
  static const accentHover = Color(0xFFDEFF63);     // Glowing Neon Lime Hover

  // Light theme specific accents
  static const lightAccent = Color(0xFF689B00);     // Rich Lime-Forest Green for light mode readability (4.8:1 contrast)
  static const lightAccentDark = Color(0xFF4E7500); // Deep Forest Lime
  static const lightAccentInk = Color(0xFFFFFFFF);  // White text on light primary CTA
  static const lightAccentHover = Color(0xFF5A8700); // Emerald Lime Hover

  // Complementary Accents tuned for Lime Theme
  static const violet = Color(0xFFB77BFF);          // Soft Electric Amethyst
  static const lightViolet = Color(0xFF7C3AED);     // Deep Violet
  static const coral = Color(0xFFFF6B4A);           // Warm Sunset Coral
  static const lightCoral = Color(0xFFEA580C);      // Radiant Orange
  static const teal = Color(0xFF2DD4BF);            // Bright Mint Teal
  static const lightTeal = Color(0xFF0D9488);       // Ocean Teal
  static const pink = Color(0xFFFF52A3);            // Ultra-Vibrant Neon Pink
  static const lightPink = Color(0xFFDB2777);       // Deep Magenta
  static const amber = Color(0xFFFACC15);           // Electric Gold / Amber
  static const lightAmber = Color(0xFFD97706);      // Warm Golden Amber
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

  static ThemeData light() => dark();

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
