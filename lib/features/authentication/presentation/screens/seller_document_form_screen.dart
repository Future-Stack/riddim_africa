import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

/// Step 1 of Seller Verification — Document Info Form
/// Tabs: Passport | Driving License
/// Each tab shows relevant text fields + upload buttons
class SellerDocumentFormScreen extends StatelessWidget {
  const SellerDocumentFormScreen({super.key});

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
            child: Column(
              children: [
                // ── Tab Bar ─────────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundcolor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Row(
                      children: [
                        _buildTab(context, controller, 'Passport', 1),
                        _buildTab(context, controller, 'Driving License', 2),
                      ],
                    ),
                  ),
                ),

                // ── Form Content ─────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    child: controller.selectedDocTab == 1
                        ? _buildPassportForm(context, controller)
                        : _buildDrivingLicenseForm(context, controller),
                  ),
                ),

                // ── Next Button ──────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                  child: ProElevatedButton(
                    text: 'Next',
                    trailingIcon: Icons.arrow_forward_ios,
                    iconSize: 16,
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: () =>
                        Get.toNamed(AppRoute.sellerIdPhotoUploadScreen),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(
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
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyle(context).mediumTextStyle(
              color: isSelected ? AppColors.white : AppColors.onboardingtext,
              fontSize: AppTextStyle.md,
            ),
          ),
        ),
      ),
    );
  }

  // ── Passport Form ────────────────────────────────────────────────────────
  Widget _buildPassportForm(BuildContext context, AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        ProTextField(
          controller: controller.docFirstNameController,
          labelText: 'First Name',
          hintText: 'Enter First Name',
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docSurnameController,
          labelText: 'Surname',
          hintText: 'Enter Surname',
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docNumberController,
          labelText: 'Passport No.',
          hintText: 'Enter Passport Number',
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docDobController,
          labelText: 'Date of Birth',
          hintText: 'DD / MM / YYYY',
          keyboardType: TextInputType.datetime,
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.bordercolor,
            size: 18,
          ),
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docExpiryController,
          labelText: 'Expiry Date',
          hintText: 'DD / MM / YYYY',
          keyboardType: TextInputType.datetime,
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.bordercolor,
            size: 18,
          ),
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docNationalityController,
          labelText: 'Nationality',
          hintText: 'Enter Nationality',
        ),
        SizedBox(height: 20.h),

        // Upload file of document
        _buildUploadRow(
          context,
          label: 'Upload file of document',
          hasFile: controller.idFrontImagePath != null,
          onTap: controller.pickIdFrontImage,
        ),
        SizedBox(height: 12.h),

        // Upload selfie with document
        _buildUploadRow(
          context,
          label: 'Upload Selfie of document',
          hasFile: controller.selfieImagePath != null,
          onTap: controller.pickSelfieImage,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  // ── Driving License Form ─────────────────────────────────────────────────
  Widget _buildDrivingLicenseForm(
    BuildContext context,
    AuthController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        ProTextField(
          controller: controller.docFirstNameController,
          labelText: 'First Name',
          hintText: 'Enter First Name',
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docSurnameController,
          labelText: 'Surname',
          hintText: 'Enter Surname',
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docNumberController,
          labelText: 'License No.',
          hintText: 'Enter License Number',
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docDobController,
          labelText: 'Date of Birth',
          hintText: 'DD / MM / YYYY',
          keyboardType: TextInputType.datetime,
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.bordercolor,
            size: 18,
          ),
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docExpiryController,
          labelText: 'Expiry Date',
          hintText: 'DD / MM / YYYY',
          keyboardType: TextInputType.datetime,
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.bordercolor,
            size: 18,
          ),
        ),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.docNationalityController,
          labelText: 'Nationality',
          hintText: 'Enter Nationality',
        ),
        SizedBox(height: 20.h),

        _buildUploadRow(
          context,
          label: 'Upload Front Side of document',
          hasFile: controller.idFrontImagePath != null,
          onTap: controller.pickIdFrontImage,
        ),
        SizedBox(height: 12.h),
        _buildUploadRow(
          context,
          label: 'Upload Back Side of document',
          hasFile: controller.idBackImagePath != null,
          onTap: controller.pickIdBackImage,
        ),
        SizedBox(height: 12.h),
        _buildUploadRow(
          context,
          label: 'Upload Selfie of document',
          hasFile: controller.selfieImagePath != null,
          onTap: controller.pickSelfieImage,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildUploadRow(
    BuildContext context, {
    required String label,
    required bool hasFile,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: hasFile
              ? AppColors.bordercolor.withValues(alpha: 0.1)
              : AppColors.backgroundcolor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasFile ? AppColors.bordercolor : AppColors.cardBorder,
          ),
        ),
        child: Row(
          children: [
            hasFile
                ? const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.bordercolor,
                    size: 20,
                  )
                : Image.asset(
                    IconPath.uploadTray,
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.contain,
                    color: AppColors.onboardingtext,
                  ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                hasFile ? 'File uploaded ✓' : label,
                style: AppTextStyle(context).mediumTextStyle(
                  color:
                      hasFile ? AppColors.bordercolor : AppColors.onboardingtext,
                  fontSize: AppTextStyle.md,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hasFile ? 'Change' : 'Upload',
                style: AppTextStyle(context).mediumTextStyle(
                  color: AppColors.secondary,
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
