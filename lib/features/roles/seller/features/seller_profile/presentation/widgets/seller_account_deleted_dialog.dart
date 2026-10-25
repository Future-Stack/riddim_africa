import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class SellerAccountDeletedDialog extends StatelessWidget {
  const SellerAccountDeletedDialog({super.key});

  static void show([BuildContext? context]) {
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const SellerAccountDeletedDialog(),
      );
    } else {
      Get.dialog(
        const SellerAccountDeletedDialog(),
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Auto redirect after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () async {
      await StorageService.logoutUser();
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.offAllNamed(AppRoute.welcomescreen);
    });

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2B170C),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Scalloped Badge with Red Checkmark
            SizedBox(
              width: 84.w,
              height: 84.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(84.w, 84.w),
                    painter: _ScallopedBadgePainter(
                      color: const Color(0xFFF8A59C),
                      strokeWidth: 3.5,
                    ),
                  ),
                  Icon(
                    Icons.check_rounded,
                    color: const Color(0xFFE53935),
                    size: 42.sp,
                  ),
                ],
              ),
            ),
            20.verticalSpace,

            // Title
            Text(
              'Account Deleted Successfully',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).boldTextStyle(
                fontSize: 17.sp,
                color: Colors.white,
              ),
            ),
            10.verticalSpace,

            // Subtitle
            Text(
              'Your account and associated data have\nbeen permanently removed.',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 12.sp,
                color: AppColors.primarytext,
                lineHeight: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Scalloped / Starburst Badge Painter ──────────────────────────────────────
class _ScallopedBadgePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _ScallopedBadgePainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width * 0.42;

    final Path path = Path();
    const int count = 8;
    for (int i = 0; i < count; i++) {
      final double angle = (i * 2 * math.pi) / count;
      final double nextAngle = ((i + 1) * 2 * math.pi) / count;
      final double midAngle = (angle + nextAngle) / 2;

      final double x1 = cx + r * 0.82 * math.cos(angle);
      final double y1 = cy + r * 0.82 * math.sin(angle);
      final double cxPeak = cx + r * 1.15 * math.cos(midAngle);
      final double cyPeak = cy + r * 1.15 * math.sin(midAngle);
      final double x2 = cx + r * 0.82 * math.cos(nextAngle);
      final double y2 = cy + r * 0.82 * math.sin(nextAngle);

      if (i == 0) {
        path.moveTo(x1, y1);
      }
      path.quadraticBezierTo(cxPeak, cyPeak, x2, y2);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ScallopedBadgePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
