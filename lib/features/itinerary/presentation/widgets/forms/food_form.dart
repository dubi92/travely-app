import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../shared/widgets/inputs/app_text_field.dart';
import '../inputs/location_input_field.dart';

class FoodForm extends StatefulWidget {
  final Map<String, dynamic> initialMetadata;
  final String? initialLocation;
  final DateTime? initialStartTime;
  final DateTime? initialEndTime; // Optional for food, but good to have
  final ValueChanged<Map<String, dynamic>> onChanged;

  const FoodForm({
    super.key,
    this.initialMetadata = const {},
    this.initialLocation,
    this.initialStartTime,
    this.initialEndTime,
    required this.onChanged,
  });

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  late int _priceLevel;
  bool _isBooked = false;

  // Standard fields
  final _locationController = TextEditingController();
  late DateTime _startTime; // We'll manage this locally and report back
  DateTime? _endTime;

  final _restaurantController = TextEditingController();
  final _mustOrderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFields();

    _restaurantController.addListener(_notifyChange);
    _mustOrderController.addListener(_notifyChange);
    _locationController.addListener(_notifyChange);
  }

  @override
  void didUpdateWidget(FoodForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // In a real app we might want to update fields if parent changes them,
    // but for now we assume Form is source of truth once loaded to avoid overwriting user input
    // unless we strictly want to support external updates.
  }

  void _initializeFields() {
    _priceLevel = widget.initialMetadata['price_level'] ?? 2;
    _isBooked = widget.initialMetadata['is_booked'] ?? false;
    _restaurantController.text =
        widget.initialMetadata['restaurant_name'] ?? '';
    _mustOrderController.text = widget.initialMetadata['must_orders'] ?? '';

    // Standard fields init
    _locationController.text = widget.initialLocation ?? '';
    _startTime = widget.initialStartTime ?? DateTime.now();
    _endTime = widget.initialEndTime;
  }

  void _notifyChange() {
    widget.onChanged({
      // Metadata
      'price_level': _priceLevel,
      'is_booked': _isBooked,
      'restaurant_name': _restaurantController.text,
      'must_orders': _mustOrderController.text,

      // Standard Fields (Parent ActivityForm must extract these)
      'location': _locationController.text,
      'start_time': _startTime,
      'end_time': _endTime,
    });
  }

  @override
  void dispose() {
    _restaurantController.dispose();
    _mustOrderController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startTime),
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
      final newDateTime = DateTime(_startTime.year, _startTime.month,
          _startTime.day, picked.hour, picked.minute);
      setState(() => _startTime = newDateTime);
      _notifyChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant Name
        AppTextField(
          controller: _restaurantController,
          label: 'EAT AT',
          placeholder: 'Restaurant Name',
          prefixIcon: const Icon(Icons.restaurant, size: 18),
        ),
        const SizedBox(height: 16),

        // Location (Full Width)
        LocationInputField(
          controller: _locationController,
          onMapTap: () {
            // TODO: Open Map
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Map picker coming soon!')),
            );
          },
        ),
        const SizedBox(height: 16),

        // Time & Booked Row
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: AppTextField(
                    controller: TextEditingController(
                        text:
                            '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'),
                    label: 'TIME',
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
                      'BOOKED?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryLight,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _isBooked ? 'Yes' : 'No',
                          style: TextStyle(
                            color: _isBooked
                                ? AppColors.primary
                                : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: _isBooked,
                          onChanged: (val) {
                            setState(() => _isBooked = val);
                            _notifyChange();
                          },
                          activeThumbColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Price Level
        const Text(
          'PRICE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.playfulTextPrimary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildPriceOption(1, '₫')),
            const SizedBox(width: 12),
            Expanded(child: _buildPriceOption(2, '₫₫')),
            const SizedBox(width: 12),
            Expanded(child: _buildPriceOption(3, '₫₫₫')),
          ],
        ),
        const SizedBox(height: 24),

        // Must Orders
        AppTextField(
          controller: _mustOrderController,
          label: 'MUST-ORDERS',
          placeholder: 'e.g. Bún Chả, Cơm Tấm',
          prefixIcon: const Icon(Icons.recommend, size: 18),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPriceOption(int level, String label) {
    final isSelected = _priceLevel == level;
    return GestureDetector(
      onTap: () {
        setState(() => _priceLevel = level);
        _notifyChange();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:
                  isSelected ? AppColors.primary : AppColors.textSecondaryLight,
            ),
          ),
        ),
      ),
    );
  }
}
