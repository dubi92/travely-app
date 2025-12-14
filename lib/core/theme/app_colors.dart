import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF3182ED);
  static const Color primaryDark = Color(0xFF1A5BB8); // Darker shade for hover/pressed
  static const Color primaryLight = Color(0xFF6BA4F2); // Lighter shade

  // Neutral - Light
  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF111418);
  static const Color textSecondaryLight = Color(0xFF617389);
  static const Color borderLight = Color(0xFFDBE0E6);

  // Neutral - Dark
  static const Color backgroundDark = Color(0xFF101822);
  static const Color surfaceDark = Color(0xFF1A2632); // Also seen #1a2634
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color borderDark = Color(0xFF374151); // Gray-700

  // Semantic
  static const Color error = Color(0xFFEA4335);
  static const Color success = Color(0xFF34A853);
  static const Color warning = Color(0xFFFBBC05);
  static const Color info = Color(0xFF4285F4);

  // Components using specific values
  static const Color inputBackgroundLight = Color(0xFFFFFFFF);
  static const Color inputBackgroundDark = Color(0xFF1A2634);
}
