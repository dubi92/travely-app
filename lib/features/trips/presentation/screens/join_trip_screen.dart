import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/trip_provider.dart';

class JoinTripScreen extends ConsumerStatefulWidget {
  final String? inviteCode;

  const JoinTripScreen({super.key, this.inviteCode});

  @override
  ConsumerState<JoinTripScreen> createState() => _JoinTripScreenState();
}

class _JoinTripScreenState extends ConsumerState<JoinTripScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.inviteCode != null) {
      _codeController.text = widget.inviteCode!;
      // Auto-submit if code is present? Maybe let user confirm.
    }
  }

  Future<void> _joinTrip() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repo = ref.read(invitationRepositoryProvider);
      await repo.acceptInvitation(code);
      
      if (mounted) {
        // Find which trip this code belonged to, to redirect? 
        // acceptInvitation doesn't return tripId currently.
        // We'd need to fetch the invite first to know where to go, or refetch user trips.
        
        // Optimistic refresh
        ref.invalidate(userTripsProvider);
        
        // Go home or to trip? Go Home for now as finding trip ID requires another lookup.
        // Ideally prompt success then route.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully joined trip!')),
        );
        context.go('/'); 
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to join: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Trip')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flight_takeoff, size: 64, color: Colors.blue),
            const SizedBox(height: 32),
            Text(
              'Enter Invite Code',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                hintText: 'e.g. ABC-123',
                border: const OutlineInputBorder(),
                errorText: _error,
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _isLoading ? null : _joinTrip,
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text('Join Trip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
