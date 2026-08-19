import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN 1 — ID Verification (National ID / Passport / Driving License)
// ─────────────────────────────────────────────────────────────────────────────
class SellerIdVerificationScreen extends StatelessWidget {
  const SellerIdVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Create Account',
              style: AppTextStyle(context).boldTextStyle(
                color: AppColors.textfieldelementcolor,
                fontSize: AppTextStyle.xl,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => Get.back(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress indicator
                  _buildProgressBar(context, step: 1),
                  SizedBox(height: 24.h),

                  Text(
                    'Identity Verification',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.title,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Please upload a valid government-issued ID to verify your identity.',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.onboardingtext,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Tab selector
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundcolor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Row(
                      children: [
                        _buildDocTab(context, controller, 'National ID', 0),
                        _buildDocTab(context, controller, 'Passport', 1),
                        _buildDocTab(context, controller, 'Driving License', 2),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Front side upload
                  _buildUploadCard(
                    context,
                    label: controller.selectedDocTab == 1
                        ? 'Upload Your Passport'
                        : controller.selectedDocTab == 2
                            ? 'Upload Your Driving License'
                            : 'Upload Your National ID',
                    subtitle: 'Front Side',
                    icon: Icons.credit_card_outlined,
                    hasImage: controller.idFrontImagePath != null,
                    onTap: () => controller.pickIdFrontImage(),
                  ),
                  SizedBox(height: 16.h),

                  // Back side upload (not for passport)
                  if (controller.selectedDocTab != 1) ...[
                    _buildUploadCard(
                      context,
                      label: 'Back Side',
                      subtitle: 'Back of the document',
                      icon: Icons.credit_card_outlined,
                      hasImage: controller.idBackImagePath != null,
                      onTap: () => controller.pickIdBackImage(),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Selfie upload
                  _buildUploadCard(
                    context,
                    label: 'Take a Selfie',
                    subtitle: 'Hold your ID next to your face',
                    icon: Icons.face_outlined,
                    hasImage: controller.selfieImagePath != null,
                    onTap: () => controller.pickSelfieImage(),
                  ),
                  SizedBox(height: 32.h),

                  ProElevatedButton(
                    text: 'Next',
                    trailingIcon: Icons.arrow_forward_ios,
                    iconSize: 16,
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: () => Get.toNamed(AppRoute.sellerBusinessTypeScreen),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar(BuildContext context, {required int step}) {
    return Row(
      children: List.generate(3, (i) {
        final done = i < step;
        final active = i == step - 1;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < 2 ? 6.w : 0),
            height: 4,
            decoration: BoxDecoration(
              color: done || active ? AppColors.bordercolor : AppColors.cardBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDocTab(
    BuildContext context,
    AuthController controller,
    String label,
    int index,
  ) {
    final isSelected = controller.selectedDocTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setDocTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.bordercolor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyle(context).mediumTextStyle(
              color: isSelected ? AppColors.white : AppColors.onboardingtext,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard(
    BuildContext context, {
    required String label,
    required String subtitle,
    required IconData icon,
    required bool hasImage,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: hasImage
              ? AppColors.bordercolor.withValues(alpha: 0.1)
              : AppColors.backgroundcolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasImage ? AppColors.bordercolor : AppColors.cardBorder,
            width: hasImage ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: AppColors.cardBorder.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasImage ? Icons.check_circle_outline : icon,
                color: hasImage ? AppColors.bordercolor : AppColors.onboardingtext,
                size: 28,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              style: AppTextStyle(context).boldTextStyle(
                color: AppColors.white,
                fontSize: AppTextStyle.md,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              hasImage ? 'Image uploaded ✓' : subtitle,
              style: AppTextStyle(context).regularTextStyle(
                color: hasImage ? AppColors.bordercolor : AppColors.onboardingtext,
                fontSize: AppTextStyle.sm,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.cardBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hasImage ? 'Change Photo' : 'Upload Photo',
                style: AppTextStyle(context).mediumTextStyle(
                  color: AppColors.textfieldelementcolor,
                  fontSize: AppTextStyle.sm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
