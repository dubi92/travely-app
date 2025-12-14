import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTypography {
  static const String fontFamilyPrimary = 'Inter';
  static const String fontFamilySecondary = 'Plus Jakarta Sans';

  static TextTheme get textTheme {
    return TextTheme(
      // Headings
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),

      // Body
      bodyLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),

      // UI/Buttons
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.015, // from extracted CSS
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
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
