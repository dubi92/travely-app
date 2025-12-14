import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final double size;
  final bool border;

  const AppAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.size = 32,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border ? Border.all(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          width: 2,
        ) : null,
      ),
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildInitials(context),
              )
            : _buildInitials(context),
      ),
    );
  }

  Widget _buildInitials(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : AppColors.textPrimaryLight,
        ),
      ),
    );
  }
}
