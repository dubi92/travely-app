import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthStateService {
  final SupabaseService _supabaseService;
  
  AuthStateService(this._supabaseService);

  Stream<AuthState> get authStateChanges => _supabaseService.auth.onAuthStateChange;

  User? get currentUser => _supabaseService.auth.currentUser;

  Session? get currentSession => _supabaseService.auth.currentSession;
  
  bool get isAuthenticated => currentUser != null;

  Future<void> signOut() async {
    await _supabaseService.auth.signOut();
  }
}
