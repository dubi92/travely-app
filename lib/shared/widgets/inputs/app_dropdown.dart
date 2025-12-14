import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_radius.dart';
import 'package:travely_app/core/theme/app_typography.dart';

class AppDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? placeholder;

  const AppDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.placeholder,
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
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.inputBackgroundDark : AppColors.inputBackgroundLight,
            borderRadius: AppRadius.roundedLG, // Using roundedLG (16px) to match inputs
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              hint: placeholder != null
                  ? Text(
                      placeholder!,
                      style: AppTypography.textTheme.bodyLarge?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    )
                  : null,
              style: AppTypography.textTheme.bodyLarge?.copyWith(
                color: isDark ? Colors.white : AppColors.textPrimaryLight,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              isExpanded: true,
              dropdownColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
