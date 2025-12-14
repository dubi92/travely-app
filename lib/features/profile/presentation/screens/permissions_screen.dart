import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8), // background-light
      body: Column(
        children: [
          // Header Image
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.75, // 4:3 aspect ratio roughly
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
              image: DecorationImage(
                image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBkOmfnxwlJCE66Tgpe41ykfa41_z8cQdIbL-SxeBGnpG_n70FYCl3TGkqjpJtOJ7_AzsUugfCbIsVdRBnc73yMioc5cjcNOAr2WAkuuKHtoPS-qVEvqT4YnnSMdajy87fo4n9FsAOjsj7jrHfQwe7kW5BqEiwGKoo7XxqNHlb_DMpjjdaVS5fk1NlZULaBDmfcsY5_kn7X3wEzVgSgzc4g2XAdFRBcSl011IXn1MXRVSf6ON2-qmlUgS3mT2nqgwhMn6PcX0ZRgvE'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  const Text(
                    'Help us guide your journey',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111418),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'We need a few permissions to help you plan trips and split bills effortlessly.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF617389),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildPermissionCard(
                    title: 'Trip Reminders',
                    description: 'Get notified about upcoming flights and bill updates.',
                    icon: Icons.notifications_active,
                    value: _notificationsEnabled,
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildPermissionCard(
                    title: 'Local Recommendations',
                    description: 'See travel spots near you and tag locations automatically.',
                    icon: Icons.location_on,
                    value: _locationEnabled,
                    onChanged: (val) => setState(() => _locationEnabled = val),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFFF6F7F8),
            ),
            child: Consumer(
              builder: (context, ref, child) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                           await _completeOnboarding(ref);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3182ED), // Primary Blue
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 4,
                          shadowColor: const Color(0xFF3182ED).withValues(alpha: 0.4),
                        ),
                        child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () async {
                         // Even if they skip, we mark onboarding as done so they don't get stuck here
                         await _completeOnboarding(ref, skipped: true);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF617389),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                      child: const Text('I\'ll do this later', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _completeOnboarding(WidgetRef ref, {bool skipped = false}) async {
    final profile = ref.read(profileControllerProvider).value;
    if (profile == null) return;
    
    // If skipped, we might leave defaults or set them to false. 
    // Assuming defaults for now, but keeping onboardingCompleted = true
    
    final updatedProfile = profile.copyWith(
      tripAlerts: skipped ? profile.tripAlerts : _notificationsEnabled,
      onboardingCompleted: true,
      // For local recommendations we don't have a field in profile yet, 
      // usually this would map to a permission or preference. 
      // Ignoring for now as per model.
    );
    
    await ref.read(profileControllerProvider.notifier).updateProfile(updatedProfile);
    
    // Navigation is handled by router redirect based on state change
  }

  Widget _buildPermissionCard({
    required String title,
    required String description,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF3182ED).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF3182ED), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111418)),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF617389), height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch.adaptive(
            value: value, 
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF3182ED),
          ),
        ],
      ),
    );
  }
}
