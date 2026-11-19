import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class EarningsChartWidget extends StatelessWidget {
  final String growthPercentage;

  const EarningsChartWidget({
    super.key,
    this.growthPercentage = '+31% this month',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product Earnings',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: Color(0xFF4CAF50),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      growthPercentage,
                      style: AppTextStyle(context).boldTextStyle(
                        color: const Color(0xFF4CAF50),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Custom Curved Chart Area
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(
              painter: _EarningsLinePainter(),
            ),
          ),
          const SizedBox(height: 10),

          // Month labels
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MonthLabel('Jan'),
              _MonthLabel('Feb'),
              _MonthLabel('Mar'),
              _MonthLabel('Apr'),
              _MonthLabel('May'),
              _MonthLabel('Jun'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthLabel extends StatelessWidget {
  final String label;
  const _MonthLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyle(context).regularTextStyle(
        color: AppColors.primarytext.withValues(alpha: 0.7),
        fontSize: 11,
      ),
    );
  }
}

class _EarningsLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Normalized sample points: [Jan, Feb, Mar, Apr, May, Jun]
    final points = [
      Offset(0, size.height * 0.75),
      Offset(size.width * 0.2, size.height * 0.65),
      Offset(size.width * 0.4, size.height * 0.7),
      Offset(size.width * 0.6, size.height * 0.35),
      Offset(size.width * 0.8, size.height * 0.4),
      Offset(size.width, size.height * 0.2),
    ];

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final midX = (p0.dx + p1.dx) / 2;
      path.cubicTo(midX, p0.dy, midX, p1.dy, p1.dx, p1.dy);
    }

    // Fill Gradient under curve
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFFF7043).withValues(alpha: 0.35),
        const Color(0xFFFF7043).withValues(alpha: 0.0),
      ],
    );

    final fillPaint = Paint()
      ..shader = fillGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Line Paint
    final linePaint = Paint()
      ..color = const Color(0xFFFF7043)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    // Draw dots at points
    final dotPaint = Paint()
      ..color = const Color(0xFFFF7043)
      ..style = PaintingStyle.fill;

    final dotBorderPaint = Paint()
      ..color = const Color(0xFF2C1A0D)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (final p in points) {
      canvas.drawCircle(p, 4, dotPaint);
      canvas.drawCircle(p, 4, dotBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
