import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/',
    refreshListenable: AuthStateListenable(authState),
    redirect: (context, state) {
      final isLoggedIn = authState.asData?.value.session != null;
      final isWelcome = state.uri.toString() == '/welcome';

      if (!isLoggedIn && !isWelcome) {
        return '/welcome';
      }

      if (isLoggedIn && isWelcome) {
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
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen')), // Placeholder for Home
        ),
      ),
    ],
  );
});

class AuthStateListenable extends ChangeNotifier {
  final AsyncValue<dynamic> authState;
  
  AuthStateListenable(this.authState);
}
