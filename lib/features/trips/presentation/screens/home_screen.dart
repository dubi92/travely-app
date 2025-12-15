import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/trip_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../widgets/trip_card.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(userTripsProvider);
    final profileAsync = ref.watch(profileControllerProvider);

    // Refresh handler
    Future<void> _refresh() async {
      ref.invalidate(userTripsProvider);
      return ref.read(userTripsProvider.future).then((_) {});
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.push('/profile'),
                    child: CircleAvatar(
                      backgroundImage: profileAsync.value?.avatarUrl != null
                          ? NetworkImage(profileAsync.value!.avatarUrl!)
                          : null,
                      child: profileAsync.value?.avatarUrl == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      Text(
                        profileAsync.value?.fullName ?? 'Traveler',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ],
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: tripsAsync.when(
              data: (trips) {
                if (trips.isEmpty) {
                  return _buildEmptyState(context);
                }

                final now = DateTime.now();
                // "Upcoming" logic: endDate is in future
                final upcoming = trips
                    .where(
                        (t) => t.endDate.isAfter(now) && t.status != 'archived')
                    .toList();
                final past = trips
                    .where((t) =>
                        t.endDate.isBefore(now) && t.status != 'archived')
                    .toList();

                // Sort upcoming by nearest start date
                upcoming.sort((a, b) => a.startDate.compareTo(b.startDate));
                // Sort past by most recent end date
                past.sort((a, b) => b.endDate.compareTo(a.endDate));

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (upcoming.isNotEmpty) ...[
                        Text('Upcoming Trips',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ...upcoming.map((trip) => TripCard(
                              trip: trip,
                              onTap: () => context.push('/trips/${trip.id}'),
                            )),
                      ],
                      if (past.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        ExpansionTile(
                          title: Text('Past Trips',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.grey)),
                          initiallyExpanded:
                              upcoming.isEmpty, // Expand if no upcoming
                          tilePadding: EdgeInsets.zero,
                          children: past
                              .map((trip) => TripCard(
                                    trip: trip,
                                    onTap: () =>
                                        context.push('/trips/${trip.id}'),
                                  ))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/trips/create'),
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.flight_takeoff,
                size: 64, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 24),
          const Text(
            'No trips yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start planning your next adventure!',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          // FilledButton(
          //   onPressed: () => context.push('/trips/create'),
          //   child: const Text('Create Your First Trip'),
          // ),
          // FAB covers this action, maybe just an arrow pointing down?
          // Or just leave FAB.
        ],
      ),
    );
  }
}
