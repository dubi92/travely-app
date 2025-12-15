import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/destination_map_picker.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/models/trip_model.dart';
import '../providers/trip_provider.dart';

class CreateTripStep1Screen extends ConsumerStatefulWidget {
  const CreateTripStep1Screen({super.key});

  @override
  ConsumerState<CreateTripStep1Screen> createState() =>
      _CreateTripStep1ScreenState();
}

class _CreateTripStep1ScreenState extends ConsumerState<CreateTripStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _destinationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _budgetController = TextEditingController();
  final _dailyLimitController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    // Load draft if available
    final draft = ref.read(createTripDraftProvider);
    if (draft['name'] != null) _nameController.text = draft['name'];
    if (draft['destination'] != null)
      _destinationController.text = draft['destination'];
    if (draft['start_date'] != null) {
      _startDate = draft['start_date'] as DateTime;
      _startDateController.text = _dateFormat.format(_startDate!);
    }
    if (draft['end_date'] != null) {
      _endDate = draft['end_date'] as DateTime;
      _endDateController.text = _dateFormat.format(_endDate!);
    }
    if (draft['cover_image_path'] != null) {
      _selectedImagePath = draft['cover_image_path'] as String;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _destinationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _budgetController.dispose();
    _dailyLimitController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = now;
    final lastDate = now.add(const Duration(days: 365 * 2));

    final initialDateRange = (_startDate != null && _endDate != null)
        ? DateTimeRange(start: _startDate!, end: _endDate!)
        : null;

    final pickedRange = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: initialDateRange,
      builder: (context, child) {
        // Force Light Theme to ensure clean contrast
        return Theme(
          data: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Theme.of(context).primaryColor,
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
              primaryContainer: Theme.of(context).primaryColor.withOpacity(0.2),
              onPrimaryContainer: Colors.black,
            ),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: Theme.of(context).primaryColor,
              headerForegroundColor: Colors.white,
              rangeSelectionOverlayColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor.withOpacity(0.2),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        _startDate = pickedRange.start;
        _endDate = pickedRange.end;
        _startDateController.text = _dateFormat.format(_startDate!);
        _endDateController.text = _dateFormat.format(_endDate!);
      });
    }
  }

  Future<void> _onCreateTrip() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select valid dates')),
      );
      return;
    }

    final user = ref.read(currentUserProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to create a trip')),
      );
      return;
    }

    // Parse budget
    final overallBudget = double.tryParse(_budgetController.text);
    final dailyLimit = double.tryParse(_dailyLimitController.text);

    // Create Trip Object
    final newTrip = Trip(
      id: '', // Generated by DB
      name: _nameController.text,
      destination: _destinationController
          .text, // Note: Model needs update if destination isn't top-level
      startDate: _startDate!,
      endDate: _endDate!,
      defaultCurrency: 'USD',
      overallBudget: overallBudget,
      dailyLimit: dailyLimit,
      travelPace: 'balanced',
      createdBy: user.id,
      status: 'planning',
    );

    try {
      final tripController = ref.read(userTripsProvider.notifier);
      final tripRepo = ref.read(tripRepositoryProvider);

      // 1. Create Trip
      final createdTrip = await tripController.createTrip(newTrip);

      // 2. Upload Cover Image (if selected)
      if (_selectedImagePath != null) {
        final imageUrl =
            await tripRepo.uploadTripCover(createdTrip.id, _selectedImagePath!);

        // 3. Update Trip with Image URL
        final updatedTrip = createdTrip.copyWith(coverImageUrl: imageUrl);
        await tripController.updateTrip(updatedTrip);
      }

      // Clear draft
      ref.read(createTripDraftProvider.notifier).state = {};

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create trip: $e')),
        );
      }
    }
  }

  Future<void> _openMapPicker() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const DestinationMapPicker()),
    );

    if (result != null && result is String) {
      setState(() {
        _destinationController.text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Create Trip'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trip Details',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start your adventure! Where are you going?',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 32),

                    // Cover Photo Picker
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                            image: _selectedImagePath != null
                                ? DecorationImage(
                                    image: FileImage(File(_selectedImagePath!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.3)),
                          ),
                          child: _selectedImagePath == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate,
                                        size: 40,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(height: 8),
                                    Text('Add Cover Photo',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ],
                                )
                              : Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.white),
                                    style: IconButton.styleFrom(
                                        backgroundColor: Colors.black54),
                                    onPressed: _pickImage,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Trip Name
                    Text('Trip name',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Summer Vacation 2024',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.3),
                        suffixIcon: const Icon(Icons.edit, color: Colors.grey),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a name'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Destination
                    Text('Destination',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _destinationController,
                      readOnly: false, // Allow typing
                      // onTap: _openMapPicker, // Removed to allow typing
                      decoration: InputDecoration(
                        hintText: 'Enter destination or pick on map',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.3),
                        prefixIcon: Icon(Icons.location_on,
                            color: Theme.of(context).primaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.map,
                              color: Theme.of(context).primaryColor),
                          onPressed: _openMapPicker, // Open map on icon click
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please select a destination'
                          : null,
                    ),
                    TextButton.icon(
                      onPressed: () {}, // Future feature
                      icon: const Icon(Icons.add),
                      label: const Text('Add another destination'),
                    ),
                    const SizedBox(height: 24),

                    // Dates
                    Text('Dates',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDateRange(context),
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: _startDateController,
                                decoration: InputDecoration(
                                  hintText: 'Start',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withValues(alpha: 0.3),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.arrow_forward,
                              color: Colors.grey, size: 16),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDateRange(context),
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: _endDateController,
                                decoration: InputDecoration(
                                  hintText: 'End',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withValues(alpha: 0.3),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Budget Section
                    Text('Budget (Optional)',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _budgetController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Total Budget',
                              prefixIcon: const Icon(Icons.attach_money,
                                  color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _dailyLimitController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Daily Limit',
                              prefixIcon:
                                  const Icon(Icons.savings, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: _onCreateTrip,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 8),
                    Text('Create Trip'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
