import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';
import 'auth_state_service.dart';

final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return SupabaseService.client;
});

final authStateServiceProvider = Provider<AuthStateService>((ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return AuthStateService(supabaseService);
});

final authStateProvider = StreamProvider<AuthState>((ref) {
  final authService = ref.watch(authStateServiceProvider);
  return authService.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  // We can also listen to authStateChanges and map to user to be reactive
  final authState = ref.watch(authStateProvider).asData?.value;
  return authState?.session?.user ?? ref.watch(authStateServiceProvider).currentUser;
});
