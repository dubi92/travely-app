import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travely_app/features/activities/domain/models/activity_model.dart';
import 'package:travely_app/features/itinerary/presentation/widgets/activity_card.dart';

void main() {
  final activity = Activity(
    id: '1',
    tripId: 'trip1',
    title: 'Visit Louvre Museum',
    startTime: DateTime(2023, 5, 20, 10, 0),
    endTime: DateTime(2023, 5, 20, 13, 0),
    category: ActivityCategory.sightseeing,
    category: ActivityCategory.sightseeing,
    location: 'Musee du Louvre',
    price: 17.0,
    currency: 'EUR',
    isPaid: true,
    createdBy: 'user1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  testWidgets('ActivityCard displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ActivityCard(activity: activity),
        ),
      ),
    );

    // Verify Title
    expect(find.text('Visit Louvre Museum'), findsOneWidget);

    // Verify Location
    expect(find.text('Musee du Louvre'), findsOneWidget);

    // Verify Category Emoji
    expect(find.text(ActivityCategory.sightseeing.emoji), findsOneWidget);

    // Verify Price (simple text check, formatting might vary space)
    expect(find.text('\$17'),
        findsOneWidget); // Assuming EUR standard format or locale fallback

    // Verify Paid Badge
    expect(find.text('Paid'), findsOneWidget);
  });

  testWidgets('ActivityCard taps work', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ActivityCard(
            activity: activity,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ActivityCard));
    expect(tapped, isTrue);
  });
}
