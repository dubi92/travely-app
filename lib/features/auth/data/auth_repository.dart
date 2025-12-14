import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/supabase_exception.dart';
import '../../../../shared/services/supabase_service.dart';

class AuthRepository {
  final SupabaseClient _supabase;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    SupabaseClient? supabase,
    GoogleSignIn? googleSignIn,
  })  : _supabase = supabase ?? SupabaseService.client,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<AuthResponse> signInWithGoogle() async {
    try {
      // 1. Trigger Google Sign In flow
      // NOTE: serverClientId is required for Web, but we'll focus on mobile flow first.
      // If web is needed, we need to configure it in GoogleSignIn constructor.
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw const SupabaseException('Google Sign In cancelled by user');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw const SupabaseException('No Access Token found.');
      }
      if (idToken == null) {
        throw const SupabaseException('No ID Token found.');
      }

      // 2. Authenticate with Supabase
      return await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      if (e is SupabaseException) rethrow;
      throw SupabaseException('Google Sign In failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _supabase.auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw SupabaseException('Sign out failed: $e');
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
  
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}
