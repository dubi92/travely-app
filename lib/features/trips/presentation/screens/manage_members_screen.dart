import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/trip_member_model.dart';
import '../providers/trip_provider.dart';
import '../widgets/invite_link_widget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ManageMembersScreen extends ConsumerStatefulWidget {
  final String tripId;

  const ManageMembersScreen({super.key, required this.tripId});

  @override
  ConsumerState<ManageMembersScreen> createState() => _ManageMembersScreenState();
}

class _ManageMembersScreenState extends ConsumerState<ManageMembersScreen> {
  TripInvitation? _invitation;
  bool _isLoadingInvite = false;

  @override
  void initState() {
    super.initState();
    _loadInvite();
  }

  Future<void> _loadInvite() async {
    // Attempt to fetch existing or create new invite - logic simplifed for UI
    // In reality, we might want to just generate one on button press, but for "Join" flow readiness, let's auto-generate.
    setState(() => _isLoadingInvite = true);
    try {
      final repo = ref.read(invitationRepositoryProvider);
      // We need a repository method that "gets or creates". 
      // Our createInviteLink does a check inside.
      final invite = await repo.createInviteLink(widget.tripId);
      if (mounted) {
        setState(() {
          _invitation = invite;
          _isLoadingInvite = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingInvite = false);
    }
  }

  Future<void> _removeMember(String memberId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Member'),
        content: const Text('Are you sure you want to remove this member?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Remove', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await ref.read(memberRepositoryProvider).removeMember(widget.tripId, memberId);
      ref.invalidate(tripMembersProvider(widget.tripId));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to remove member: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(tripMembersProvider(widget.tripId));
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Manage Members'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invite Section
            Text('INVITE MEMBERS', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 12),
            if (_isLoadingInvite)
              const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()))
            else if (_invitation != null)
              InviteLinkWidget(inviteCode: _invitation!.inviteCode),
            
            const SizedBox(height: 32),

            // Members List
            Text('MEMBERS', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 12),
            membersAsync.when(
              data: (members) {
                 final isAdmin = members.any((m) => m.userId == currentUser?.id && m.role == 'admin');
                 
                 return ListView.builder(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: members.length,
                   itemBuilder: (context, index) {
                     final member = members[index];
                     final isMe = member.userId == currentUser?.id;
                     
                     return ListTile(
                       contentPadding: EdgeInsets.zero,
                       leading: CircleAvatar(
                         backgroundImage: member.userAvatarUrl != null ? NetworkImage(member.userAvatarUrl!) : null,
                         child: member.userAvatarUrl == null ? Text((member.userName ?? '?')[0].toUpperCase()) : null,
                       ),
                       title: Text(member.userName ?? 'Unknown User', style: TextStyle(fontWeight: isMe ? FontWeight.bold : FontWeight.normal)),
                       subtitle: Text(member.role.toUpperCase(), style: const TextStyle(fontSize: 12)),
                       trailing: (isAdmin && !isMe) // Admin can remove others, not themselves (leave flow separate)
                           ? IconButton(
                               icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                               onPressed: () => _removeMember(member.userId),
                             )
                           : null,
                     );
                   },
                 );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Text('Error loading members: $e'),
            ),
          ],
        ),
      ),
    );
  }
}
