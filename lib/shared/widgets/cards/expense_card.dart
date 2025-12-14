import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_typography.dart';
import 'package:travely_app/shared/widgets/cards/app_card.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final String amount;
  final String payer;
  final String date;
  final VoidCallback? onTap;

  const ExpenseCard({
    super.key,
    required this.title,
    required this.amount,
    required this.payer,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.receipt_long, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
                Text(
                  '$payer paid • $date',
                  style: AppTypography.textTheme.bodySmall?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppTypography.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
