import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/trip_repository.dart';
import '../../data/member_repository.dart';
import '../../data/invitation_repository.dart';
import '../../domain/models/trip_member_model.dart';
import '../../domain/models/trip_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  return TripRepository();
});

final memberRepositoryProvider = Provider<MemberRepository>((ref) {
  return MemberRepository();
});

final invitationRepositoryProvider = Provider<InvitationRepository>((ref) {
  return InvitationRepository();
});

final tripMembersProvider = FutureProvider.family<List<TripMember>, String>((ref, tripId) async {
  final repo = ref.watch(memberRepositoryProvider);
  return repo.getTripMembers(tripId);
});

final userTripsProvider = AsyncNotifierProvider<UserTripsController, List<Trip>>(() {
  return UserTripsController();
});

// Holds the draft data for the trip creation wizard
final createTripDraftProvider = StateProvider<Map<String, dynamic>>((ref) => {});

class UserTripsController extends AsyncNotifier<List<Trip>> {
  @override
  Future<List<Trip>> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];
    
    final repo = ref.read(tripRepositoryProvider);
    return repo.getUserTrips(user.id);
  }

  Future<Trip> createTrip(Trip trip) async {
    state = const AsyncLoading<List<Trip>>().copyWithPrevious(state);
    Trip? createdTrip;
    state = await AsyncValue.guard(() async {
      final repo = ref.read(tripRepositoryProvider);
      final memberRepo = ref.read(memberRepositoryProvider);
      
      final newTrip = await repo.createTrip(trip);
      createdTrip = newTrip;
      
      // Auto-add creator as admin member
      final user = ref.read(currentUserProvider);
      if (user != null) {
        await memberRepo.addMember(newTrip.id, user.id, role: 'admin');
      }
      
      return [...?state.value, newTrip];
    });
    
    if (state.hasError) throw state.error!;
    return createdTrip!;
  }

  Future<void> updateTrip(Trip trip) async {
    state = const AsyncLoading<List<Trip>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
       await ref.read(tripRepositoryProvider).updateTrip(trip);
       return [
         for (final t in state.value ?? [])
           if (t.id == trip.id) trip else t
       ];
    });
  }

  Future<void> deleteTrip(String tripId) async {
    state = const AsyncLoading<List<Trip>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      await ref.read(tripRepositoryProvider).deleteTrip(tripId);
      return [
        for (final t in state.value ?? [])
          if (t.id != tripId) t
      ];
    });
  }
}
