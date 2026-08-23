import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_documents_controller.dart';
import '../../data/models/artist_document_model.dart';
import 'artist_document_detail_screen.dart';

class ArtistDocumentsScreen extends StatelessWidget {
  const ArtistDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistDocumentsController>()
        ? Get.find<ArtistDocumentsController>()
        : Get.put(ArtistDocumentsController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Documents',
        showDivider: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Subtitle ───────────────────────────────────────────────
              Text(
                'Upload verified identity documents to unlock full seller privileges on Riddim Africa.',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                  lineHeight: 18,
                ),
              ),
              20.verticalSpace,

              // ─── Document Cards List ────────────────────────────────────
              Obx(
                () => Column(
                  children: controller.documents.map((doc) {
                    return _buildDocumentCard(context, doc);
                  }).toList(),
                ),
              ),
              12.verticalSpace,

              // ─── Upload New Document Button ─────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    final nationalIdDoc = controller.getDocumentById('national_id') ??
                        controller.documents.first;
                    Get.to(() => ArtistDocumentDetailScreen(document: nationalIdDoc));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      8.horizontalSpace,
                      Text(
                        'Upload New Document',
                        style: AppTextStyle(context).boldTextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,

              // ─── Security & Encryption Disclaimer ───────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.primarytext.withValues(alpha: 0.7),
                    size: 16.sp,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      'Your documents are encrypted and used solely for identity verification. They are never shared with third parties.',
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: 11.sp,
                        color: AppColors.primarytext.withValues(alpha: 0.7),
                        lineHeight: 16,
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard(BuildContext context, ArtistDocumentModel doc) {
    IconData getDocIcon() {
      if (doc.id == 'national_id') return Icons.badge_outlined;
      if (doc.id == 'passport') return Icons.person_outline_rounded;
      return Icons.article_outlined;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          InkWell(
            onTap: () {
              Get.to(() => ArtistDocumentDetailScreen(document: doc));
            },
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(
                    getDocIcon(),
                    color: const Color(0xFFD49B53),
                    size: 22.sp,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Text(
                      doc.title,
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.crop_original_outlined,
                    color: const Color(0xFFD49B53).withValues(alpha: 0.8),
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: AppColors.white.withValues(alpha: 0.06),
            height: 1,
          ),

          // Items (Sides)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: doc.items.map((item) {
                final isVerified = item.status == ArtistDocumentStatus.verified;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: AppTextStyle(context).mediumTextStyle(
                                fontSize: 13.sp,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                            6.verticalSpace,
                            // Status Badge Pill
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: isVerified
                                    ? const Color(0xFF163E1C) // dark green
                                    : const Color(0xFF382313), // dark amber
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isVerified
                                        ? Icons.check_circle_rounded
                                        : Icons.access_time_filled_rounded,
                                    color: isVerified
                                        ? const Color(0xFF34C759)
                                        : const Color(0xFFD49B53),
                                    size: 11.sp,
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    isVerified ? 'Verified' : 'Pending',
                                    style: TextStyle(
                                      color: isVerified
                                          ? const Color(0xFF34C759)
                                          : const Color(0xFFD49B53),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action Icon 1: Camera
                      Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => ArtistDocumentDetailScreen(document: doc));
                          },
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: const Color(0xFFD49B53),
                            size: 18.sp,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      8.horizontalSpace,
                      // Action Icon 2: Upload
                      Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => ArtistDocumentDetailScreen(document: doc));
                          },
                          icon: Icon(
                            Icons.file_upload_outlined,
                            color: const Color(0xFFD49B53),
                            size: 18.sp,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
