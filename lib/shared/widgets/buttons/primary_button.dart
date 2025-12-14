import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_radius.dart';
import 'package:travely_app/core/theme/app_typography.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 56, // h-14
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: AppColors.primary.withValues(alpha: 0.25),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.roundedXL, // rounded-xl for welcome button
          ),
          padding: EdgeInsets.zero,
        ).copyWith(
          shadowColor:  WidgetStateProperty.all(AppColors.primary.withValues(alpha: 0.25)),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.primaryDark.withValues(alpha: 0.1);
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.primaryDark.withValues(alpha: 0.2);
            }
            return null;
          }),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                text,
                style: AppTypography.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 17, // text-[17px] from welcome screen design
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.015 * 17,
                ),
              ),
      ),
    );
  }
}
