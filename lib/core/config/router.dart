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
  final authState = ref.watch(authStateProvider);
  final profileState = ref.watch(profileControllerProvider);
  
  return GoRouter(
    initialLocation: '/',
    refreshListenable: AuthStateListenable(authState, profileState),
    redirect: (context, state) {
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
      
      // If profile is loading, redirect to /loading to avoid flashing Home
      if (profileState.isLoading) {
        if (isLoadingRoute) return null;
        return '/loading';
      }
      
      // Logic:
      // If New User (Profile loaded AND onboarding not completed) -> Go to Permissions
      // We check for actual profile existence to be sure.
      final isOnboarded = profile?.onboardingCompleted == true;

      // Only redirect to permissions if we have a profile (or loaded null) and it's not onboarded.
      // If profile is null (and not loading), it means we might need to create one, so treating as not onboarded is correct.
      if (!isOnboarded) {
         if (isPermissions) return null;
         return '/permissions';
      }

      // 3. Logged in AND Onboarded
      if (isWelcome || isPermissions || isLoadingRoute) {
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
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
        routes: [
           GoRoute(
              path: 'edit',
              builder: (context, state) => const EditProfileScreen(),
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

class AuthStateListenable extends ChangeNotifier {
  final AsyncValue<dynamic> authState;
  final AsyncValue<dynamic> profileState;
  
  AuthStateListenable(this.authState, this.profileState);
}
