import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travely_app/features/activities/domain/models/activity_model.dart';
import 'package:travely_app/features/itinerary/presentation/widgets/timeline_view.dart';
import 'package:travely_app/features/itinerary/presentation/widgets/time_indicator.dart';
import 'package:travely_app/features/itinerary/presentation/widgets/activity_card.dart';

void main() {
  final activity1 = Activity(
    id: '1',
    tripId: 'trip1',
    title: 'Activity 1',
    startTime: DateTime(2023, 5, 20, 10, 0),
    endTime: DateTime(2023, 5, 20, 11, 0),
    category: ActivityCategory.sightseeing,
    category: ActivityCategory.sightseeing,
    location: 'Loc 1',
    createdBy: 'user1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final activity2 = Activity(
    id: '2',
    tripId: 'trip1',
    title: 'Activity 2',
    startTime: DateTime(2023, 5, 20, 12, 0),
    endTime: DateTime(2023, 5, 20, 13, 0),
    category: ActivityCategory.food,
    category: ActivityCategory.food,
    location: 'Loc 2',
    createdBy: 'user1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  testWidgets('TimelineView displays all activities',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimelineView(
            activities: [activity1, activity2],
            onActivityTap: (_) {},
          ),
        ),
      ),
    );

    // Verify TimeIndicators
    expect(find.byType(TimeIndicator), findsNWidgets(2));

    // Verify ActivityCards
    expect(find.byType(ActivityCard), findsNWidgets(2));

    // Verify Titles
    expect(find.text('Activity 1'), findsOneWidget);
    expect(find.text('Activity 2'), findsOneWidget);
  });
}
