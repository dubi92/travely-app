import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/widgets.dart'; // For AppTextField
import '../../../activities/domain/models/activity_model.dart'; // Corrected path
import 'category_selector.dart';
import 'forms/transport_form.dart';
import 'forms/food_form.dart';
import 'forms/generic_form.dart';
import 'forms/sightseeing_form.dart';
import 'forms/shopping_form.dart';

class ActivityForm extends StatefulWidget {
  final Activity? initialData;
  final DateTime? initialDate; // Default date if creating new
  final ActivityCategory? initialCategory;
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ActivityForm({
    super.key,
    this.initialData,
    this.initialDate,
    this.initialCategory,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();

  // Form State
  late TextEditingController _titleController;
  late TextEditingController _descriptionController; // Restored
  late TextEditingController _locationController;
  late TextEditingController _priceController; // Restored
  late TextEditingController _currencyController; // Restored
  late DateTime _startDate;
  late TimeOfDay _startTime;
  TimeOfDay? _endTime;
  late ActivityCategory _category;

  // Metadata for sub-forms
  Map<String, dynamic> _metadata = {};

  // Pricing
  bool _isPaid = false;

  @override
  void initState() {
    super.initState();

    final data = widget.initialData;
    final now = DateTime.now();

    // Initialize standard fields
    _titleController = TextEditingController(text: data?.title ?? '');
    _descriptionController = TextEditingController(text: data?.description);
    _locationController = TextEditingController(text: data?.location ?? '');
    _priceController =
        TextEditingController(text: data?.price?.toStringAsFixed(0));
    _currencyController = TextEditingController(text: data?.currency ?? 'USD');

    // Dates
    _startDate = data?.startTime ?? widget.initialDate ?? now;
    _startTime = TimeOfDay.fromDateTime(data?.startTime ?? now);

    if (data?.endTime != null) {
      _endTime = TimeOfDay.fromDateTime(data!.endTime!);
    } else {
      _endTime = null;
    }

    // Category (Prioritize initialCategory if explicit add, else use existing data or default)
    if (data != null) {
      // Edit mode
      _category = data.category;
    } else {
      // Add mode
      _category = widget.initialCategory ?? ActivityCategory.sightseeing;
    }

    // Pricing
    _isPaid = data?.isPaid ?? false;

    // Metadata
    _metadata = data?.metadata ?? {};
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
    if (picked != null && picked != _startDate) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final initial = isStart ? _startTime : (_endTime ?? _startTime);
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
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
      setState(() {
        if (isStart) {
          _startTime = picked;
          // Sync _startDate with new time
          _startDate = DateTime(
            _startDate.year,
            _startDate.month,
            _startDate.day,
            picked.hour,
            picked.minute,
          );
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Combine date and time
      final startDateTime = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _startTime.hour,
        _startTime.minute,
      );

      DateTime? endDateTime;
      if (_endTime != null) {
        endDateTime = DateTime(
          _startDate
              .year, // Assuming same day end for simplicity in first iteration
          _startDate.month,
          _startDate.day,
          _endTime!.hour,
          _endTime!.minute,
        );

        // Handle next day if end time < start time (e.g. late night party)
        if (endDateTime.isBefore(startDateTime)) {
          endDateTime = endDateTime.add(const Duration(days: 1));
        }
      }

      widget.onSubmit({
        'title': _titleController.text,
        'description': _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        'location':
            _locationController.text.isEmpty ? null : _locationController.text,
        'category': _category, // Pass enum, provider handles serialization
        'start_time': startDateTime,
        'end_time': endDateTime,
        'price': double.tryParse(_priceController.text),
        'currency': _currencyController
            .text, // Assuming fixed text field for now, selector later
        'is_paid': _isPaid,
        'metadata': _metadata,
      });
    }
  }

  void _updateMetadata(Map<String, dynamic> newMetadata) {
    setState(() {
      _metadata = newMetadata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Category
          if (widget.initialData == null && widget.initialCategory == null)
            CategorySelector(
              selectedCategory: _category,
              onCategorySelected: (cat) => setState(() => _category = cat),
            ),
          if (widget.initialData == null && widget.initialCategory == null)
            const SizedBox(height: 24),

          // Dynamic Content based on Category
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildCategoryForm(),
          ),

          const SizedBox(height: 40),

          // Submit Button
          PrimaryButton(
            text:
                widget.initialData == null ? 'Create Activity' : 'Save Changes',
            onPressed: widget.isLoading ? null : _handleSubmit,
            isLoading: widget.isLoading,
          ),
          const SizedBox(height: 40), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildCategoryForm() {
    switch (_category) {
      case ActivityCategory.transport:
        return TransportForm(
          initialMetadata: _metadata,
          initialStartTime: DateTime(
            _startDate.year,
            _startDate.month,
            _startDate.day,
            _startTime.hour,
            _startTime.minute,
          ),
          initialEndTime: _endTime != null
              ? DateTime(
                  _startDate.year,
                  _startDate.month,
                  _startDate.day,
                  _endTime!.hour,
                  _endTime!.minute,
                )
              : null,
          onChanged: (data) {
            _updateMetadata(data);

            // Handle standard fields from transport form
            if (data.containsKey('start_time')) {
              final dt = data['start_time'] as DateTime;
              setState(() {
                _startDate = dt;
                _startTime = TimeOfDay.fromDateTime(dt);
              });
              data.remove('start_time');
            }
            if (data.containsKey('end_time')) {
              final dt = data['end_time'] as DateTime?;
              if (dt != null) {
                setState(() {
                  _endTime = TimeOfDay.fromDateTime(dt);
                });
              } else {
                setState(() {
                  _endTime = null;
                });
              }
              data.remove('end_time');
            }

            // Auto-populate title from transport info
            if (data['transport_type'] != null && data['to_location'] != null) {
              final type = data['transport_type'].toString().toUpperCase();
              _titleController.text = '$type to ${data['to_location']}';
            }
          },
        );
      case ActivityCategory.food:
        // Fallback: If restaurant_name is missing in metadata (legacy/bugged data), Use Title
        final foodMetadata = Map<String, dynamic>.from(_metadata);
        if ((foodMetadata['restaurant_name'] == null ||
                foodMetadata['restaurant_name'] == '') &&
            _titleController.text.isNotEmpty) {
          foodMetadata['restaurant_name'] = _titleController.text;
        }

        return FoodForm(
          initialMetadata: foodMetadata,
          initialLocation: _locationController.text,
          initialStartTime: DateTime(
            _startDate.year,
            _startDate.month,
            _startDate.day,
            _startTime.hour,
            _startTime.minute,
          ),
          initialEndTime: _endTime != null
              ? DateTime(
                  _startDate.year,
                  _startDate.month,
                  _startDate.day,
                  _endTime!.hour,
                  _endTime!.minute,
                )
              : null,
          onChanged: (data) {
            // Check for standard field updates
            if (data.containsKey('location')) {
              _locationController.text = data['location'];
              data.remove('location');
            }
            if (data.containsKey('start_time')) {
              final dt = data['start_time'] as DateTime;
              setState(() {
                _startDate = dt;
                _startTime = TimeOfDay.fromDateTime(dt);
              });
              data.remove('start_time');
            }
            if (data.containsKey('end_time')) {
              final dt = data['end_time'] as DateTime?;
              if (dt != null) {
                setState(() {
                  _endTime = TimeOfDay.fromDateTime(dt);
                });
              } else {
                setState(() {
                  _endTime = null;
                });
              }
              data.remove('end_time');
            }

            _updateMetadata(data);

            // Auto-populate title from restaurant name
            if (data['restaurant_name'] != null &&
                data['restaurant_name'].isNotEmpty) {
              _titleController.text = data['restaurant_name'];
            }
          },
        );
      case ActivityCategory.sightseeing:
        return SightseeingForm(
          initialMetadata: _metadata,
          titleController: _titleController,
          locationController: _locationController,
          descriptionController: _descriptionController,
          priceController: _priceController,
          initialStartTime: DateTime(
            _startDate.year,
            _startDate.month,
            _startDate.day,
            _startTime.hour,
            _startTime.minute,
          ),
          initialEndTime: _endTime != null
              ? DateTime(
                  _startDate.year,
                  _startDate.month,
                  _startDate.day,
                  _endTime!.hour,
                  _endTime!.minute,
                )
              : null,
          onMetadataChanged: _updateMetadata,
          onStartTimeChanged: (dt) {
            setState(() {
              _startDate = dt;
              _startTime = TimeOfDay.fromDateTime(dt);
            });
          },
          onEndTimeChanged: (dt) {
            setState(() {
              if (dt != null) {
                _endTime = TimeOfDay.fromDateTime(dt);
              } else {
                _endTime = null;
              }
            });
          },
          onIsPaidChanged: (val) => setState(() => _isPaid = val),
        );
      case ActivityCategory.shopping:
        // Shopping logic
        return ShoppingForm(
          titleController: _titleController,
          descriptionController: _descriptionController,
          initialMetadata: _metadata,
          onMetadataChanged: _updateMetadata,
        );
      default:
        // Generic form for Accommodation, Shopping, etc.
        return GenericForm(
          onSelectDate: _selectDate,
          onSelectTime: (context) => _selectTime(context, true),
          startDate: _startDate,
          isDateVisible: widget.initialData != null,
          titleController: _titleController,
          locationController: _locationController,
          descriptionController: _descriptionController,
          initialMetadata: _metadata,
          onMetadataChanged: _updateMetadata,
        );
    }
  }
}
