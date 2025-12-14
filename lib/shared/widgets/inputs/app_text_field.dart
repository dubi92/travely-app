import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_radius.dart';
import 'package:travely_app/core/theme/app_typography.dart';


class AppTextField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const AppTextField({
    super.key,
    required this.label,
    this.placeholder,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
            child: Text(
              label,
              style: AppTypography.textTheme.labelMedium?.copyWith(
                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        SizedBox(
          height: 56, // h-14
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            style: AppTypography.textTheme.bodyLarge?.copyWith(
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: AppTypography.textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              filled: true,
              fillColor: isDark ? AppColors.inputBackgroundDark : AppColors.inputBackgroundLight,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16), // Centered vertically in h-14
              border: const OutlineInputBorder(
                borderRadius: AppRadius.roundedLG, // rounded-2xl in design (16px ~ lg in our theme?)
                // Design uses rounded-2xl which is usually larger than lg. 
                // Let's use roundedXL (24) or just use custom BorderRadius.circular(16) to match design "rounded-2xl" 
                // Tailwind 2xl is 1rem (16px) in some configs or 1.5rem (24px).
                // Our config: lg=16. Design generic Tailwind rounded-2xl is usually 16px or 24px.
                // Looking at design tokens earlier: "2xl": "2rem" (32px)?
                // Wait, design says: rounded-2xl
                // Let's look at app_radius.dart.
                // We have lg=16, xl=24, xxl=32.
                // Code.html for login input says "rounded-2xl"
                // Let's check visual appearance in next iteration if needed, but sticking to theme.
                // I will use BorderRadius.circular(16) which is our AppRadius.lg
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Matching "rounded-2xl" visual approx
                borderSide: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2, // focus:ring-2
                ),
              ),
              errorText: errorText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
