import 'package:flutter/material.dart';

class AnimatedAuthWidget extends StatefulWidget {
  final Widget child;
  final int delay;

  const AnimatedAuthWidget({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<AnimatedAuthWidget> createState() => _AnimatedAuthWidgetState();
}

class _AnimatedAuthWidgetState extends State<AnimatedAuthWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve:
          Curves.easeOut, // make the transition start quickly and ends slowly
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(curve);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
