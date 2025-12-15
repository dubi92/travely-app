import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../activities/domain/models/activity_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/activities_provider.dart';
import '../widgets/activity_form.dart';

class AddActivityScreen extends ConsumerStatefulWidget {
  final String tripId;
  final DateTime selectedDate;
  final ActivityCategory? initialCategory;

  const AddActivityScreen({
    super.key,
    required this.tripId,
    required this.selectedDate,
    this.initialCategory,
  });

  @override
  ConsumerState<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends ConsumerState<AddActivityScreen> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit(Map<String, dynamic> data) async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('You must be logged in to create an activity')),
        );
      }
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final now = DateTime.now();
      // 1. Prepare Activity ID (needed for storage path)
      final activityId = const Uuid().v4();

      // 2. Handle Image Uploads (if any)
      final metadata = Map<String, dynamic>.from(data['metadata'] ?? {});
      final activityRepo = ref.read(activityRepositoryProvider);

      // 2a. Cover Image
      if (metadata['cover_image_path'] != null) {
        final path = metadata['cover_image_path'] as String;
        // Check if it's a local file (it should be for new activities)
        // We assume paths not starting with http are local
        if (!path.startsWith('http')) {
          final url = await activityRepo.uploadActivityImage(activityId, path);
          metadata['cover_image_path'] = url;
        }
      }

      // 2b. Photo Poses
      if (metadata['photo_poses_paths'] != null) {
        final paths = List<String>.from(metadata['photo_poses_paths']);
        final uploadedUrls = <String>[];
        for (final path in paths) {
          if (!path.startsWith('http')) {
            final url =
                await activityRepo.uploadActivityImage(activityId, path);
            uploadedUrls.add(url);
          } else {
            uploadedUrls.add(path);
          }
        }
        metadata['photo_poses_paths'] = uploadedUrls;
      }

      final activity = Activity(
        id: activityId,
        tripId: widget.tripId,
        title: data['title'],
        description: data['description'],
        location: data['location'],
        startTime: data['start_time'],
        endTime: data['end_time'],
        category: data['category'],
        price: data['price'],
        currency: data['currency'],
        isPaid: data['is_paid'],
        metadata: metadata,
        createdBy: user.id,
        createdAt: now,
        updatedAt: now,
      );

      await ref
          .read(tripActivitiesProvider(widget.tripId).notifier)
          .createActivity(activity);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Activity created successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating activity: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight, // Fixed color
      appBar: AppBar(
        title: const Text('Add Activity'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:
            const BackButton(color: AppColors.textPrimaryLight), // Fixed color
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimaryLight, // Fixed color
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ActivityForm(
          initialDate: widget.selectedDate,
          initialCategory: widget.initialCategory,
          onSubmit: _handleSubmit,
          isLoading: _isSubmitting,
        ),
      ),
    );
  }
}
