import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/env.dart';
import '../../core/errors/supabase_exception.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  
  factory SupabaseService() => _instance;
  
  SupabaseService._internal();

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> init() async {
    try {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        anonKey: Env.supabaseAnonKey,
      );
    } catch (e) {
      throw SupabaseException('Failed to initialize Supabase: $e');
    }
  }

  // Getters for common clients
  GoTrueClient get auth => client.auth;
  SupabaseStorageClient get storage => client.storage;
  // Database access is via client.from('table') usually, but we can expose client if needed
  // PostgrestClient is client.rest (usually accessed via shortcuts)
}
