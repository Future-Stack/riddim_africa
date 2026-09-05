import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../controllers/artist_verification_controller.dart';
import '../widgets/artist_verification_success_dialog.dart';

class ArtistVerificationBadgeScreen extends StatelessWidget {
  const ArtistVerificationBadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistVerificationController>()
        ? Get.find<ArtistVerificationController>()
        : Get.put(ArtistVerificationController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Documents',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.verticalSpace,

              // Top Document Badge Icon
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF2B170C),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFD49B53).withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.description_outlined,
                    color: const Color(0xFFD49B53),
                    size: 26.sp,
                  ),
                ),
              ),
              18.verticalSpace,

              // Title
              Text(
                'Upload Business License',
                textAlign: TextAlign.center,
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
              10.verticalSpace,

              // Subtitle with green highlighted "Verification Badge."
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primarytext,
                    lineHeight: 18,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Upload a copyright certificate or official proof showing that you hold the rights to your music, artist identity, or creative content to get ',
                    ),
                    TextSpan(
                      text: 'Verification Badge.',
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF34C759),
                      ),
                    ),
                  ],
                ),
              ),
              28.verticalSpace,

              // Upload Container (Dotted / Dashed Box)
              GestureDetector(
                onTap: () => controller.pickDocument(),
                child: Obx(
                  () => CustomPaint(
                    painter: DottedRRectPainter(
                      color: controller.selectedFileName.isNotEmpty
                          ? const Color(0xFF34C759)
                          : const Color(0xFFD49B53).withValues(alpha: 0.5),
                      strokeWidth: 1.2,
                      gap: 5.0,
                      radius: 16.r,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 36.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161E28),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            controller.selectedFileName.isNotEmpty
                                ? Icons.check_circle_outline
                                : Icons.file_upload_outlined,
                            color: controller.selectedFileName.isNotEmpty
                                ? const Color(0xFF34C759)
                                : const Color(0xFFD49B53),
                            size: 36.sp,
                          ),
                          12.verticalSpace,
                          Text(
                            controller.selectedFileName.isNotEmpty
                                ? controller.selectedFileName.value
                                : 'Please upload your document\nin JPEG/ PDF.',
                            textAlign: TextAlign.center,
                            style: AppTextStyle(context).mediumTextStyle(
                              fontSize: 13.sp,
                              color: controller.selectedFileName.isNotEmpty
                                  ? Colors.white
                                  : AppColors.primarytext,
                              lineHeight: 18,
                            ),
                          ),
                          if (controller.selectedFileName.isNotEmpty) ...[
                            8.verticalSpace,
                            GestureDetector(
                              onTap: () => controller.clearDocument(),
                              child: Text(
                                'Remove file',
                                style: AppTextStyle(context).mediumTextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Submit Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.isUploading.value
                        ? null
                        : () {
                            controller.submitVerification(() {
                              ArtistVerificationSuccessDialog.show(
                                context,
                                onClose: () => Get.back(),
                              );
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isUploading.value
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Submit',
                            style: AppTextStyle(context).boldTextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              12.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Dotted / Dashed Rounded Rectangle Painter ────────────────────────────────
class DottedRRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  DottedRRectPainter({
    required this.color,
    this.strokeWidth = 1.2,
    this.gap = 5.0,
    this.radius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final Path dashedPath = Path();
    double distance = 0.0;
    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final double length = gap;
        if (distance + length > metric.length) break;
        dashedPath.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += length + gap;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant DottedRRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.radius != radius;
  }
}
