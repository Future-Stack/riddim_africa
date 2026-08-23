import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/artist_document_model.dart';
import '../controllers/artist_document_detail_controller.dart';
import '../widgets/artist_document_corner_frame.dart';

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
        showDivider: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Green Verified Status Banner ───────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF14301B), // rich dark green
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFF34C759).withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Green Checkmark icon box
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B4324),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: const Color(0xFF34C759),
                        size: 24.sp,
                      ),
                    ),
                    14.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Verified',
                                style: AppTextStyle(context).boldTextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
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
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Text(
                            document.description ??
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

              // ─── Document Side Sections (Front Part & Back Part) ─────────
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
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                    12.verticalSpace,

                    // Corner Dashed Bracket Frame with Image Preview
                    ArtistDocumentCornerFrame(
                      cornerColor: const Color(0xFF655042),
                      cornerLength: 26.0,
                      strokeWidth: 1.8,
                      padding: EdgeInsets.all(10.w),
                      child: GestureDetector(
                        onTap: () => controller.showPickerOptions(context, sideLabel),
                        child: Container(
                          width: double.infinity,
                          height: 180.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22140A),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.r),
                            child: Obx(() {
                              final pickedFile =
                                  controller.getFileFor(sideLabel).value;

                              if (pickedFile != null) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      pickedFile,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 10.h,
                                      right: 10.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.7),
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Text(
                                          'Change Photo',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              if (item.previewUrl != null) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: item.previewUrl!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: AppColors.primaryappbrownsecond,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          _buildPlaceholderContent(context, sideLabel),
                                    ),
                                    Positioned(
                                      bottom: 10.h,
                                      right: 10.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.7),
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Text(
                                          'Change Photo',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return _buildPlaceholderContent(context, sideLabel);
                            }),
                          ),
                        ),
                      ),
                    ),
                    24.verticalSpace,
                  ],
                );
              }),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderContent(BuildContext context, String sideLabel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: const Color(0xFF382111),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFD49B53).withValues(alpha: 0.3),
            ),
          ),
          child: Icon(
            Icons.camera_alt_outlined,
            color: const Color(0xFFD49B53),
            size: 22.sp,
          ),
        ),
        12.verticalSpace,
        Text(
          'Tap to upload $sideLabel',
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: 13.sp,
            color: Colors.white,
          ),
        ),
        4.verticalSpace,
        Text(
          'Supports JPG, PNG or PDF scan',
          style: AppTextStyle(context).regularTextStyle(
            fontSize: 11.sp,
            color: AppColors.primarytext,
          ),
        ),
      ],
    );
  }
}
