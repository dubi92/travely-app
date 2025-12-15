import 'package:flutter/material.dart';
import '../../../activities/domain/models/activity_model.dart';
import 'activity_card.dart';
import 'time_indicator.dart';

class TimelineView extends StatelessWidget {
  final List<Activity> activities;
  final Function(Activity) onActivityTap;

  const TimelineView({
    super.key,
    required this.activities,
    required this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const SizedBox(); // Handled by empty state in parent or provider
    }

    return Stack(
      children: [
        // 2.2 Gradient connector line
        Positioned(
          top: 0,
          bottom: 0,
          left:
              54, // Centered under time indicator icon (70/2 + padding/alignment)
          // Actually icon is centered in 70 width column. Icon is 48 width. Center is 35.
          // Let's align with the center of the time indicator column width which is 70. Center is 35.
          // But wait, the design says line is at left: 54px.
          // Let's replicate design: left: 54px.
          child: Container(
            width: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x4D9FD8E5), // rgba(159, 216, 229, 0.3)
                  Color(0x4DA8E6CF), // rgba(168, 230, 207, 0.3)
                  Color(0x4D9FD8E5),
                ],
              ),
            ),
          ),
        ),

        ListView.builder(
          padding: const EdgeInsets.fromLTRB(
              20, 10, 20, 100), // Bottom padding for FAB
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2.3 Time Indicator
                  TimeIndicator(
                    time: activity.startTime,
                    // We could map category emoji over time icon if desired, or skip
                  ),
                  const SizedBox(width: 16),
                  // 2.4 Activity Card
                  Expanded(
                    child: ActivityCard(
                      activity: activity,
                      onTap: () => onActivityTap(activity),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
