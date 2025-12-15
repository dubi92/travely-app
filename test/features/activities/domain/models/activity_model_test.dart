import 'package:flutter_test/flutter_test.dart';
import 'package:travely_app/features/activities/domain/models/activity_model.dart';

void main() {
  group('Activity Category', () {
    test('Emoji mapping is correct', () {
      expect(ActivityCategory.food.emoji, '🍽️');
      expect(ActivityCategory.sightseeing.emoji, '📸');
      expect(ActivityCategory.other.emoji, '📍');
    });

    test('Label mapping is correct', () {
      expect(ActivityCategory.food.label, 'Food');
      expect(ActivityCategory.accommodation.label, 'Stay');
    });
  });

  group('Activity Model', () {
    final testDate = DateTime(2023, 10, 15, 12, 0);
    final activity = Activity(
      id: '1',
      tripId: 'trip-1',
      title: 'Lunch',
      category: ActivityCategory.food,
      startTime: testDate,
      endTime: testDate.add(const Duration(hours: 1)),
      createdBy: 'user-1',
      createdAt: testDate,
      updatedAt: testDate,
    );

    test('Computed duration is correct', () {
      expect(activity.duration, const Duration(hours: 1));
    });

    test('Serialization works correctly', () {
      final json = activity.toJson();
      expect(json['id'], '1');
      expect(json['category'], 'food');

      final fromJson = Activity.fromJson(json);
      expect(fromJson.id, activity.id);
      expect(fromJson.startTime, activity.startTime);
      expect(fromJson.category, activity.category);
    });

    test('CopyWith works correctly', () {
      final updated = activity.copyWith(title: 'Dinner');
      expect(updated.title, 'Dinner');
      expect(updated.id, activity.id); // Should be same
    });
  });
}
