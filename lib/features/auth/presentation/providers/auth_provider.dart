import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StreamProvider<AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  // Reactive to stream changes
  final authState = ref.watch(authStateProvider).asData?.value;
  return authState?.session?.user ?? ref.watch(authRepositoryProvider).currentUser;
});

// A StateNotifier to manage sign-in loading and error state
class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(const AsyncData(null));

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    try {
      await _repository.signInWithGoogle();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await _repository.signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});
