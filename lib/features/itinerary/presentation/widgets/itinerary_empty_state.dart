import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';

class ItineraryEmptyState extends StatelessWidget {
  final VoidCallback onAddActivity;

  const ItineraryEmptyState({super.key, required this.onAddActivity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FloatingMascot(
            type: MascotType.standard,
            size: 60,
          ),
          const SizedBox(height: 20),
          Text(
            'No activities yet!',
            style: AppTypography.textTheme.titleLarge?.copyWith(
              color: AppColors.playfulTextPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start planning your adventure\nby adding some fun activities.',
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.playfulTextSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            text: 'Add your first activity',
            onPressed: onAddActivity,
            width: 220,
          ),
        ],
      ),
    );
  }
}
