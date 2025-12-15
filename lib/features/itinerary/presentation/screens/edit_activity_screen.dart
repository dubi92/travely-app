import 'package:flutter/material.dart'
    hide BackButton; // Hide BackButton from material
import 'package:flutter/material.dart' as material
    show BackButton; // Import specifically if needed or just use standard
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart'; // For ConfirmationDialog and our BackButton if exported
import '../../../activities/domain/models/activity_model.dart';
import '../providers/activities_provider.dart';
import '../widgets/activity_form.dart';

class EditActivityScreen extends ConsumerStatefulWidget {
  final Activity activity;

  const EditActivityScreen({
    super.key,
    required this.activity,
  });

  @override
  ConsumerState<EditActivityScreen> createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends ConsumerState<EditActivityScreen> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit(Map<String, dynamic> data) async {
    setState(() => _isSubmitting = true);

    try {
      // 1. Handle Image Uploads
      final metadata = Map<String, dynamic>.from(data['metadata'] ?? {});
      final activityRepo = ref.read(activityRepositoryProvider);

      // 1a. Cover Image
      if (metadata['cover_image_path'] != null) {
        final path = metadata['cover_image_path'] as String;
        // Only upload if it's a local file (not http)
        if (!path.startsWith('http')) {
          final url =
              await activityRepo.uploadActivityImage(widget.activity.id, path);
          metadata['cover_image_path'] = url;
        }
      }

      // 1b. Photo Poses
      if (metadata['photo_poses_paths'] != null) {
        final paths = List<String>.from(metadata['photo_poses_paths']);
        final uploadedUrls = <String>[];
        for (final path in paths) {
          if (!path.startsWith('http')) {
            final url = await activityRepo.uploadActivityImage(
                widget.activity.id, path);
            uploadedUrls.add(url);
          } else {
            uploadedUrls.add(path);
          }
        }
        metadata['photo_poses_paths'] = uploadedUrls;
      }

      final updatedActivity = widget.activity.copyWith(
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
        updatedAt: DateTime.now(),
      );

      await ref
          .read(tripActivitiesProvider(widget.activity.tripId).notifier)
          .updateActivity(updatedActivity);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Activity updated!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating activity: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _handleDelete() async {
    final confirmed = await showConfirmationDialog(
      context,
      title: 'Delete Activity?',
      message:
          'Are you sure you want to delete "${widget.activity.title}"? This cannot be undone.',
      confirmText: 'Delete',
      isDestructive: true,
    );

    if (confirmed == true) {
      setState(() => _isSubmitting = true);
      try {
        await ref
            .read(tripActivitiesProvider(widget.activity.tripId).notifier)
            .deleteActivity(widget.activity.id);

        if (mounted) {
          Navigator.of(context).pop(); // Close screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Activity deleted')),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting activity: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight, // Fixed color
      appBar: AppBar(
        title: const Text('Edit Activity'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const material.BackButton(
            color: AppColors
                .textPrimaryLight), // Use material back button or custom one
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimaryLight, // Fixed color
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            onPressed: _isSubmitting ? null : _handleDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ActivityForm(
          initialData: widget.activity,
          initialDate: widget.activity.startTime,
          onSubmit: _handleSubmit,
          isLoading: _isSubmitting,
        ),
      ),
    );
  }
}
