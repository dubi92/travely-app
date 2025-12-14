import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_typography.dart';
import 'package:travely_app/shared/widgets/cards/app_card.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String? time;
  final String location;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    required this.title,
    this.time,
    required this.location,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null 
                  ? Image.network(imageUrl!, fit: BoxFit.cover)
                  : Container(color: Colors.grey[300]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (time != null)
                  Text(
                    time!,
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTypography.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                 Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined, 
                      size: 16, 
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
