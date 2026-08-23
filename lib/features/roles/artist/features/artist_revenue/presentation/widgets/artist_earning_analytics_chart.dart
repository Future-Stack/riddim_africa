import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_revenue_entity.dart';
import '../controllers/artist_revenue_controller.dart';

class ArtistEarningAnalyticsChart extends StatelessWidget {
  final ArtistRevenueController controller;

  const ArtistEarningAnalyticsChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.cardBorder.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header: Title & Dropdown Filter ─────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Earning Analytics',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
              ),
              Obx(
                () => Container(
                  height: 32.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedFilter.value,
                      dropdownColor: AppColors.primaryappbrown,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primarytext,
                        size: 18.sp,
                      ),
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12.sp,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Weekly',
                          child: Text('Weekly'),
                        ),
                        DropdownMenuItem(
                          value: 'Monthly',
                          child: Text('Monthly'),
                        ),
                        DropdownMenuItem(
                          value: 'Yearly',
                          child: Text('Yearly'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          controller.setFilter(val);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,

          // ─── Subheader: Date Range & Calendar Icon ───────────────────────
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  String dateRange = 'July – Dec 2026';
                  if (controller.selectedFilter.value == 'Weekly') {
                    dateRange = 'Current Month (Weekly)';
                  } else if (controller.selectedFilter.value == 'Monthly') {
                    dateRange = 'Jan – Jun 2026';
                  }
                  return Text(
                    dateRange,
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.gold,
                      fontSize: 12.sp,
                    ),
                  );
                }),
                6.horizontalSpace,
                Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.gold,
                  size: 16.sp,
                ),
              ],
            ),
          ),
          16.verticalSpace,

          // ─── Interactive Bezier Chart Canvas ─────────────────────────────
          SizedBox(
            height: 200.h,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Obx(() {
                  final dataPoints = controller.currentAnalyticsData;
                  if (dataPoints.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondary,
                      ),
                    );
                  }

                  final selectedIdx = controller.selectedChartIndex.value
                      .clamp(0, dataPoints.length - 1);

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (details) {
                      _handleTouch(details.localPosition, constraints.maxWidth,
                          dataPoints.length);
                    },
                    onHorizontalDragUpdate: (details) {
                      _handleTouch(details.localPosition, constraints.maxWidth,
                          dataPoints.length);
                    },
                    child: CustomPaint(
                      size: Size(constraints.maxWidth, 200.h),
                      painter: _ArtistBezierChartPainter(
                        dataPoints: dataPoints,
                        selectedIndex: selectedIdx,
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleTouch(Offset localPos, double totalWidth, int count) {
    const double leftMargin = 55.0;
    final double chartWidth = totalWidth - leftMargin - 16.0;
    if (chartWidth > 0 && count > 1) {
      final double step = chartWidth / (count - 1);
      final int idx = ((localPos.dx - leftMargin) / step)
          .round()
          .clamp(0, count - 1);
      controller.selectChartIndex(idx);
    }
  }
}

class _ArtistBezierChartPainter extends CustomPainter {
  final List<ChartDataPoint> dataPoints;
  final int selectedIndex;

  _ArtistBezierChartPainter({
    required this.dataPoints,
    required this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double leftMargin = 55.0;
    const double rightMargin = 16.0;
    const double bottomMargin = 26.0;
    const double topMargin = 40.0;

    final double chartWidth = size.width - leftMargin - rightMargin;
    final double chartHeight = size.height - bottomMargin - topMargin;

    if (dataPoints.isEmpty || chartWidth <= 0 || chartHeight <= 0) return;

    // Find min and max values
    double maxVal = 400000;
    for (var dp in dataPoints) {
      if (dp.value > maxVal) maxVal = dp.value;
    }
    maxVal = (maxVal * 1.15).ceilToDouble();
    const double minVal = 0;

    // ─── 1. Draw Y-Axis Dotted Gridlines & Labels ─────────────────────────
    final dottedPaint = Paint()
      ..color = AppColors.cardBorder.withValues(alpha: 0.35)
      ..strokeWidth = 1;

    final yTextStyle = TextStyle(
      color: AppColors.primarytext.withValues(alpha: 0.6),
      fontSize: 10,
      fontFamily: 'Satoshi',
    );

    const int divisions = 4;
    for (int i = 0; i <= divisions; i++) {
      final double y = topMargin + chartHeight - (i * chartHeight / divisions);

      // Draw dotted horizontal line
      double startX = leftMargin;
      final double endX = size.width - rightMargin;
      while (startX < endX) {
        canvas.drawLine(
          Offset(startX, y),
          Offset((startX + 3).clamp(leftMargin, endX), y),
          dottedPaint,
        );
        startX += 6;
      }

      // Draw label e.g. "UGX 0.8M"
      final double val = minVal + (i * (maxVal - minVal) / divisions);
      String labelText = 'UGX ${(val / 1000000).toStringAsFixed(1)}M';
      if (maxVal < 1000000) {
        labelText = 'UGX ${(val / 1000).toInt()}k';
      }

      final textSpan = TextSpan(text: labelText, style: yTextStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(leftMargin - textPainter.width - 8, y - 6),
      );
    }

    // ─── 2. Compute Points ───────────────────────────────────────────────
    final List<Offset> points = [];
    final double stepX = chartWidth / (dataPoints.length - 1);

    for (int i = 0; i < dataPoints.length; i++) {
      final double x = leftMargin + (i * stepX);
      final double normalizedY = (dataPoints[i].value - minVal) / (maxVal - minVal);
      final double y = topMargin + chartHeight - (normalizedY * chartHeight);
      points.add(Offset(x, y));
    }

    // ─── 3. Build Smooth Bezier Path ─────────────────────────────────────
    final Path path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    // ─── 4. Draw Gradient Glow Fill below path ───────────────────────────
    final Path fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, topMargin + chartHeight);
    fillPath.lineTo(points.first.dx, topMargin + chartHeight);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gold.withValues(alpha: 0.28),
          AppColors.gold.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromLTWH(leftMargin, topMargin, chartWidth, chartHeight),
      );

    canvas.drawPath(fillPath, fillPaint);

    // ─── 5. Draw Bezier Stroke Line ──────────────────────────────────────
    final linePaint = Paint()
      ..color = AppColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    // ─── 6. Draw X-Axis Labels ───────────────────────────────────────────
    for (int i = 0; i < dataPoints.length; i++) {
      final x = points[i].dx;
      final isSelected = i == selectedIndex;

      final textSpan = TextSpan(
        text: dataPoints[i].label,
        style: TextStyle(
          color: isSelected
              ? AppColors.white
              : AppColors.primarytext.withValues(alpha: 0.7),
          fontSize: 11,
          fontFamily: 'Satoshi',
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - (textPainter.width / 2), size.height - bottomMargin + 6),
      );
    }

    // ─── 7. Draw Selected Point Guideline, Dot, and Tooltip Box ──────────
    if (selectedIndex >= 0 && selectedIndex < points.length) {
      final selectedPoint = points[selectedIndex];
      final currentPoint = dataPoints[selectedIndex];

      // Vertical guideline
      final verticalLinePaint = Paint()
        ..color = AppColors.white.withValues(alpha: 0.85)
        ..strokeWidth = 1.2;

      canvas.drawLine(
        Offset(selectedPoint.dx, topMargin),
        Offset(selectedPoint.dx, topMargin + chartHeight),
        verticalLinePaint,
      );

      // Glowing circle at curve point
      canvas.drawCircle(
        selectedPoint,
        7,
        Paint()..color = AppColors.greenBright.withValues(alpha: 0.25),
      );
      canvas.drawCircle(
        selectedPoint,
        4.5,
        Paint()..color = AppColors.white,
      );

      // ─── Floating Tooltip Card ────────────────────────────────────────
      final currencyFormatter = NumberFormat('#,##0', 'en_US');
      final formattedAmount =
          '+UGX ${currencyFormatter.format(currentPoint.value)}';

      // Tooltip line 1: Date Subtitle
      final subtitlePainter = TextPainter(
        text: TextSpan(
          text: currentPoint.dateSubtitle.isNotEmpty
              ? currentPoint.dateSubtitle
              : '${currentPoint.label} 2026',
          style: TextStyle(
            color: AppColors.white.withValues(alpha: 0.7),
            fontSize: 10,
            fontFamily: 'Satoshi',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Tooltip line 2: Growth %
      final growthPainter = TextPainter(
        text: TextSpan(
          text: '↗ ${currentPoint.percentageChange}',
          style: const TextStyle(
            color: AppColors.greenBright,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satoshi',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Tooltip line 3: Formatted Amount
      final amountPainter = TextPainter(
        text: TextSpan(
          text: formattedAmount,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satoshi',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      const double hPadding = 12.0;
      const double vPadding = 10.0;

      final double maxLineWidth = [
        subtitlePainter.width,
        growthPainter.width,
        amountPainter.width,
      ].reduce((a, b) => a > b ? a : b);

      final double boxWidth = maxLineWidth + (hPadding * 2);
      final double boxHeight = subtitlePainter.height +
          growthPainter.height +
          amountPainter.height +
          (vPadding * 2) +
          6.0;

      double boxX = selectedPoint.dx - (boxWidth / 2);
      boxX = boxX.clamp(leftMargin, size.width - rightMargin - boxWidth);

      double boxY = selectedPoint.dy - boxHeight - 12;
      if (boxY < 0) {
        boxY = selectedPoint.dy + 12;
      }

      final RRect boxRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(boxX, boxY, boxWidth, boxHeight),
        const Radius.circular(10),
      );

      // Draw dark teal card background
      canvas.drawRRect(
        boxRRect,
        Paint()..color = AppColors.tealDarkBg,
      );

      // Draw dark teal card border
      canvas.drawRRect(
        boxRRect,
        Paint()
          ..color = AppColors.tealBorder
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

      // Paint Lines
      double currentY = boxY + vPadding;
      subtitlePainter.paint(canvas, Offset(boxX + hPadding, currentY));
      currentY += subtitlePainter.height + 2;

      growthPainter.paint(canvas, Offset(boxX + hPadding, currentY));
      currentY += growthPainter.height + 4;

      amountPainter.paint(canvas, Offset(boxX + hPadding, currentY));
    }
  }

  @override
  bool shouldRepaint(covariant _ArtistBezierChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.dataPoints != dataPoints;
  }
}
