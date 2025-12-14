import 'package:flutter/material.dart';
import 'status_badge.dart';

class CategoryBadge extends StatelessWidget {
  final String text;
  
  const CategoryBadge({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    // Reusing StatusBadge with neutral style for categories
    return StatusBadge(text: text, type: BadgeType.neutral);
  }
}
