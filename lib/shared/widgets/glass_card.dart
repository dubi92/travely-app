import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';

enum GlassCardVariant {
  mint,
  peach,
  light,
}

class GlassmorphismCard extends StatefulWidget {
  final Widget child;
  final GlassCardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const GlassmorphismCard({
    super.key,
    required this.child,
    this.variant = GlassCardVariant.light,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  State<GlassmorphismCard> createState() => _GlassmorphismCardState();
}

class _GlassmorphismCardState extends State<GlassmorphismCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    switch (widget.variant) {
      case GlassCardVariant.mint:
        return AppColors.cardMint.withValues(alpha: 0.6);
      case GlassCardVariant.peach:
        return AppColors.cardPeach.withValues(alpha: 0.6);
      case GlassCardVariant.light:
        return AppColors.cardLight.withValues(alpha: 0.6);
    }
  }

  Color get _borderColor {
    return Colors.white.withValues(alpha: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: ClipRRect(
            borderRadius: AppRadius.roundedLG,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: AppRadius.roundedLG,
                  border: Border.all(color: _borderColor, width: 1.5),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          )
                        ]
                      : [],
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
