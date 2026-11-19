import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class SellerRevenueChart extends StatefulWidget {
  const SellerRevenueChart({super.key});

  @override
  State<SellerRevenueChart> createState() => _SellerRevenueChartState();
}

class _SellerRevenueChartState extends State<SellerRevenueChart> {
  String _selectedFilter = 'Monthly'; // 'Monthly' or 'Weekly'
  int _selectedIndex = 1; // Default selected index (Feb / 11-15)

  final List<String> _monthlyLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final List<double> _monthlyData = [80000, 165000, 110000, 140000, 190000, 234500];

  final List<String> _weeklyLabels = ['1-5', '6-10', '11-15', '16-20', '21-25', '26-30'];
  final List<double> _weeklyData = [45000, 95000, 165000, 120000, 180000, 210000];

  List<String> get _currentLabels =>
      _selectedFilter == 'Monthly' ? _monthlyLabels : _weeklyLabels;
  List<double> get _currentData =>
      _selectedFilter == 'Monthly' ? _monthlyData : _weeklyData;

  @override
  Widget build(BuildContext context) {
    final currentVal = _currentData[_selectedIndex];
    final formattedVal = 'UGX ${currentVal.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF22140A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Earning Analytics + Filter Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Earning Analytics',
                style: AppTextStyle(context).boldTextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedFilter,
                    dropdownColor: const Color(0xFF22140A),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primarytext,
                      size: 16,
                    ),
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 11,
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
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedFilter = val;
                          _selectedIndex = 2;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Custom Chart Canvas
          SizedBox(
            height: 160,
            child: GestureDetector(
              onTapDown: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final localPos = details.localPosition;
                final width = box.size.width - 32 - 40; // minus padding and Y-axis
                if (width > 0) {
                  final segmentWidth = width / (_currentData.length - 1);
                  final clickedIdx = ((localPos.dx - 40) / segmentWidth)
                      .round()
                      .clamp(0, _currentData.length - 1);
                  setState(() {
                    _selectedIndex = clickedIdx;
                  });
                }
              },
              child: CustomPaint(
                size: const Size(double.infinity, 160),
                painter: _SmoothBezierChartPainter(
                  data: _currentData,
                  labels: _currentLabels,
                  selectedIndex: _selectedIndex,
                  tooltipText: formattedVal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmoothBezierChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;
  final int selectedIndex;
  final String tooltipText;

  _SmoothBezierChartPainter({
    required this.data,
    required this.labels,
    required this.selectedIndex,
    required this.tooltipText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double leftMargin = 38.0;
    const double bottomMargin = 22.0;
    const double topMargin = 32.0;

    final double chartWidth = size.width - leftMargin;
    final double chartHeight = size.height - bottomMargin - topMargin;

    final double maxVal = 250000;
    final double minVal = 0;

    // Draw Y Axis grid lines & labels
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    final textStyle = TextStyle(
      color: AppColors.primarytext.withValues(alpha: 0.5),
      fontSize: 9,
    );

    const int yDivisions = 4;
    for (int i = 0; i <= yDivisions; i++) {
      final double y = topMargin + chartHeight - (i * chartHeight / yDivisions);
      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width, y),
        gridPaint,
      );

      final valLabel = '${(i * 50)}k';
      final textSpan = TextSpan(text: valLabel, style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(leftMargin - textPainter.width - 6, y - 6),
      );
    }

    if (data.isEmpty) return;

    // Calculate Points
    final List<Offset> points = [];
    final double stepX = chartWidth / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final double x = leftMargin + (i * stepX);
      final double normalizedY = (data[i] - minVal) / (maxVal - minVal);
      final double y = topMargin + chartHeight - (normalizedY * chartHeight);
      points.add(Offset(x, y));
    }

    // Build Smooth Bezier Path
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

    // Draw Gradient Area below path
    final Path fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, topMargin + chartHeight);
    fillPath.lineTo(points.first.dx, topMargin + chartHeight);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFE68A3D).withValues(alpha: 0.35),
          const Color(0xFFE68A3D).withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromLTWH(leftMargin, topMargin, chartWidth, chartHeight),
      );

    canvas.drawPath(fillPath, fillPaint);

    // Draw Stroke Line
    final linePaint = Paint()
      ..color = const Color(0xFFF5A623)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    // Draw X Axis labels
    for (int i = 0; i < labels.length; i++) {
      final x = points[i].dx;
      final textSpan = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: i == selectedIndex
              ? Colors.white
              : AppColors.primarytext.withValues(alpha: 0.6),
          fontSize: 10,
          fontWeight: i == selectedIndex ? FontWeight.bold : FontWeight.normal,
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

    // Draw Selected Point & Tooltip
    if (selectedIndex >= 0 && selectedIndex < points.length) {
      final selectedPoint = points[selectedIndex];

      // Dotted Vertical Line
      final dashedLinePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..strokeWidth = 1;

      double startY = selectedPoint.dy;
      final double endY = topMargin + chartHeight;
      while (startY < endY) {
        canvas.drawLine(
          Offset(selectedPoint.dx, startY),
          Offset(selectedPoint.dx, (startY + 4).clamp(0, endY)),
          dashedLinePaint,
        );
        startY += 7;
      }

      // Outer Glow circle
      canvas.drawCircle(
        selectedPoint,
        7,
        Paint()..color = const Color(0xFF00B4D8).withValues(alpha: 0.3),
      );

      // Point Circle
      canvas.drawCircle(
        selectedPoint,
        4,
        Paint()..color = Colors.white,
      );

      // Tooltip Pill
      final tooltipTextSpan = TextSpan(
        text: tooltipText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );
      final tooltipPainter = TextPainter(
        text: tooltipTextSpan,
        textDirection: TextDirection.ltr,
      );
      tooltipPainter.layout();

      const double hPad = 8.0;
      const double vPad = 4.0;
      final double pillWidth = tooltipPainter.width + (hPad * 2);
      final double pillHeight = tooltipPainter.height + (vPad * 2);

      double pillX = selectedPoint.dx - (pillWidth / 2);
      // Keep inside bounds
      pillX = pillX.clamp(leftMargin, size.width - pillWidth);
      final double pillY = selectedPoint.dy - pillHeight - 10;

      final RRect pillRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(pillX, pillY, pillWidth, pillHeight),
        const Radius.circular(8),
      );

      // Pill Background
      canvas.drawRRect(
        pillRRect,
        Paint()..color = const Color(0xFF1B3B3B),
      );
      // Pill Border
      canvas.drawRRect(
        pillRRect,
        Paint()
          ..color = const Color(0xFF00B4D8).withValues(alpha: 0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

      // Paint Tooltip Text
      tooltipPainter.paint(
        canvas,
        Offset(pillX + hPad, pillY + vPad),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SmoothBezierChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.data != data ||
        oldDelegate.selectedFilter != selectedFilter;
  }

  String get selectedFilter => labels.contains('Jan') ? 'Monthly' : 'Weekly';
}
