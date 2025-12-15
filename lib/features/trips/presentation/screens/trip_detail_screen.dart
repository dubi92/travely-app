import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../itinerary/presentation/screens/itinerary_screen.dart';
import '../providers/trip_provider.dart';

class TripDetailScreen extends ConsumerStatefulWidget {
  final String tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  ConsumerState<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends ConsumerState<TripDetailScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tripsAsync = ref.watch(userTripsProvider);

    return tripsAsync.when(
      data: (trips) {
        final trip = trips.firstWhere(
          (t) => t.id == widget.tripId,
          orElse: () => throw Exception(
              'Trip not found'), // Handle gracefully in real app
        );

        return Scaffold(
          // Hide AppBar for Itinerary tab as it has its own custom header
          // Also hide for other tabs if they have their own headers, but for now only Itinerary
          appBar: _currentIndex == 0
              ? null
              : AppBar(
                  title: Text(trip.name),
                  // Settings moved to tab
                ),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              ItineraryScreen(trip: trip),
              const Center(child: Text('Expenses Content (Phase 3)')),
              const Center(child: Text('Split Content (Phase 3)')),
              const Center(child: Text('Settings Content (Phase 3)')),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondaryLight,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.map_rounded), label: 'Itinerary'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money_rounded), label: 'Expenses'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart_rounded), label: 'Split'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_rounded), label: 'Setting'),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
