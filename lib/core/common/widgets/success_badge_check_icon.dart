import 'dart:math' as math;
import 'package:flutter/material.dart';

class SuccessBadgeCheckIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const SuccessBadgeCheckIcon({
    super.key,
    this.size = 80,
    this.color = const Color(0xFF22C55E),
    this.strokeWidth = 5.5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SuccessBadgeCheckPainter(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _SuccessBadgeCheckPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _SuccessBadgeCheckPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.36;
    final waveAmplitude = size.width * 0.08;
    const int lobes = 8;

    // Build the 8-lobed scalloped badge path with opening at top-right (approx 0.15*pi to 0.45*pi in clock angle)
    final badgePath = Path();
    const double startAngle = 0.55; // Radians from top-right (opening end)
    const double endAngle = math.pi * 2 + 0.05; // Radians to top-right (opening start)
    const int segments = 120;

    bool isFirst = true;
    for (int i = 0; i <= segments; i++) {
      final t = i / segments;
      final angle = startAngle + t * (endAngle - startAngle);
      
      // Radius modulation for 8 rounded wavy crests and troughs
      final r = baseRadius + waveAmplitude * math.cos(lobes * angle);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (isFirst) {
        badgePath.moveTo(x, y);
        isFirst = false;
      } else {
        badgePath.lineTo(x, y);
      }
    }

    canvas.drawPath(badgePath, paint);

    // Draw the clean checkmark
    final checkPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkPath = Path();
    checkPath.moveTo(size.width * 0.33, size.height * 0.49);
    checkPath.lineTo(size.width * 0.47, size.height * 0.63);
    checkPath.lineTo(size.width * 0.77, size.height * 0.28);

    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _SuccessBadgeCheckPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
