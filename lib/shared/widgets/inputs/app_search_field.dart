import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'app_text_field.dart';

class AppSearchField extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const AppSearchField({
    super.key,
    this.placeholder = 'Search',
    this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppTextField(
      label: '', // No label for search usually
      placeholder: placeholder,
      controller: controller,
      onChanged: onChanged,
      prefixIcon: Icon(
        Icons.search,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      ),
      suffixIcon: onClear != null
          ? IconButton(
              icon: Icon(
                Icons.close,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              onPressed: onClear,
            )
          : null,
    );
  }
}
