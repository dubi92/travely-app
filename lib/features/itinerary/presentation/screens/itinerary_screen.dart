import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../activities/domain/models/activity_model.dart'; // Needed for type
import '../../../trips/domain/models/trip_model.dart';
import '../providers/activities_provider.dart';
import '../widgets/itinerary_empty_state.dart';
import '../widgets/timeline_view.dart';
import '../widgets/category_picker_sheet.dart';
import 'add_activity_screen.dart';
import 'edit_activity_screen.dart';

class ItineraryScreen extends ConsumerStatefulWidget {
  final Trip trip;

  const ItineraryScreen({super.key, required this.trip});

  @override
  ConsumerState<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends ConsumerState<ItineraryScreen> {
  int _selectedDayIndex = 0;

  int get _dayCount {
    final diff = widget.trip.endDate.difference(widget.trip.startDate).inDays;
    return diff + 1;
  }

  String get _dateRangeString {
    final start = DateFormat('MMM d').format(widget.trip.startDate);
    final end = DateFormat('MMM d').format(widget.trip.endDate);
    return '$start - $end';
  }

  void _handleAddActivity() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CategoryPickerSheet(
        onCategorySelected: (category) {
          Navigator.pop(context); // Close sheet
          _navigateToCreateActivity(category);
        },
      ),
    );
  }

  void _navigateToCreateActivity(ActivityCategory category) {
    final selectedDate =
        widget.trip.startDate.add(Duration(days: _selectedDayIndex));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddActivityScreen(
          tripId: widget.trip.id,
          selectedDate: selectedDate,
          initialCategory: category,
        ),
      ),
    );
  }

  void _handleEditActivity(Activity activity) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditActivityScreen(activity: activity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch derived provider for current day activities
    final activities = ref.watch(activitiesByDayProvider((
      tripId: widget.trip.id,
      dayIndex: _selectedDayIndex,
      startDate: widget.trip.startDate,
    )));

    // Watch main provider for loading state
    final asyncState = ref.watch(tripActivitiesProvider(widget.trip.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          const DecorativeBackground(),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.home_rounded),
                            onPressed: () => Navigator.of(context).pop(),
                            color: AppColors.textPrimaryLight,
                            iconSize: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.trip.name,
                              style: AppTypography.textTheme.headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.playfulTextPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _dateRangeString,
                              style:
                                  AppTypography.textTheme.bodyMedium?.copyWith(
                                color: AppColors.playfulTextSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const FloatingMascot(
                        type: MascotType.balloon,
                        size: 40,
                      ),
                    ],
                  ),
                ),

                // Day Tabs
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DayTabs(
                    dayCount: _dayCount,
                    selectedDayIndex: _selectedDayIndex,
                    onDaySelected: (index) {
                      setState(() => _selectedDayIndex = index);
                    },
                    startDate: widget.trip.startDate,
                  ),
                ),

                // Content
                Expanded(
                  child: asyncState.when(
                    data: (_) {
                      if (activities.isEmpty) {
                        return ItineraryEmptyState(
                          onAddActivity: _handleAddActivity,
                        );
                      }
                      return TimelineView(
                        activities: activities,
                        onActivityTap: _handleEditActivity,
                      );
                    },
                    error: (err, stack) => Center(
                      child: Text('Error: $err'),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating Action Button
          if (activities.isNotEmpty)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: _handleAddActivity,
                shape: const CircleBorder(),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
