import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 8, // subtle shadow
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today), // Itinerary
          label: 'Itinerary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money), // Expenses
          label: 'Expenses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart_outline), // Split
          label: 'Split',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined), // Settings
          label: 'Settings',
        ),
      ],
    );
  }
}
