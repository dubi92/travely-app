import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum PlayfulStatus {
  done,
  booked,
  planned,
}

class PlayfulStatusBadge extends StatelessWidget {
  final PlayfulStatus status;

  const PlayfulStatusBadge({super.key, required this.status});

  Color get _backgroundColor {
    switch (status) {
      case PlayfulStatus.done:
        return AppColors.statusDone.withValues(alpha: 0.2);
      case PlayfulStatus.booked:
        return AppColors.statusBooked.withValues(alpha: 0.2);
      case PlayfulStatus.planned:
        return AppColors.statusPlanned.withValues(alpha: 0.2);
    }
  }

  Color get _textColor {
    switch (status) {
      case PlayfulStatus.done:
        return Color(0xFF2E7D32); // Darker Green
      case PlayfulStatus.booked:
        return Color(0xFF0277BD); // Darker Blue
      case PlayfulStatus.planned:
        return Color(0xFFEF6C00); // Darker Orange
    }
  }

  String get _text {
    switch (status) {
      case PlayfulStatus.done:
        return 'Done';
      case PlayfulStatus.booked:
        return 'Booked';
      case PlayfulStatus.planned:
        return 'Planned';
    }
  }

  String get _emoji {
    switch (status) {
      case PlayfulStatus.done:
        return '✅';
      case PlayfulStatus.booked:
        return '🎟️';
      case PlayfulStatus.planned:
        return '📝';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _textColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            _text,
            style: AppTypography.textTheme.labelMedium?.copyWith(
              color: _textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
