import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';

class BackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: isDark ? Colors.white : AppColors.textPrimaryLight,
      ),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
    );
  }
}
