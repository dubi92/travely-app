import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const String fontFamilyPrimary = 'Inter';
  static const String fontFamilySecondary = 'Plus Jakarta Sans';

  static TextTheme get textTheme {
    return TextTheme(
      // Display - Fredoka
      displayLarge: GoogleFonts.fredoka(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.fredoka(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      displaySmall: GoogleFonts.fredoka(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),

      // Headline - Fredoka
      headlineLarge: GoogleFonts.fredoka(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.fredoka(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.fredoka(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),

      // Title - Quicksand (or Fredoka for stronger titles)
      titleLarge: GoogleFonts.quicksand(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      titleMedium: GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      titleSmall: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),

      // Body - Quicksand
      bodyLarge: GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),

      // UI/Buttons - Quicksand
      labelLarge: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        height: 1.2,
        letterSpacing: 0.5,
      ),
      labelMedium: GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      labelSmall: GoogleFonts.quicksand(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }

  // Helper getters for direct usage if needed
  static TextStyle get h1 => textTheme.displayLarge!;
  static TextStyle get h2 => textTheme.displayMedium!;
  static TextStyle get h3 => textTheme.displaySmall!;
  static TextStyle get bodyLg => textTheme.bodyLarge!;
  static TextStyle get bodyMd => textTheme.bodyMedium!;
  static TextStyle get bodySm => textTheme.bodySmall!;
}
