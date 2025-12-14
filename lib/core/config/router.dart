import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/profile/presentation/providers/profile_provider.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/permissions_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Use a Notifier to trigger router refreshes
  final routerDataNotifier = RouterNotifier(ref);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: routerDataNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final profileState = ref.read(profileControllerProvider);
      final currentUser = ref.read(currentUserProvider);
      
      final isLoggedIn = authState.asData?.value.session != null;
      final isWelcome = state.uri.toString() == '/welcome';
      final isPermissions = state.uri.toString() == '/permissions';
      final isLoadingRoute = state.uri.toString() == '/loading';

      // 1. Not logged in -> redirect to welcome
      if (!isLoggedIn) {
        return isWelcome ? null : '/welcome';
      }

      // 2. Logged in, check profile for onboarding
      final profile = profileState.value;
      
      // If profile is loading, or we have a profile mismatch (stale data from prev user), show loading.
      // We only skip loading if we have a valid value AND it belongs to the current user.
      final isProfileLoading = profileState.isLoading;
      final hasValidProfile = profileState.hasValue && profile != null && currentUser != null && profile.id == currentUser.id;

      if (isProfileLoading && !hasValidProfile) {
        if (isLoadingRoute) return null;
        return '/loading';
      }
      
      // If we are technically loading (reloading/updating) but have a valid profile, stay put.
      final isOnboarded = profile?.onboardingCompleted == true;

      // Only redirect to permissions if we have a profile (or loaded null) and it's not onboarded.
      // Use the profile we have (which might be stale if we didn't check above, but we checked above).
      
      if (hasValidProfile && !isOnboarded) {
         if (isPermissions) return null;
         return '/permissions';
      }

      // 3. Logged in AND Onboarded
      if (isWelcome || isPermissions || isLoadingRoute) {
         // Should we support deep linking?
         // If user requested a specific path (that is not one of the auth/loading paths), let them go there.
         // But the logic here catches those paths specifically.
         // If `state.uri` is `/profile`, this block is skipped.
         // So they stay on `/profile`.
         return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Travely'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => context.push('/profile'),
              ),
            ],
          ),
          body: const Center(child: Text('Home Screen')),
        ),
        routes: [
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) => const EditProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),
      ),
    ],
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) => notifyListeners());
    _ref.listen(profileControllerProvider, (_, __) => notifyListeners());
    // Also listen to currentUser in case it changes independently (though usually tied to auth)
    _ref.listen(currentUserProvider, (_, __) => notifyListeners());
  }
}
