import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../shared/widgets/inputs/app_text_field.dart';

class GenericForm extends StatefulWidget {
  final Future<void> Function(BuildContext) onSelectDate;
  final Future<void> Function(BuildContext) onSelectTime;
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final DateTime startDate;
  final bool isDateVisible;
  final Map<String, dynamic> initialMetadata;
  final ValueChanged<Map<String, dynamic>> onMetadataChanged;

  const GenericForm({
    super.key,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.startDate,
    required this.isDateVisible,
    required this.initialMetadata,
    required this.onMetadataChanged,
  });

  @override
  State<GenericForm> createState() => _GenericFormState();
}

class _GenericFormState extends State<GenericForm> {
  String _selectedEmoji = '✨';

  final List<String> _commonEmojis = [
    '✨',
    '🍕',
    '🎨',
    '🎵',
    '🏃',
    '✈️',
    '🏨',
    '📷',
    '🛍️',
    '🏊',
    '🚴',
    '🎭',
    '🎡',
    '🏛️',
    '🌳',
    '⛺',
    '🚗',
    '🚆',
    '⛴️',
    '🏖️',
    '⛰️',
    '🏰',
    '🍷',
    '☕',
    '🍦',
    '🥐',
    '🍜',
    '🍣',
    '🍹',
    '🎳',
    '🎲',
    '🎮',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialMetadata['custom_icon'] != null) {
      _selectedEmoji = widget.initialMetadata['custom_icon'];
    }
  }

  void _onEmojiSelected(String emoji) {
    setState(() => _selectedEmoji = emoji);
    widget.onMetadataChanged({
      ...widget.initialMetadata,
      'custom_icon': emoji,
    });
    Navigator.pop(context);
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 400,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Pick an Icon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _commonEmojis.length,
                itemBuilder: (context, index) {
                  final emoji = _commonEmojis[index];
                  return GestureDetector(
                    onTap: () => _onEmojiSelected(emoji),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedEmoji == emoji
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: _selectedEmoji == emoji
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        AppTextField(
          controller: widget.titleController,
          label: 'ACTIVITY TITLE',
          placeholder: 'What are you doing?',
          prefixIcon: const Icon(Icons.auto_awesome, size: 18),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Location (Full Width)
        AppTextField(
          controller: widget.locationController,
          label: 'LOCATION',
          placeholder: 'Where is it?',
          prefixIcon: const Icon(Icons.location_on_outlined, size: 18),
        ),

        const SizedBox(height: 16),

        // Time & Icon Row
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onSelectTime(context),
                child: AbsorbPointer(
                  child: AppTextField(
                    controller: TextEditingController(
                      text:
                          '${widget.startDate.hour}:${widget.startDate.minute.toString().padLeft(2, '0')}',
                    ),
                    label: widget.isDateVisible ? 'TIME' : 'TIME',
                    placeholder: '00:00',
                    prefixIcon: const Icon(Icons.access_time, size: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 6.0),
                    child: Text(
                      'ICON',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryLight,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _showEmojiPicker,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _selectedEmoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Notes (Prominent)
        AppTextField(
          controller: widget.descriptionController,
          label: 'NOTES',
          placeholder: 'Write everything! Ideas, memories, feelings...',
          prefixIcon: const Icon(Icons.edit_note, size: 18),
          maxLines: 5,
        ),
      ],
    );
  }
}
