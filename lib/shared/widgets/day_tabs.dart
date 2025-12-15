import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'package:intl/intl.dart';

class DayTabs extends StatelessWidget {
  final int dayCount;
  final int selectedDayIndex;
  final ValueChanged<int> onDaySelected;
  final DateTime? startDate;

  const DayTabs({
    super.key,
    required this.dayCount,
    required this.selectedDayIndex,
    required this.onDaySelected,
    this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(dayCount, (index) {
          final isSelected = index == selectedDayIndex;
          final dayNum = index + 1;

          String dateLabel = '';
          if (startDate != null) {
            final date = startDate!.add(Duration(days: index));
            dateLabel = DateFormat('EEE d').format(date);
          }

          return GestureDetector(
            onTap: () => onDaySelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.9)
                    : Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Day $dayNum',
                    style: AppTypography.textTheme.titleMedium?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppColors.playfulTextSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isSelected && dateLabel.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text(
                      dateLabel,
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
