import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_radius.dart';
import 'package:travely_app/core/theme/app_typography.dart';


enum SocialType { google, apple }

extension SocialTypeExtension on SocialType {
  String get label {
    switch (this) {
      case SocialType.google:
        return 'Continue with Google';
      case SocialType.apple:
        return 'Continue with Apple';
    }
  }

  String get iconPath {
    switch (this) {
      case SocialType.google:
        return 'assets/icons/google.svg'; // Need to ensure assets exist or use icon data
      case SocialType.apple:
        return 'assets/icons/apple.svg';
    }
  }
}

class SocialButton extends StatelessWidget {
  final SocialType type;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.type,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Specific styles for each button type based on designs
    final backgroundColor = type == SocialType.google
        ? (isDark ? AppColors.surfaceDark : Colors.white)
        : (isDark ? Colors.white : Colors.black);
    
    final foregroundColor = type == SocialType.google
        ? (isDark ? Colors.white : AppColors.textPrimaryLight)
        : (isDark ? Colors.black : Colors.white);

    final borderColor = type == SocialType.google
        ? (isDark ? AppColors.borderDark : AppColors.borderLight)
        : Colors.transparent;

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.roundedFull, // rounded-full
          ),
          side: BorderSide(color: borderColor),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using Icon as placeholder if SVG asset not ready, or SVG if user provides
            // Since we haven't added assets yet, I'll use a placeholder builder pattern essentially
            // For now, implementing with Icons or simple Text as fallback
             _buildIcon(context),
            const SizedBox(width: 12),
            Text(
              type.label,
              style: AppTypography.textTheme.labelLarge?.copyWith(
                color: foregroundColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    // Temporary fallback icons until SVG assets are properly set up in a later step
    // The design uses SVGs, but we don't have the assets on disk yet in this step 
    // unless previously added.
    if (type == SocialType.apple) {
       return Icon(Icons.apple, size: 24, color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white);
    }
    // Google Icon fallback
    return const Icon(Icons.g_mobiledata, size: 28); 
  }
}
