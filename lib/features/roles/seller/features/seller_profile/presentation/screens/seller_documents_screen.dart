import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../controllers/seller_documents_controller.dart';
import '../../data/models/seller_document_model.dart';
import 'seller_document_detail_screen.dart';
import 'seller_verification_badge_screen.dart';

class SellerDocumentsScreen extends StatelessWidget {
  const SellerDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<SellerDocumentsController>()
        ? Get.find<SellerDocumentsController>()
        : Get.put(SellerDocumentsController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Documents',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle
              Text(
                'Upload verified identity documents to unlock full seller privileges on Riddim Africa.',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                  lineHeight: 18,
                ),
              ),
              20.verticalSpace,

              // Document Cards
              Obx(
                () => Column(
                  children: controller.documents.map((doc) {
                    return _buildDocumentCard(context, doc);
                  }).toList(),
                ),
              ),
              16.verticalSpace,

              // Upload New Document Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const SellerVerificationBadgeScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: Colors.white,
                        size: 18.sp,
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

              // Security & Encryption Disclaimer Card
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF22140A),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFFD49B53).withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: const Color(0xFFD49B53),
                      size: 18.sp,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Text(
                        'Your documents are encrypted and used solely for identity verification. They are never shared with third parties.',
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: 11.sp,
                          color: AppColors.primarytext,
                          lineHeight: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard(BuildContext context, SellerDocumentModel doc) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF22140A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Icon(
                doc.id == 'national_id'
                    ? Icons.badge_outlined
                    : (doc.id == 'passport'
                        ? Icons.menu_book_outlined
                        : Icons.credit_card_outlined),
                color: const Color(0xFFD49B53),
                size: 20.sp,
              ),
              10.horizontalSpace,
              Expanded(
                child: Text(
                  doc.title,
                  style: AppTextStyle(context).boldTextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SellerDocumentDetailScreen(document: doc));
                },
                child: Icon(
                  Icons.open_in_new_rounded,
                  color: AppColors.primarytext,
                  size: 18.sp,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Divider(
            color: AppColors.white.withValues(alpha: 0.06),
            height: 1,
          ),
          10.verticalSpace,

          // Side Items
          ...doc.items.map((item) {
            final isVerified = item.status == DocumentStatus.verified;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: AppTextStyle(context).mediumTextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primarytext,
                          ),
                        ),
                        4.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: isVerified
                                ? const Color(0xFF163E1C)
                                : const Color(0xFF382313),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isVerified ? Icons.check : Icons.access_time,
                                color: isVerified
                                    ? const Color(0xFF34C759)
                                    : const Color(0xFFD49B53),
                                size: 10.sp,
                              ),
                              4.horizontalSpace,
                              Text(
                                isVerified ? 'Verified' : 'Pending',
                                style: AppTextStyle(context).boldTextStyle(
                                  fontSize: 10.sp,
                                  color: isVerified
                                      ? const Color(0xFF34C759)
                                      : const Color(0xFFD49B53),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Icons (Download / View)
                  IconButton(
                    onPressed: () {
                      Get.to(() => SellerDocumentDetailScreen(document: doc));
                    },
                    icon: Icon(
                      Icons.visibility_outlined,
                      color: AppColors.primarytext,
                      size: 18.sp,
                    ),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.all(6.w),
                  ),
                  8.horizontalSpace,
                  IconButton(
                    onPressed: () {
                      Get.to(() => const SellerVerificationBadgeScreen());
                    },
                    icon: Icon(
                      Icons.file_upload_outlined,
                      color: AppColors.primarytext,
                      size: 18.sp,
                    ),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.all(6.w),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
