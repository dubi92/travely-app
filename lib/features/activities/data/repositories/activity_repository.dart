import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/supabase_exception.dart';
import '../../domain/models/activity_model.dart';

class ActivityRepository {
  final SupabaseClient _supabase;

  ActivityRepository(this._supabase);

  Future<List<Activity>> getActivitiesByTrip(String tripId) async {
    final response = await _supabase
        .from('activities')
        .select()
        .eq('trip_id', tripId)
        .order('start_time', ascending: true);

    return (response as List).map((e) => Activity.fromJson(e)).toList();
  }

  Future<List<Activity>> getActivitiesByDay(
      String tripId, DateTime date) async {
    // Start of day
    final startOfDay = DateTime(date.year, date.month, date.day);
    // End of day
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final response = await _supabase
        .from('activities')
        .select()
        .eq('trip_id', tripId)
        .gte('start_time', startOfDay.toIso8601String())
        .lte('start_time', endOfDay.toIso8601String())
        .order('start_time', ascending: true);

    return (response as List).map((e) => Activity.fromJson(e)).toList();
  }

  Future<Activity> createActivity(Activity activity) async {
    final activityData = activity.toJson();
    // Remove ID so Supabase generates it, or keep if we pre-generated
    // Usually we let DB generate or use client-side uuid.
    // If model has ID, we use it. If ID is empty string or temporary, we might omit.
    // For now assuming ID is pre-generated or we insert it.

    // Cleaning nulls? Supabase handles nulls if column nullable.

    final response = await _supabase
        .from('activities')
        .insert(activityData)
        .select()
        .single();

    return Activity.fromJson(response);
  }

  Future<Activity> updateActivity(Activity activity) async {
    final response = await _supabase
        .from('activities')
        .update(activity.toJson())
        .eq('id', activity.id)
        .select()
        .single();

    return Activity.fromJson(response);
  }

  Future<void> deleteActivity(String activityId) async {
    await _supabase.from('activities').delete().eq('id', activityId);
  }

  Future<String> uploadActivityImage(String activityId, String filePath) async {
    try {
      final file = File(filePath);
      final fileExt = filePath.split('.').last;
      final fileName =
          '$activityId/${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      await _supabase.storage.from('activity_images').upload(fileName, file);

      final publicUrl =
          _supabase.storage.from('activity_images').getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      throw SupabaseException('Failed to upload activity image: $e');
    }
  }
}
