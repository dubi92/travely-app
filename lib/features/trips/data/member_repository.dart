import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/models/trip_member_model.dart';
import '../../../../shared/services/supabase_service.dart';
import '../../../../core/errors/supabase_exception.dart';

class MemberRepository {
  final SupabaseClient _supabase;

  MemberRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? SupabaseService.client;

  Future<void> addMember(String tripId, String userId, {String role = 'member'}) async {
    try {
      await _supabase.from('trip_members').insert({
        'trip_id': tripId,
        'user_id': userId,
        'role': role,
      });
    } catch (e) {
      throw SupabaseException('Failed to add member: $e');
    }
  }

  Future<void> removeMember(String tripId, String userId) async {
    try {
      await _supabase.from('trip_members').delete().match({
        'trip_id': tripId,
        'user_id': userId,
      });
    } catch (e) {
      throw SupabaseException('Failed to remove member: $e');
    }
  }

  Future<List<TripMember>> getTripMembers(String tripId) async {
    try {
      // Join with profiles to get name and avatar
      final data = await _supabase
          .from('trip_members')
          .select('*, profiles:user_id(full_name, avatar_url)')
          .eq('trip_id', tripId);
      
      return (data as List).map((e) => TripMember.fromJson(e)).toList();
    } catch (e) {
      throw SupabaseException('Failed to fetch members: $e');
    }
  }
}
