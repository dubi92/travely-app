import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travely_app/core/theme/app_colors.dart';

import 'package:travely_app/shared/widgets/inputs/app_text_field.dart';

class AppDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final String placeholder;

  const AppDatePicker({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.placeholder = 'Select date',
  });

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? const ColorScheme.dark(primary: AppColors.primary)
                : const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    // We reuse AppTextField but make it read-only and handle tap
    final controller = TextEditingController(
      text: selectedDate != null ? DateFormat.yMMMd().format(selectedDate!) : '',
    );
    
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: AppTextField(
          label: label,
          placeholder: placeholder,
          controller: controller,
          suffixIcon: const Icon(Icons.calendar_today, size: 20),
        ),
      ),
    );
  }
}
