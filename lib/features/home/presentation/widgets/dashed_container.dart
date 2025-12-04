import 'package:flutter/material.dart';

class DashedContainer extends StatelessWidget {
  final Widget child;
  const DashedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 6;
    double dashSpace = 4;

    final paint = Paint()
      ..color = const Color(0xFFB0B0B0)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(12),
    );

    final path = Path()..addRRect(rect);

    // Create dashed effect
    for (final pathMetric in path.computeMetrics()) {
      double distance = 0;
      while (distance < pathMetric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(pathMetric.extractPath(distance, next), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
