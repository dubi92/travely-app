import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_typography.dart';

enum BadgeType {
  success,
  warning,
  error,
  info,
  neutral;

  Color get backgroundColor {
    switch (this) {
      case BadgeType.success: return const Color(0xFFE8F9EE); // Green-100/90
      case BadgeType.warning: return const Color(0xFFFEF3E2); // Amber light
      case BadgeType.error: return const Color(0xFFFEE2E2); // Red-100
      case BadgeType.info: return const Color(0xFFE0F2FE); // Blue-100
      case BadgeType.neutral: return const Color(0xFFF3F4F6); // Gray-100
    }
  }

  Color get backgroundColorDark {
    switch (this) {
      case BadgeType.success: return const Color(0xFF14532D).withValues(alpha: 0.6);
      case BadgeType.warning: return const Color(0xFF713F12).withValues(alpha: 0.6);
      case BadgeType.error: return const Color(0xFF7F1D1D).withValues(alpha: 0.6);
      case BadgeType.info: return const Color(0xFF0C4A6E).withValues(alpha: 0.6);
      case BadgeType.neutral: return const Color(0xFF374151).withValues(alpha: 0.6);
    }
  }

  Color get textColor {
    switch (this) {
      case BadgeType.success: return AppColors.success; // Green-700
      case BadgeType.warning: return Colors.orange[800]!; // Using standard orange for now to match warning
      case BadgeType.error: return AppColors.error;
      case BadgeType.info: return AppColors.info;
      case BadgeType.neutral: return AppColors.textSecondaryLight;
    }
  }

  Color get textColorDark {
     switch (this) {
      case BadgeType.success: return const Color(0xFF86EFAC); // Green-300
      case BadgeType.warning: return const Color(0xFFFDBA74); // Orange-300
      case BadgeType.error: return const Color(0xFFFCA5A5); // Red-300
      case BadgeType.info: return const Color(0xFF7DD3FC); // Sky-300
      case BadgeType.neutral: return const Color(0xFFD1D5DB); // Gray-300
    }
  }
}

class StatusBadge extends StatelessWidget {
  final String text;
  final BadgeType type;

  const StatusBadge({
    super.key,
    required this.text,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? type.backgroundColorDark : type.backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: (isDark ? type.textColorDark : type.textColor).withValues(alpha: 0.2),

        ),
      ),
      child: Text(
        text,
        style: AppTypography.textTheme.labelSmall?.copyWith(
          color: isDark ? type.textColorDark : type.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
