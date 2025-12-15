import 'package:flutter/material.dart';


class TripDetailScreen extends StatelessWidget {
  final String tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    // Ideally fetch trip here again or pass object. ID is standard for deep linking.
    // For shell, just show ID or simple placeholder.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
               // Navigate to settings
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Trip ID: $tripId'),
            const SizedBox(height: 16),
            const Text('Itinerary & content coming in Phase 3!'),
          ],
        ),
      ),
      // Placeholder bottom nav
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Itinerary'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Expenses'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Members'),
        ],
      ),
    );
  }
}
