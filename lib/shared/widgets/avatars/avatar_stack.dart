import 'package:flutter/material.dart';
import 'package:travely_app/core/theme/app_colors.dart';
import 'app_avatar.dart';

class AvatarStack extends StatelessWidget {
  final List<String> imageUrls;
  final double size;
  final int limit;

  const AvatarStack({
    super.key,
    required this.imageUrls,
    this.size = 32,
    this.limit = 3,
  });

  @override
  Widget build(BuildContext context) {
    // We only show up to 'limit' avatars.
    // However, if we have more than limit, we usually show limit-1 avatars + 1 "overflow" circle.
    // Or just show first 'limit' avatars. The design says "3 members".
    // Let's implement typical stack: overlapping.

    final visibleCount = imageUrls.length > limit ? limit - 1 : imageUrls.length;
    final remaining = imageUrls.length - visibleCount;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size,
          width: size + ((visibleCount - 1 + (remaining > 0 ? 1 : 0)) * (size * 0.7)), 
          // width calculation is tricky for overlapping.
          // Better use Stack.
          child: Stack(
            children: [
              for (int i = 0; i < visibleCount; i++)
                Positioned(
                  left: i * (size * 0.75), // overlap
                  child: AppAvatar(
                    imageUrl: imageUrls[i],
                    initials: '?',
                    size: size,
                    border: true,
                  ),
                ),
              if (remaining > 0)
                Positioned(
                  left: visibleCount * (size * 0.75),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight, // or minimal gray
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+$remaining',
                      style: TextStyle(
                        fontSize: size * 0.35,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
