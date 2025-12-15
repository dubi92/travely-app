import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DecorativeBackground extends StatelessWidget {
  const DecorativeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.bgGradientStart,
                  AppColors.bgGradientEnd,
                ],
              ),
            ),
          ),
          // Cloud 1 - Top Left
          const Positioned(
            top: 40,
            left: -20,
            child: _Cloud(width: 150, height: 80, opacity: 0.4),
          ),
          // Cloud 2 - Top Right
          const Positioned(
            top: 100,
            right: -40,
            child: _Cloud(width: 200, height: 100, opacity: 0.3),
          ),
          // Cloud 3 - Bottom Left
          const Positioned(
            bottom: 150,
            left: -30,
            child: _Cloud(width: 180, height: 90, opacity: 0.2),
          ),
          // Star 1
          const Positioned(
            top: 120,
            left: 50,
            child: _Star(),
          ),
          // Star 2
          const Positioned(
            top: 60,
            right: 80,
            child: _Star(scale: 0.7),
          ),
          // Star 3
          const Positioned(
            bottom: 200,
            right: 40,
            child: _Star(scale: 0.8),
          ),
        ],
      ),
    );
  }
}

class _Cloud extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;

  const _Cloud({
    required this.width,
    required this.height,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(width / 2),
      ),
    );
  }
}

class _Star extends StatelessWidget {
  final double scale;

  const _Star({this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: const Icon(
        Icons.star_rounded,
        color: AppColors.accentYellow,
        size: 24,
      ),
    );
  }
}
