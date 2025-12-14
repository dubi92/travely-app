import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/profile_repository.dart';
import '../../domain/models/profile_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

class ProfileController extends AsyncNotifier<Profile?> {
  @override
  Future<Profile?> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;

    final repo = ref.read(profileRepositoryProvider);
    try {
      return await repo.getProfile(user.id);
    } catch (e) {
      // If profile fetch fails (e.g., doesn't exist yet), return a default profile
      // populated with any available metadata from the auth user.
      return Profile(
        id: user.id,
        fullName: user.userMetadata?['full_name'] as String?,
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
        // Phone might be in user.phone if confirmed, but often kept separate or in metadata
        phone: user.phone, 
      );
    }
  }

  Future<void> updateProfile(Profile profile) async {
    state = AsyncLoading<Profile?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      await ref.read(profileRepositoryProvider).updateProfile(profile);
      return profile;
    });
  }

  Future<void> uploadAvatar(File file) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    
    final previousState = state.value;
    state = AsyncLoading<Profile?>().copyWithPrevious(state);
    
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      final url = await repo.uploadAvatar(user.id, file);
      
      final currentProfile = previousState ?? Profile(id: user.id);
      final updatedProfile = currentProfile.copyWith(avatarUrl: url);
      
      await repo.updateProfile(updatedProfile);
      return updatedProfile;
    });
  }
}

final profileControllerProvider = AsyncNotifierProvider<ProfileController, Profile?>(() {
  return ProfileController();
});
