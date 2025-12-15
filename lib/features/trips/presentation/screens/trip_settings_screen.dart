import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/models/trip_model.dart';
import '../providers/trip_provider.dart';

class TripSettingsScreen extends ConsumerStatefulWidget {
  final String tripId;
  const TripSettingsScreen({super.key, required this.tripId});

  @override
  ConsumerState<TripSettingsScreen> createState() => _TripSettingsScreenState();
}

class _TripSettingsScreenState extends ConsumerState<TripSettingsScreen> {
  final _nameController = TextEditingController();
  final _dateFormat = DateFormat('MMM d, yyyy');
  Trip? _trip;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrip();
  }

  Future<void> _loadTrip() async {
    // Try to find in list first
    final userTrips = ref.read(userTripsProvider).value;
    final cachedTrip = userTrips?.where((t) => t.id == widget.tripId).firstOrNull;

    if (cachedTrip != null) {
      setState(() {
        _trip = cachedTrip;
        _nameController.text = cachedTrip.name;
        _isLoading = false;
      });
      return;
    }

    // Fetch from repo
    try {
      final trip = await ref.read(tripRepositoryProvider).getTrip(widget.tripId);
      if (mounted) {
        setState(() {
          _trip = trip;
          _nameController.text = trip.name;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load trip: $e')),
        );
      }
    }
  }

  Future<void> _updateTrip() async {
    if (_trip == null) return;
    final updatedTrip = _trip!.copyWith(name: _nameController.text);
    
    try {
      await ref.read(userTripsProvider.notifier).updateTrip(updatedTrip);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip updated')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $e')),
        );
      }
    }
  }

  Future<void> _deleteTrip() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Archive Trip?'),
        content: const Text('Are you sure you want to archive this trip?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Archive')),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ref.read(userTripsProvider.notifier).updateTrip(_trip!.copyWith(status: 'archived'));
        if (mounted) context.go('/');
      } catch (e) {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to archive: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_trip == null) {
      return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: const Center(child: Text('Trip not found')),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: const Text('Trip Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            // Cover Image
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
                image: _trip!.coverImageUrl != null
                    ? DecorationImage(image: NetworkImage(_trip!.coverImageUrl!), fit: BoxFit.cover)
                    : null,
              ),
              alignment: Alignment.topRight,
              child: _trip!.coverImageUrl == null 
                  ? Center(child: Icon(Icons.image, size: 64, color: Colors.grey.shade400))
                  : null,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Trip Name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _updateTrip(),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Dates',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: '${_dateFormat.format(_trip!.startDate)} - ${_dateFormat.format(_trip!.endDate)}'
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            
            // Management List
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Align(alignment: Alignment.centerLeft, child: Text('MANAGEMENT', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12))),
            ),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.currency_exchange, color: Colors.blue),
              ),
              title: const Text('Trip Currency'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(_trip!.defaultCurrency, style: const TextStyle(color: Colors.grey)),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ]),
              onTap: () {},
            ),
              // Manage Members
              ListTile(
               leading: Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(color: Colors.purple.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                 child: const Icon(Icons.people, color: Colors.purple),
               ),
               title: const Text('Manage Members'),
               trailing: const Icon(Icons.chevron_right, color: Colors.grey),
               onTap: () => context.push('/trips/${widget.tripId}/members'),
             ),
             
             ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.account_balance_wallet, color: Colors.blue),
              ),
              title: const Text('Total Budget'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(_trip!.overallBudget?.toString() ?? 'Not set', style: const TextStyle(color: Colors.grey)),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ]),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.archive, color: Colors.grey),
              ),
              title: const Text('Archive Trip'),
              onTap: _deleteTrip,
            ),
             
             const SizedBox(height: 32),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: SizedBox(
                 width: double.infinity,
                 height: 50,
                 child: FilledButton(onPressed: _updateTrip, child: const Text('Save Changes')),
               ),
             ),
             
             const SizedBox(height: 8),
              if (_trip != null)
              Center(child: Text('Trip created on ${_dateFormat.format(_trip!.startDate)}', style: const TextStyle(color: Colors.grey, fontSize: 12))),
          ],
        ),
      ),
    );
  }
}
