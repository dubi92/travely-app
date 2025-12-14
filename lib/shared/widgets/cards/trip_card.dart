import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'package:travely_app/core/theme/app_typography.dart';
import 'package:travely_app/shared/widgets/cards/app_card.dart';
import 'package:travely_app/shared/widgets/badges/status_badge.dart';

class TripCard extends StatelessWidget {
  final String title; // "Kyoto Spring"
  final String dateRange; // "Apr 12 - Apr 20"
  final String? imageUrl;
  final String status; // "Planning"
  final Widget? members; // AvatarStack
  final VoidCallback? onTap;

  const TripCard({
    super.key,
    required this.title,
    required this.dateRange,
    this.imageUrl,
    required this.status,
    this.members,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          SizedBox(
            height: 192, // h-48
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (imageUrl != null)
                  Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
                  )
                else
                  Container(color: Colors.grey[300]),
                
                // Status Badge
                Positioned(
                  top: 16,
                  right: 16,
                  child: StatusBadge(
                    text: status,
                    type: _getTypeForStatus(status),
                  ),
                ),
              ],
            ),
          ),
          
          // Content Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTypography.textTheme.headlineSmall?.copyWith( // using headlineSmall ~ 24 or titleLarge ~ 22 -> design says xl (20px) bold
                              // Theme: displaySmall=20 bold.
                              fontSize: 20, 
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dateRange,
                            style: AppTypography.textTheme.bodyMedium?.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12), // pt-1 ~ 4px but gaps usually larger
                if (members != null) members!,
              ],
            ),
          ),
        ],
      ),
    );
  }

  BadgeType _getTypeForStatus(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed': return BadgeType.success;
      case 'planning': return BadgeType.warning;
      case 'completed': return BadgeType.neutral;
      default: return BadgeType.info;
    }
  }
}
