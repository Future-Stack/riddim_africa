import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class DashedUploadContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String? fileName;
  final VoidCallback? onRemoveFile;

  const DashedUploadContainer({
    super.key,
    required this.onTap,
    this.fileName,
    this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null && fileName!.isNotEmpty;

    return GestureDetector(
      onTap: hasFile ? null : onTap,
      child: CustomPaint(
        painter: _DashedRectPainter(
          color: hasFile
              ? const Color(0xFF24A61E)
              : AppColors.primarytext.withValues(alpha: 0.35),
          strokeWidth: 1.5,
          gap: 5.0,
          dash: 6.0,
          radius: 14.0,
        ),
        child: Container(
          width: double.infinity,
          height: 180,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: hasFile
                ? AppColors.primaryappbrown
                : AppColors.primaryappbrown.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(14),
          ),
          child: hasFile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF24A61E).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.document_text,
                        color: Color(0xFF24A61E),
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fileName!,
                      style: AppTextStyle(context).semiBoldTextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: onRemoveFile,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.close,
                            color: Color(0xFFD35446),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Remove File',
                            style: AppTextStyle(context).mediumTextStyle(
                              color: const Color(0xFFD35446),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Upload tray / tray icon
                    const Icon(
                      Icons.file_upload_outlined,
                      size: 38,
                      color: Color(0xFF6B7D8E),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Please upload your document\nin JPEG/ PDF.',
                      textAlign: TextAlign.center,
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 14,
                        lineHeight: 1.4,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;
  final double radius;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.gap = 5.0,
    this.dash = 6.0,
    this.radius = 14.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final Path dashedPath = _createDashedPath(path, dash, gap);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, double dashLength, double dashGap) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double length = draw ? dashLength : dashGap;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dash != dash;
  }
}
