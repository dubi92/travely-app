import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class TimeIndicator extends StatelessWidget {
  final DateTime time;
  final String? icon; // Optional emoji override

  const TimeIndicator({
    super.key,
    required this.time,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Text(
            DateFormat('hh:mm').format(time),
            style: AppTypography.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.playfulTextPrimary,
            ),
          ),
          Text(
            DateFormat('a').format(time),
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: AppColors.playfulTextSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.9),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                icon ?? '📍',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
