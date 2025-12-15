import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../shared/widgets/inputs/app_text_field.dart';

class SightseeingForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final Map<String, dynamic> initialMetadata;
  final DateTime initialStartTime;
  final DateTime? initialEndTime;
  final ValueChanged<Map<String, dynamic>> onMetadataChanged;
  final ValueChanged<DateTime> onStartTimeChanged;
  final ValueChanged<DateTime?> onEndTimeChanged;
  final ValueChanged<bool> onIsPaidChanged;

  const SightseeingForm({
    super.key,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.priceController,
    required this.initialMetadata,
    required this.initialStartTime,
    this.initialEndTime,
    required this.onMetadataChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onIsPaidChanged,
  });

  @override
  State<SightseeingForm> createState() => _SightseeingFormState();
}

class _SightseeingFormState extends State<SightseeingForm> {
  // Local state for UI selections
  bool _ticketNeeded = false;

  // Media
  XFile? _coverImage;
  List<XFile> _photoPoses = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize state from existing data if available
    _ticketNeeded = widget.priceController.text.isNotEmpty &&
        widget.priceController.text != '0';

    // Initialize images from metadata if existing (assuming stored as paths)
    if (widget.initialMetadata['cover_image_path'] != null) {
      _coverImage = XFile(widget.initialMetadata['cover_image_path']);
    }
    if (widget.initialMetadata['photo_poses_paths'] != null) {
      final paths =
          List<String>.from(widget.initialMetadata['photo_poses_paths']);
      _photoPoses = paths.map((path) => XFile(path)).toList();
    }
  }

  void _notifyMetadataChange() {
    // Merge standard fields (if any) with media paths
    final newMetadata = Map<String, dynamic>.from(widget.initialMetadata);

    // Store paths
    if (_coverImage != null) {
      newMetadata['cover_image_path'] = _coverImage!.path;
    }
    if (_photoPoses.isNotEmpty) {
      newMetadata['photo_poses_paths'] =
          _photoPoses.map((e) => e.path).toList();
    }

    widget.onMetadataChanged(newMetadata);
  }

  Future<void> _pickCoverImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _coverImage = image;
      });
      _notifyMetadataChange();
    }
  }

  Future<void> _pickPoseImage() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _photoPoses.addAll(images);
      });
      _notifyMetadataChange();
    }
  }

  void _removePoseImage(int index) {
    setState(() {
      _photoPoses.removeAt(index);
    });
    _notifyMetadataChange();
  }

  void _toggleTicket(bool value) {
    setState(() => _ticketNeeded = value);
    widget.onIsPaidChanged(value);
    // Note: Clearing price controller might annoy user if toggled accidentally,
    // but standard behavior for now.
    if (!value) {
      widget.priceController.clear();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(widget.initialStartTime),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final newDateTime = DateTime(
        widget.initialStartTime.year,
        widget.initialStartTime.month,
        widget.initialStartTime.day,
        picked.hour,
        picked.minute,
      );
      widget.onStartTimeChanged(newDateTime);
      // Re-apply duration (default 2 hours since UI is gone)
      widget.onEndTimeChanged(newDateTime.add(const Duration(hours: 2)));
    }
  }

  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover Image Section
        GestureDetector(
          onTap: _pickCoverImage,
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              image: _coverImage != null
                  ? DecorationImage(
                      image: _getImageProvider(_coverImage!.path),
                      fit: BoxFit.cover,
                    )
                  : null,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 2,
                style:
                    _coverImage != null ? BorderStyle.solid : BorderStyle.none,
              ),
            ),
            child: _coverImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo,
                          size: 40, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        'Add Cover Photo',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        ),
        const SizedBox(height: 24),

        // Place Name Using AppTextField
        AppTextField(
          controller: widget.titleController,
          label: 'PLACE NAME',
          placeholder: 'e.g, Ancient Ruis Temple',
          prefixIcon: const Icon(Icons.place, size: 18),
        ),

        const SizedBox(height: 16),

        // Location (Full Width)
        AppTextField(
          controller: widget.locationController,
          label: 'WHERE?',
          placeholder: 'Location address...',
          prefixIcon: const Icon(Icons.location_on_outlined, size: 18),
        ),

        const SizedBox(height: 16),

        // Time and Ticket Row
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: AppTextField(
                    controller: TextEditingController(
                        text:
                            '${widget.initialStartTime.hour.toString().padLeft(2, '0')}:${widget.initialStartTime.minute.toString().padLeft(2, '0')}'),
                    label: 'TIME',
                    placeholder: '00:00',
                    prefixIcon: const Icon(Icons.access_time, size: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 6.0),
                    child: Text(
                      'TICKET?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryLight,
                        fontSize:
                            12, // Matching labelMedium approx if unavailable, or import AppTypography
                      ),
                    ),
                  ),
                  Container(
                    height: 48, // Match standard input height
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                          12), // Match input radius often used
                      // border: Border.all(color: Colors.grey.shade300), // Optional if standard inputs have borders
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.confirmation_number_outlined,
                            size: 18, color: AppColors.primary),
                        Switch(
                          value: _ticketNeeded,
                          onChanged: _toggleTicket,
                          activeTrackColor: AppColors.primary,
                          activeThumbColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        if (_ticketNeeded) ...[
          // Price
          AppTextField(
            controller: widget.priceController,
            label: 'PRICE',
            placeholder: 'Cost',
            prefixIcon: const Icon(Icons.attach_money, size: 18),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
        ],

        // Photo Poses Section
        const Text(
          'PHOTO POSES',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.playfulTextPrimary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _photoPoses.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                // Add Button
                return GestureDetector(
                  onTap: _pickPoseImage,
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Icon(Icons.add, color: AppColors.primary),
                  ),
                );
              }

              final file = _photoPoses[index - 1];
              return Stack(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: _getImageProvider(file.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removePoseImage(index - 1),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        const SizedBox(height: 24),

        // Notes
        AppTextField(
          controller: widget.descriptionController,
          label: 'NOTES',
          placeholder: 'Tips, details, secret spots!',
          prefixIcon: const Icon(Icons.edit_note, size: 18),
          maxLines: 3,
        ),
      ],
    );
  }
}
