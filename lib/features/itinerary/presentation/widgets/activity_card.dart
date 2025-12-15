import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../activities/domain/models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    required this.activity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphismCard(
      variant: GlassCardVariant.light,
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Category Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    activity.category.emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Activity Title
          Text(
            activity.title,
            style: AppTypography.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.playfulTextPrimary,
            ),
          ),

          if (activity.location != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  size: 16,
                  color: AppColors.playfulTextSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    activity.location!,
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.playfulTextSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],

          // Optional Image
          if (activity.imageUrl != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  activity.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.white.withValues(alpha: 0.4),
                    child: const Center(
                      child: Icon(Icons.image_not_supported_outlined,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Footer: Participants & Price
          Row(
            children: [
              const Expanded(child: SizedBox()), // Placeholder for participants
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (activity.price != null)
                    Text(
                      NumberFormat.currency(
                        symbol: activity.currency ?? '\$',
                        decimalDigits: 0,
                      ).format(activity.price),
                      style: AppTypography.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.playfulTextPrimary,
                      ),
                    ),
                  if (activity.isPaid)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.statusDone.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Paid',
                          style: AppTypography.textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF2D7A5A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
