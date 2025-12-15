import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../shared/widgets/inputs/app_text_field.dart';

class ShoppingForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Map<String, dynamic> initialMetadata;
  final ValueChanged<Map<String, dynamic>> onMetadataChanged;

  const ShoppingForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.initialMetadata,
    required this.onMetadataChanged,
  });

  @override
  State<ShoppingForm> createState() => _ShoppingFormState();
}

class _ShoppingFormState extends State<ShoppingForm> {
  // Items Checklist
  final List<TextEditingController> _itemControllers = [];

  // Budget
  double _budget = 0;

  // Shopping For
  final List<String> _shoppingForOptions = ['Self', 'Family', 'Friend'];
  final List<String> _selectedShoppingFor = [];

  // Tax Free
  bool _taxFreeAvailable = false;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    // Items
    if (widget.initialMetadata['items'] != null) {
      final items = List<String>.from(widget.initialMetadata['items']);
      for (var item in items) {
        _itemControllers.add(TextEditingController(text: item));
      }
    }
    // If empty, add one empty field to start
    if (_itemControllers.isEmpty) {
      _itemControllers.add(TextEditingController());
    }

    // Budget
    _budget = (widget.initialMetadata['budget'] as num?)?.toDouble() ?? 0;

    // Shopping For
    if (widget.initialMetadata['shopping_for'] != null) {
      _selectedShoppingFor
          .addAll(List<String>.from(widget.initialMetadata['shopping_for']));
    }

    // Tax Free
    _taxFreeAvailable = widget.initialMetadata['tax_free'] ?? false;

    // Listeners for items aren't needed if we update on change, but let's add listeners to text controllers
    for (var controller in _itemControllers) {
      controller.addListener(_notifyChange);
    }
  }

  @override
  void dispose() {
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _notifyChange() {
    final items = _itemControllers
        .map((c) => c.text)
        .where((text) => text.isNotEmpty)
        .toList();

    widget.onMetadataChanged({
      ...widget.initialMetadata,
      'items': items,
      'budget': _budget,
      'shopping_for': _selectedShoppingFor,
      'tax_free': _taxFreeAvailable,
    });
  }

  void _addItem() {
    setState(() {
      final controller = TextEditingController();
      controller.addListener(_notifyChange);
      _itemControllers.add(controller);
    });
  }

  void _removeItem(int index) {
    setState(() {
      final controller = _itemControllers.removeAt(index);
      controller.dispose();
    });
    _notifyChange();
  }

  void _toggleShoppingFor(String option) {
    setState(() {
      if (_selectedShoppingFor.contains(option)) {
        _selectedShoppingFor.remove(option);
      } else {
        _selectedShoppingFor.add(option);
      }
    });
    _notifyChange();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Store Name
        AppTextField(
          controller: widget.titleController,
          label: 'STORE/MARKET NAME',
          placeholder: 'e.g. Grand Bazaar',
          prefixIcon: const Icon(Icons.storefront, size: 18),
        ),
        const SizedBox(height: 24),

        // Items Checklist
        const Text(
          'ITEMS TO BUY',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.playfulTextPrimary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        ..._itemControllers.asMap().entries.map((entry) {
          final index = entry.key;
          final controller = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: controller,
                    label: '',
                    placeholder: 'Item name...',
                    prefixIcon:
                        const Icon(Icons.check_circle_outline, size: 18),
                  ),
                ),
                if (_itemControllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => _removeItem(index),
                  ),
              ],
            ),
          );
        }),
        TextButton.icon(
          onPressed: _addItem,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Item'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),

        // Estimated Budget
        const Text(
          'ESTIMATED BUDGET',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.playfulTextPrimary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                '₫${_budget.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Slider(
                value: _budget,
                min: 0,
                max: 10000000,
                divisions: 100,
                activeColor: AppColors.primary,
                inactiveColor: Colors.white,
                onChanged: (value) {
                  setState(() => _budget = value);
                  _notifyChange();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Shopping For (Chips)
        const Text(
          'SHOPPING FOR',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.playfulTextPrimary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _shoppingForOptions.map((option) {
            final isSelected = _selectedShoppingFor.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) => _toggleShoppingFor(option),
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondaryLight,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              avatar: Text(
                option == 'Self'
                    ? '👤'
                    : option == 'Family'
                        ? '👨‍👩‍👧'
                        : '👥',
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Tax Free Toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.receipt_long, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Tax-Free Available?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.playfulTextPrimary,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _taxFreeAvailable,
                onChanged: (val) {
                  setState(() => _taxFreeAvailable = val);
                  _notifyChange();
                },
                activeTrackColor: AppColors.primary,
                activeThumbColor: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Notes
        AppTextField(
          controller: widget.descriptionController,
          label: 'NOTES',
          placeholder: 'Opening hours, tips...',
          prefixIcon: const Icon(Icons.edit_note, size: 18),
          maxLines: 3,
        ),
      ],
    );
  }
}
