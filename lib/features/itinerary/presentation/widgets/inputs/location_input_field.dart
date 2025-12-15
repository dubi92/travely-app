import 'package:flutter/material.dart';
import '../../../../../../shared/widgets/inputs/app_text_field.dart';

class LocationInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final VoidCallback? onMapTap;

  const LocationInputField({
    super.key,
    required this.controller,
    this.label = 'LOCATION',
    this.placeholder = 'Pick a location',
    this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      placeholder: placeholder,
      prefixIcon: const Icon(Icons.location_on_outlined, size: 18),
      suffixIcon: IconButton(
        icon: const Icon(Icons.map_outlined),
        onPressed: onMapTap,
        tooltip: 'Open Map',
      ),
    );
  }
}
