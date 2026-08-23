import 'package:flutter/material.dart';

class ArtistDocumentCornerFrame extends StatelessWidget {
  final Widget child;
  final double cornerLength;
  final Color cornerColor;
  final double strokeWidth;
  final EdgeInsetsGeometry padding;

  const ArtistDocumentCornerFrame({
    super.key,
    required this.child,
    this.cornerLength = 28.0,
    this.cornerColor = const Color(0xFF655042),
    this.strokeWidth = 1.8,
    this.padding = const EdgeInsets.all(12.0),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedCornerBracketsPainter(
        cornerLength: cornerLength,
        color: cornerColor,
        strokeWidth: strokeWidth,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _DashedCornerBracketsPainter extends CustomPainter {
  final double cornerLength;
  final Color color;
  final double strokeWidth;
  final double dashLength = 4.0;
  final double dashGap = 3.0;

  _DashedCornerBracketsPainter({
    required this.cornerLength,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Top-Left Corner
    _drawDashedLine(canvas, paint, const Offset(0, 0), Offset(cornerLength, 0));
    _drawDashedLine(canvas, paint, const Offset(0, 0), Offset(0, cornerLength));

    // Top-Right Corner
    _drawDashedLine(canvas, paint, Offset(w, 0), Offset(w - cornerLength, 0));
    _drawDashedLine(canvas, paint, Offset(w, 0), Offset(w, cornerLength));

    // Bottom-Left Corner
    _drawDashedLine(canvas, paint, Offset(0, h), Offset(cornerLength, h));
    _drawDashedLine(canvas, paint, Offset(0, h), Offset(0, h - cornerLength));

    // Bottom-Right Corner
    _drawDashedLine(canvas, paint, Offset(w, h), Offset(w - cornerLength, h));
    _drawDashedLine(canvas, paint, Offset(w, h), Offset(w, h - cornerLength));
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset p1, Offset p2) {
    final double dx = p2.dx - p1.dx;
    final double dy = p2.dy - p1.dy;
    final double distance = (p2 - p1).distance;
    final double unitX = dx / distance;
    final double unitY = dy / distance;

    double currentDist = 0.0;
    while (currentDist < distance) {
      final double nextDist = (currentDist + dashLength).clamp(0.0, distance);
      canvas.drawLine(
        Offset(p1.dx + unitX * currentDist, p1.dy + unitY * currentDist),
        Offset(p1.dx + unitX * nextDist, p1.dy + unitY * nextDist),
        paint,
      );
      currentDist += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCornerBracketsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.cornerLength != cornerLength;
  }
}
