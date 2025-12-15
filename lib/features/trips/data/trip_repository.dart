import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io' as java_io;
import 'dart:developer' as dev;
import '../domain/models/trip_model.dart';
import '../../../../shared/services/supabase_service.dart';
import '../../../../core/errors/supabase_exception.dart';

class TripRepository {
  final SupabaseClient _supabase;

  TripRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? SupabaseService.client;

  Future<Trip> createTrip(Trip trip) async {
    try {
      final tripData = trip.toJson();
      // Remove id so DB generates it
      tripData.remove('id');

      final data =
          await _supabase.from('trips').insert(tripData).select().single();
      return Trip.fromJson(data);
    } catch (e) {
      throw SupabaseException('Failed to create trip: $e');
    }
  }

  Future<String> uploadTripCover(String tripId, String filePath) async {
    try {
      final file = java_io.File(filePath);
      final fileExt = filePath.split('.').last;
      final fileName =
          '$tripId/cover_$tripId.${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      await _supabase.storage.from('trips').upload(fileName, file);

      final publicUrl = _supabase.storage.from('trips').getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      throw SupabaseException('Failed to upload trip cover: $e');
    }
  }

  Future<Trip> getTrip(String tripId) async {
    try {
      final data =
          await _supabase.from('trips').select().eq('id', tripId).single();
      return Trip.fromJson(data);
    } catch (e) {
      throw SupabaseException('Failed to fetch trip: $e');
    }
  }

  Future<List<Trip>> getUserTrips(String userId) async {
    try {
      // 1. Get IDs of trips where user is a member
      final memberRows = await _supabase
          .from('trip_members')
          .select('trip_id')
          .eq('user_id', userId);

      final tripIds =
          (memberRows as List).map((e) => e['trip_id'] as String).toList();

      if (tripIds.isEmpty) return [];

      // 2. Fetch trips and all their members
      final data = await _supabase
          .from('trips')
          .select(
              '*, trip_members(id, trip_id, user_id, role, joined_at, profiles(full_name, avatar_url))')
          .inFilter('id', tripIds)
          .order('start_date', ascending: true);

      // DEBUG LOG
      dev.log('getUserTrips raw data: $data', name: 'travely.repo');

      return (data as List).map((e) => Trip.fromJson(e)).toList();
    } catch (e) {
      dev.log('getUserTrips error: $e', name: 'travely.repo', error: e);
      throw SupabaseException('Failed to fetch user trips: $e');
    }
  }

  Future<void> updateTrip(Trip trip) async {
    try {
      final data = trip.toJson();
      data.remove('created_by'); // Don't allow changing owner
      data.remove('id'); // ID is used in query, not update payload usually

      await _supabase.from('trips').update(data).eq('id', trip.id);
    } catch (e) {
      throw SupabaseException('Failed to update trip: $e');
    }
  }

  Future<void> deleteTrip(String tripId) async {
    try {
      await _supabase.from('trips').delete().eq('id', tripId);
    } catch (e) {
      throw SupabaseException('Failed to delete trip: $e');
    }
  }
}
