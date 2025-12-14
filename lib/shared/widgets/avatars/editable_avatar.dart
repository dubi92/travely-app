import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'app_avatar.dart';

class EditableAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final VoidCallback onEdit;
  final double size;

  const EditableAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    required this.onEdit,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppAvatar(
          imageUrl: imageUrl,
          initials: initials,
          size: size,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
