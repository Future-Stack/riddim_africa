import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

/// Exact upload screens adapting dynamically based on:
///   - docType: 0 (National ID), 1 (Passport), 2 (Driving License)
///   - isDocumentUpload: true (Browse PDF / JPEG) or false (Take Photo)
class SellerIdPhotoUploadScreen extends StatelessWidget {
  final int docType;
  final bool isDocumentUpload;
  final int step;

  const SellerIdPhotoUploadScreen({
    super.key,
    this.docType = 0,
    this.isDocumentUpload = false,
    this.step = 0,
  });

  String _getDocName() {
    switch (docType) {
      case 0:
        return 'National ID';
      case 1:
        return 'Passport';
      case 2:
        return 'Driving License';
      default:
        return 'Document';
    }
  }

  String _getTitle() {
    return 'Upload Your ${_getDocName()}';
  }

  String _getSubtitle() {
    if (docType == 0) {
      return 'Please upload a clear image of your ID card to help us verify your identity securely.';
    } else if (docType == 1) {
      return 'Please upload clear photos of the required passport pages for identity verification.';
    } else {
      return 'Please upload clear photos of the required driving license pages for identity verification.';
    }
  }

  String _getInfoNote() {
    if (docType == 0) {
      return 'Please upload the front side and back side of your National ID card';
    } else if (docType == 1) {
      return 'Please upload the required pages of your Passport';
    } else {
      return 'Please upload the front side and back side of your Driving License';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.backgroundcolor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.white, size: 18),
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Screen Content Router ─────────────────────────────────
                  Expanded(
                    child: isDocumentUpload
                        ? _buildDocumentUploadView(context, controller)
                        : docType == 0
                            ? _buildIdCardUploadView(context, controller)
                            : _buildPhotoUploadView(context, controller),
                  ),

                  // ── Bottom Upload Button ──────────────────────────────────
                  ProElevatedButton(
                    text: 'Upload',
                    borderRadius: 30,
                    height: 52,
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: () {
                      if (isDocumentUpload) {
                        if (controller.passportDocPath == null || controller.passportDocPath!.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Please select a document file first',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withValues(alpha: 0.8),
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 8,
                            duration: const Duration(seconds: 2),
                          );
                          return;
                        }
                      } else if (docType == 0 || docType == 2) {
                        if ((controller.idFrontImagePath == null || controller.idFrontImagePath!.isEmpty) &&
                            (controller.idBackImagePath == null || controller.idBackImagePath!.isEmpty)) {
                          Get.snackbar(
                            'Error',
                            'Please capture or upload your document photos',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withValues(alpha: 0.8),
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 8,
                            duration: const Duration(seconds: 2),
                          );
                          return;
                        }
                      } else {
                        if (controller.passportImages.isEmpty &&
                            (controller.idFrontImagePath == null || controller.idFrontImagePath!.isEmpty)) {
                          Get.snackbar(
                            'Error',
                            'Please capture or upload passport photos',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withValues(alpha: 0.8),
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 8,
                            duration: const Duration(seconds: 2),
                          );
                          return;
                        }
                      }
                      Get.back();
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SCREEN 1: National ID card upload (Front & Back Part)
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildIdCardUploadView(BuildContext context, AuthController controller) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(
            context,
            title: _getTitle(),
            subtitle: _getSubtitle(),
          ),
          SizedBox(height: 28.h),

          // Two side-by-side cards: Front Part & Back Part
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Front Part Card
              Expanded(
                child: _buildIdCardBox(
                  context,
                  label: 'Front Part',
                  imagePath: controller.idFrontImagePath,
                  defaultFileName: 'Image1.jpg',
                  onPick: () => _showImageSourceDialog(
                    context,
                    onCamera: () => controller.pickIdFrontImage(source: ImageSource.camera),
                    onGallery: () => controller.pickIdFrontImage(source: ImageSource.gallery),
                  ),
                ),
              ),
              SizedBox(width: 14.w),

              // Back Part Card
              Expanded(
                child: _buildIdCardBox(
                  context,
                  label: 'Back Part',
                  imagePath: controller.idBackImagePath,
                  defaultFileName: 'Image',
                  onPick: () => _showImageSourceDialog(
                    context,
                    onCamera: () => controller.pickIdBackImage(source: ImageSource.camera),
                    onGallery: () => controller.pickIdBackImage(source: ImageSource.gallery),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Info row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: AppColors.onboardingtext, size: 14),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  _getInfoNote(),
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 11,
                    color: AppColors.onboardingtext,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIdCardBox(
    BuildContext context, {
    required String label,
    required String? imagePath,
    required String defaultFileName,
    required VoidCallback onPick,
  }) {
    final bool hasFile = imagePath != null && imagePath.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: 12,
            color: AppColors.onboardingtext,
          ),
        ),
        SizedBox(height: 8.h),

        // Box with Dashed Border
        CustomPaint(
          painter: DashedRectPainter(
            color: hasFile ? AppColors.bordercolor : AppColors.cardBorder,
            strokeWidth: 1.2,
            gap: 4,
          ),
          child: Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundcolor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: hasFile
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imagePath.startsWith('http')
                        ? Image.network(imagePath, fit: BoxFit.cover)
                        : imagePath == 'selected'
                            ? Image.network('https://picsum.photos/300/200', fit: BoxFit.cover)
                            : Image.file(File(imagePath), fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconPath.cameraPlus,
                        width: 28.w,
                        height: 28.w,
                        fit: BoxFit.contain,
                        color: AppColors.onboardingtext,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Take a Photo of your\nDocument',
                        textAlign: TextAlign.center,
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: 9,
                          color: AppColors.onboardingtext,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      GestureDetector(
                        onTap: onPick,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.cardBorder),
                          ),
                          child: Text(
                            'Take Photo',
                            style: AppTextStyle(context).mediumTextStyle(
                              fontSize: 9,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        SizedBox(height: 8.h),

        // Bottom file bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.textfieldcolor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  hasFile
                      ? (imagePath == 'selected'
                          ? defaultFileName
                          : imagePath.split('/').last)
                      : defaultFileName,
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 10,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onPick,
                child: Text(
                  'Change',
                  style: AppTextStyle(context).mediumTextStyle(
                    fontSize: 10,
                    color: AppColors.bordercolor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SCREEN 2: Photo upload (Passport / Driving License - Large box + Thumbnails)
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildPhotoUploadView(BuildContext context, AuthController controller) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(
            context,
            title: _getTitle(),
            subtitle: _getSubtitle(),
          ),
          SizedBox(height: 28.h),

          // Large Dashed Box
          CustomPaint(
            painter: DashedRectPainter(
              color: AppColors.cardBorder,
              strokeWidth: 1.2,
              gap: 5,
            ),
            child: Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconPath.cameraPlus,
                    width: 36.w,
                    height: 36.w,
                    fit: BoxFit.contain,
                    color: AppColors.onboardingtext,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Take a Photo of your\nDocument',
                    textAlign: TextAlign.center,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 11,
                      color: AppColors.onboardingtext,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () => _showImageSourceDialog(
                      context,
                      onCamera: () => controller.pickPassportImage(source: ImageSource.camera),
                      onGallery: () => controller.pickPassportImage(source: ImageSource.gallery),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Text(
                        'Take Photo',
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: 11,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Thumbnails row + count
          Row(
            children: [
              // Display passport images or simulated default images
              if (controller.passportImages.isNotEmpty)
                ...controller.passportImages.asMap().entries.map((e) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.bordercolor),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(File(e.value), width: 60.w, height: 60.w, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => controller.removePassportImage(e.key),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              else ...[
                // Placeholder images matching design
                _buildMockThumbnail('https://picsum.photos/200/200?random=1'),
                SizedBox(width: 10.w),
                _buildMockThumbnail('https://picsum.photos/200/200?random=2'),
              ],

              const Spacer(),
              Text(
                '${controller.passportImages.isEmpty ? 2 : controller.passportImages.length} Photos',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 11,
                  color: AppColors.onboardingtext,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMockThumbnail(String url) {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, _) => const Icon(Icons.image, color: AppColors.onboardingtext),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SCREEN 3: Document file upload (Browse PDF / JPEG)
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildDocumentUploadView(BuildContext context, AuthController controller) {
    final hasFile = controller.passportDocPath != null && controller.passportDocPath!.isNotEmpty;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(
            context,
            title: _getTitle(),
            subtitle: _getSubtitle(),
          ),
          SizedBox(height: 28.h),

          // Large Dashed Box
          CustomPaint(
            painter: DashedRectPainter(
              color: hasFile ? AppColors.bordercolor : AppColors.cardBorder,
              strokeWidth: 1.2,
              gap: 5,
            ),
            child: Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconPath.uploadTray,
                    width: 36.w,
                    height: 36.w,
                    fit: BoxFit.contain,
                    color: hasFile ? AppColors.bordercolor : AppColors.onboardingtext,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    hasFile
                        ? 'Document selected:\n${controller.passportDocPath!.split('/').last}'
                        : 'Upload your Document in\nPDF / JPEG',
                    textAlign: TextAlign.center,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 11,
                      color: hasFile ? AppColors.white : AppColors.onboardingtext,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  GestureDetector(
                    onTap: () => _showImageSourceDialog(
                      context,
                      onCamera: () => controller.pickPassportDocument(source: ImageSource.camera),
                      onGallery: () => controller.pickPassportDocument(source: ImageSource.gallery),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Text(
                        hasFile ? 'Change' : 'Browse',
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: 11,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header row with ID icon box ──────────────────────────────────────────
  Widget _buildHeaderRow(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.textfieldcolor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Icon(
                Icons.badge_outlined,
                color: AppColors.onboardingtext,
                size: 20,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: AppTextStyle.lg,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: AppTextStyle(context).regularTextStyle(
            fontSize: AppTextStyle.sm,
            color: AppColors.onboardingtext,
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog(
    BuildContext context, {
    required VoidCallback onCamera,
    required VoidCallback onGallery,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF262626),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image Source',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.lg,
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.bordercolor),
                title: Text('Camera', style: AppTextStyle(context).mediumTextStyle(color: Colors.white, fontSize: 14)),
                onTap: () {
                  Navigator.pop(ctx);
                  onCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.bordercolor),
                title: Text('Gallery', style: AppTextStyle(context).mediumTextStyle(color: Colors.white, fontSize: 14)),
                onTap: () {
                  Navigator.pop(ctx);
                  onGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Dashed Rect Painter for Exact Dotted/Dashed Boxes ────────────────────────
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
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
        const Radius.circular(10),
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
  bool shouldRepaint(covariant DashedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap;
  }
}
