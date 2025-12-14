import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travely_app/shared/widgets/widgets.dart';
import '../../presentation/providers/profile_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8), // background-light
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F8).withValues(alpha: 0.9),
        title: const Text('Profile Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('User not found'));
          }
          
          final displayName = profile.fullName?.isNotEmpty == true 
              ? profile.fullName! 
              : (user?.email?.split('@').first ?? 'Traveler');
          
           final initials = displayName.isNotEmpty ? displayName.substring(0, 1).toUpperCase() : 'T';

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                // Avatar Section
                Center(
                  child: Column(
                    children: [
                       Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                        ),
                        child: EditableAvatar(
                          imageUrl: profile.avatarUrl,
                          initials: initials,
                          onEdit: () => context.push('/profile/edit'),
                          size: 112, // h-28 w-28 = 112px
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        displayName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Text(
                        'Traveler since 2021',
                         style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Personal Info Section
                _buildSectionTitle('PERSONAL INFO'),
                _buildCard([
                  _buildListTile(
                    icon: Icons.person_outline,
                    title: 'Full Name',
                    value: displayName,
                    onTap: () => context.push('/profile/edit'),
                  ),
                  _buildDivider(),
                  _buildListTile(
                    icon: Icons.mail_outline,
                    title: 'Email',
                    value: user?.email ?? '',
                    onTap: () {}, // Email usually not editable here or needs separate flow
                  ),
                  _buildDivider(),
                  _buildListTile(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: profile.phone?.isNotEmpty == true ? profile.phone! : 'Add phone',
                    onTap: () => context.push('/profile/edit'),
                  ),
                ]),
                
                const SizedBox(height: 24),

                // Preferences Section
                _buildSectionTitle('PREFERENCES'),
                _buildCard([
                  _buildCurrencyTile(
                    context, 
                    currentCurrency: profile.currency,
                    onChanged: (val) {
                       ref.read(profileControllerProvider.notifier).updateProfile(
                          profile.copyWith(currency: val),
                       );
                    }
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    title: 'Trip Alerts',
                    icon: Icons.notifications_none,
                    value: profile.tripAlerts,
                    onChanged: (val) {
                      ref.read(profileControllerProvider.notifier).updateProfile(
                        profile.copyWith(tripAlerts: val),
                      );
                    },
                  ),
                ]),
                
                const SizedBox(height: 24),
                
                // Actions (Help & Logout)
                _buildCard([
                   _buildListTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    value: '',
                    onTap: () {},
                   ),
                   _buildDivider(),
                   _buildListTile(
                    icon: Icons.logout,
                    title: 'Log Out',
                    value: '',
                    isDestructive: true,
                    onTap: () => _confirmLogout(context, ref),
                    showChevron: false,
                   ),
                ]),
                
                const SizedBox(height: 32),
                const Text(
                  'Calm Journey v2.4.0 (184)',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
        loading: () => const Center(child: LoadingIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 56, color: Color(0xFFEEEEEE));
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool showChevron = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[400], size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            if (showChevron) ...[
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: Colors.grey[300], size: 20),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildCurrencyTile(BuildContext context, {required String currentCurrency, required ValueChanged<String> onChanged}) {
      // For simplicity using a simple popup menu or just displaying it.
      // In a real app this might open a bottom sheet.
      return GestureDetector(
        onTap: () async {
          // Show bottom sheet or dialog
          final selected = await showModalBottomSheet<String>(
            context: context,
            builder: (ctx) => _CurrencyPicker(selected: currentCurrency),
          );
          if (selected != null) onChanged(selected);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(Icons.currency_exchange, color: Colors.grey[400], size: 24),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Default Currency',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  currentCurrency,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: Colors.grey[300], size: 20),
            ],
          ),
        ),
      );
  }

  Widget _buildSwitchTile({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // slightly less padding as Switch has its own padding
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400], size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
          Switch.adaptive(
            value: value, 
            onChanged: onChanged,
            activeTrackColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const _LogoutDialog(),
    );
    
    if (confirmed == true) {
       await ref.read(authControllerProvider.notifier).signOut();
       // Auto-redirect handled by router listening to authState
    }
  }
}

class _CurrencyPicker extends StatelessWidget {
  final String selected;
  const _CurrencyPicker({required this.selected});
  
  @override
  Widget build(BuildContext context) {
    final currencies = ['USD', 'EUR', 'GBP', 'JPY'];
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: currencies.map((c) => ListTile(
          title: Text(c, style: TextStyle(fontWeight: c == selected ? FontWeight.bold : FontWeight.normal)),
          trailing: c == selected ? const Icon(Icons.check, color: Colors.blue) : null,
          onTap: () => Navigator.pop(context, c),
        )).toList(),
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout, color: Colors.red, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Log out?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Are you sure you want to log out? You\'ll need to sign back in to access your planned trips and expenses.',
               textAlign: TextAlign.center,
               style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                ),
                child: const Text('Log Out', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, false),
                 style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Cancel', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
