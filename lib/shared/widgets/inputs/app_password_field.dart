import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'app_text_field.dart';

class AppPasswordField extends StatefulWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const AppPasswordField({
    super.key,
    required this.label,
    this.placeholder,
    this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppTextField(
      label: widget.label,
      placeholder: widget.placeholder,
      controller: widget.controller,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      errorText: widget.errorText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
