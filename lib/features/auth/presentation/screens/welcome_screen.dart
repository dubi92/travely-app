import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

import '../../../../shared/widgets/widgets.dart';
import '../providers/auth_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      if (next.hasError) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Sign In Failed'),
            content: Text(next.error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (next.hasValue && !isLoading) {
        // Success - navigation is handled by router listener usually, 
        // but can force here if needed.
        // context.go('/'); 
      }
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Column(
        children: [
          // Hero Image Section (Mocked with placeholder for now to match structure)
          Expanded(
            flex: 6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAdLmblwZqU3JKlWaPeWJLCFZL9F1uxDy9rOhscta99u9pdpmsHtRXSjgdcxw4N0W1Ti1YHqACVf6_et_F_REyh9y9Kol_mWrCWPeTICM7WNGcZTHgLeyzYfQU_ozzVCI6cgQYILY8Hjrsx-ayyAt80rypwGPQiiuR213U3NPNezd4zDgiz4KvuVO0uNTRRHol8vrV3A7ANEOwfM-6vvXiTpyMiACKVuHjEr9T4GkVy4DwEfGSTGz0OKBatPCCHU4t2QcKrwHQkmco',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image_not_supported, size: 50)),
                  ),
                ),
                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                         Colors.black.withValues(alpha: 0.05),
                         Colors.transparent,
                         Colors.black.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                ),
                // Bottom Fade to White/Dark
                Positioned(
                  bottom: 0,
                  left: 0, 
                  right: 0,
                  height: 128,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (isDark ? AppColors.backgroundDark : Colors.white).withValues(alpha: 0.0),
                          (isDark ? AppColors.backgroundDark : Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                // Logo Pill
                Positioned(
                  top: 48,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.backgroundDark : Colors.white).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.travel_explore, color: AppColors.primary, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            // OpenSpec says Travely.
                            'TRAVELY', 
                            style: AppTypography.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // content section
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // Pagination/Carousel dots (mocked)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 32, height: 6, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(3))),
                            const SizedBox(width: 8),
                            Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.textSecondaryLight.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(3))),
                            const SizedBox(width: 8),
                            Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.textSecondaryLight.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(3))),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Plan together.\nSpend smarter.\nTravel stress-free.',
                          textAlign: TextAlign.center,
                          style: AppTypography.textTheme.displayLarge?.copyWith(
                            height: 1.2,
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Manage itineraries and split expenses effortlessly, so you can focus on the memories.',
                          textAlign: TextAlign.center,
                          style: AppTypography.textTheme.bodyLarge?.copyWith(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                    
                    Column(
                      children: [
                         if (isLoading)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: LoadingIndicator(),
                          )
                        else ...[
                          SocialButton(
                            type: SocialType.google,
                            onPressed: () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
                          ),
                          const SizedBox(height: 16),
                          // Secondary option (though design had Start Planning primary button, instructions say Use "Continue with Google" as primary action for auth flow)
                          // The design has "Start Planning" which likely leads to auth or guest mode.
                          // Spec 5.5 says: Add "Continue with Google" button (primary style)
                          // But SocialButton is usually styled specifically. 
                          // Let's us specific design requirement: "Continue with Google" button (primary style)
                          // Actually, SocialButton implements the Google branded button which is white/black.
                          // If spec says primary style, it might mean the layout position.
                          // Let's stick to the standard SocialButton we built which follows design guidelines for Social Login.
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
