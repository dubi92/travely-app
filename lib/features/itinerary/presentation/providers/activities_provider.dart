import 'package:flutter/material.dart'; // For DateUtils
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../activities/data/repositories/activity_repository.dart';
import '../../../activities/domain/models/activity_model.dart';

// Provider for the repository
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepository(Supabase.instance.client);
});

// Provider for activities of a specific trip
final tripActivitiesProvider = AsyncNotifierProvider.family<
    TripActivitiesNotifier, List<Activity>, String>(() {
  return TripActivitiesNotifier();
});

class TripActivitiesNotifier
    extends FamilyAsyncNotifier<List<Activity>, String> {
  late ActivityRepository _repository;
  late String _tripId;

  @override
  Future<List<Activity>> build(String arg) async {
    _tripId = arg;
    _repository = ref.read(activityRepositoryProvider);
    return _fetchActivities();
  }

  Future<List<Activity>> _fetchActivities() async {
    return _repository.getActivitiesByTrip(_tripId);
  }

  // Method to refresh data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchActivities());
  }

  Future<void> createActivity(Activity activity) async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() => _repository.createActivity(activity));
    ref.invalidateSelf();
  }

  Future<void> updateActivity(Activity activity) async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() => _repository.updateActivity(activity));
    ref.invalidateSelf();
  }

  Future<void> deleteActivity(String activityId) async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() => _repository.deleteActivity(activityId));
    ref.invalidateSelf();
  }
}

// Derived provider for filtered activities by day
final activitiesByDayProvider = Provider.family<List<Activity>,
    ({String tripId, int dayIndex, DateTime startDate})>((ref, params) {
  final activitiesAsync = ref.watch(tripActivitiesProvider(params.tripId));

  return activitiesAsync.maybeWhen(
    data: (activities) {
      // Calculate start and end of the goal day
      final targetDate = params.startDate.add(Duration(days: params.dayIndex));

      return activities.where((activity) {
        return DateUtils.isSameDay(activity.startTime, targetDate);
      }).toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
    },
    orElse: () => [],
  );
});
