import 'package:flutter/material.dart';

enum MascotType {
  standard,
  balloon,
}

class FloatingMascot extends StatefulWidget {
  final MascotType type;
  final String? emoji; // Override default emoji
  final double size;

  const FloatingMascot({
    super.key,
    this.type = MascotType.standard,
    this.emoji,
    this.size = 80,
  });

  @override
  State<FloatingMascot> createState() => _FloatingMascotState();
}

class _FloatingMascotState extends State<FloatingMascot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: _buildMascot(),
    );
  }

  Widget _buildMascot() {
    final String emoji =
        widget.emoji ?? (widget.type == MascotType.balloon ? '🎈' : '✈️');

    return Text(
      emoji,
      style: TextStyle(fontSize: widget.size),
    );
  }
}
