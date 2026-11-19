import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/artist_document_model.dart';

class ArtistDocumentDetailController extends GetxController {
  final Map<String, Rx<File?>> customFiles = {};
  final ImagePicker _picker = ImagePicker();

  Rx<File?> getFileFor(String side) {
    if (!customFiles.containsKey(side)) {
      customFiles[side] = Rx<File?>(null);
    }
    return customFiles[side]!;
  }

  Future<void> pickFileFor(String side, ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      if (file != null) {
        getFileFor(side).value = File(file.path);
      }
    } catch (e) {
      Get.snackbar(
        'Selection Failed',
        'Could not access image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
      );
    }
  }

  void showPickerOptions(BuildContext context, String side) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF22140A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              16.verticalSpace,
              Text(
                'Upload $side',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPickerOption(
                    context: context,
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    onTap: () {
                      Get.back();
                      pickFileFor(side, ImageSource.camera);
                    },
                  ),
                  _buildPickerOption(
                    context: context,
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () {
                      Get.back();
                      pickFileFor(side, ImageSource.gallery);
                    },
                  ),
                  if (getFileFor(side).value != null)
                    _buildPickerOption(
                      context: context,
                      icon: Icons.delete_outline_rounded,
                      label: 'Remove',
                      iconColor: Colors.redAccent,
                      onTap: () {
                        Get.back();
                        getFileFor(side).value = null;
                      },
                    ),
                ],
              ),
              12.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: const Color(0xFF161E28),
              shape: BoxShape.circle,
              border: Border.all(
                color: (iconColor ?? const Color(0xFF35C0AD))
                    .withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              icon,
              color: iconColor ?? const Color(0xFF35C0AD),
              size: 24.sp,
            ),
          ),
          8.verticalSpace,
          Text(
            label,
            style: AppTextStyle(context).mediumTextStyle(
              fontSize: 12.sp,
              color: AppColors.primarytext,
            ),
          ),
        ],
      ),
    );
  }
}

class ArtistDocumentDetailScreen extends StatelessWidget {
  final ArtistDocumentModel document;

  const ArtistDocumentDetailScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArtistDocumentDetailController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: GlobalAppBar(
        title: 'Documents - ${document.title}',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Green Verified Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF14301B),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFF34C759).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B4324),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: const Color(0xFF34C759),
                        size: 20.sp,
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Verified',
                                style: AppTextStyle(context).boldTextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF23542D),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'Verified',
                                  style: TextStyle(
                                    color: const Color(0xFF34C759),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          4.verticalSpace,
                          Text(
                            'Your identity has been successfully verified by the Riddim Africa verification team.',
                            style: AppTextStyle(context).regularTextStyle(
                              fontSize: 12.sp,
                              color: AppColors.primarytext,
                              lineHeight: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // Document Side Previews (Dotted / Dashed Boxes)
              ...document.items.map((item) {
                final String sideLabel = item.title.contains('Front')
                    ? 'Front Part'
                    : (item.title.contains('Back')
                        ? 'Back Part'
                        : item.title);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sideLabel,
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                    10.verticalSpace,
                    GestureDetector(
                      onTap: () =>
                          controller.showPickerOptions(context, sideLabel),
                      child: Obx(() {
                        final file =
                            controller.getFileFor(sideLabel).value;

                        return CustomPaint(
                          painter: DottedRRectPainter(
                            color: const Color(0xFFD49B53)
                                .withValues(alpha: 0.5),
                            strokeWidth: 1.2,
                            gap: 5.0,
                            radius: 14.r,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 160.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF161E28),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: file != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(14.r),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Image.file(
                                            file,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10.h,
                                          right: 10.w,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black87,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Text(
                                              'Change',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 46.w,
                                        height: 46.w,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF22140A),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFD49B53)
                                                .withValues(alpha: 0.3),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.credit_card_outlined,
                                          color: const Color(0xFFD49B53),
                                          size: 22.sp,
                                        ),
                                      ),
                                      12.verticalSpace,
                                      Text(
                                        'Upload National ID $sideLabel',
                                        style: AppTextStyle(context)
                                            .mediumTextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        'Supported formats: JPG, PNG, PDF',
                                        style: AppTextStyle(context)
                                            .regularTextStyle(
                                          fontSize: 11.sp,
                                          color: AppColors.primarytext,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      }),
                    ),
                    20.verticalSpace,
                  ],
                );
              }),
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
    this.radius = 14.0,
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
