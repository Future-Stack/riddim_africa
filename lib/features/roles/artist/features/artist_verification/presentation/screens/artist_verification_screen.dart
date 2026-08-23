import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_verification_controller.dart';
import '../widgets/dashed_upload_container.dart';

class ArtistVerificationScreen extends GetView<ArtistVerificationController> {
  const ArtistVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Verification badge',
        showDivider: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Obx(
            () => ProElevatedButton(
              text: 'Submit',
              onPressed: controller.submit,
              isLoading: controller.isLoading.value,
              backgroundColor: AppColors.secondary,
              borderRadius: 14,
              height: 52,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // ─── Center Top Folder / Badge Icon Box ──────────────────────
              Center(
                child: Container(
                  width: 68.w,
                  height: 68.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryappbrown,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primarytext.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.folder_open,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ─── Heading Title ────────────────────────────────────────────
              Text(
                'Upload Business License',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // ─── Description with Green Highlighted "Verification Badge." ──
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 14,
                    lineHeight: 1.45,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Upload a copyright certificate or official proof showing that you hold the rights to your music, artist identity, or creative content to get ',
                    ),
                    TextSpan(
                      text: 'Verification Badge.',
                      style: AppTextStyle(context).boldTextStyle(
                        color: const Color(0xFF24A61E),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ─── Dashed Upload Box ────────────────────────────────────────
              Obx(
                () => DashedUploadContainer(
                  onTap: controller.pickDocument,
                  fileName: controller.selectedFileName.value.isNotEmpty
                      ? controller.selectedFileName.value
                      : null,
                  onRemoveFile: controller.removeFile,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
