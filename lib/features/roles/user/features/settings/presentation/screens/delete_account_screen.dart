import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/delete_account_controller.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserDeleteAccountController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Delete Account',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Danger Icon Badge & Header ──────────────────────────────
              Center(
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE53935).withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.delete_forever_rounded,
                      color: Color(0xFFE53935),
                      size: 34,
                    ),
                  ),
                ),
              ),
              16.verticalSpace,

              Center(
                child: Text(
                  'Delete Your Account',
                  style: AppTextStyle(context).boldTextStyle(
                    fontSize: 20.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
              8.verticalSpace,

              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    "We're sorry to see you go. Deleting your account will permanently remove your access to Riddim Africa and cannot be undone.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 13.sp,
                      color: AppColors.primarytext,
                      lineHeight: 19,
                    ),
                  ),
                ),
              ),
              24.verticalSpace,

              // ─── Warning Card (What you will lose) ─────────────────────────
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE53935).withValues(alpha: 0.25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFE53935),
                          size: 20,
                        ),
                        8.horizontalSpace,
                        Text(
                          'Before you proceed, please note:',
                          style: AppTextStyle(context).boldTextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFE53935),
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    _buildWarningPoint(
                      context,
                      'Your profile details and credentials will be permanently erased.',
                    ),
                    8.verticalSpace,
                    _buildWarningPoint(
                      context,
                      'Your order history, wishlist, and saved items will be lost.',
                    ),
                    8.verticalSpace,
                    _buildWarningPoint(
                      context,
                      'Any active subscriptions or memberships will be cancelled immediately.',
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // ─── Reason for Leaving ───────────────────────────────────────
              Text(
                'Reason for leaving (Optional)',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.onboardingbutton,
                ),
              ),
              10.verticalSpace,

              Obx(
                () => Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: controller.reasons.map((reason) {
                    final isSelected = controller.selectedReason.value == reason;
                    return GestureDetector(
                      onTap: () => controller.selectReason(reason),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.secondary.withValues(alpha: 0.2)
                              : AppColors.primaryappbrown,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.secondary
                                : AppColors.primarytext.withValues(alpha: 0.2),
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          reason,
                          style: AppTextStyle(context).mediumTextStyle(
                            fontSize: 12.sp,
                            color: isSelected
                                ? AppColors.secondary
                                : AppColors.primarytext,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              24.verticalSpace,

              // ─── Password Confirmation Field ──────────────────────────────
              Text(
                'Enter Password',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.white,
                ),
              ),
              8.verticalSpace,

              Obx(
                () => ProTextField(
                  labelText: null,
                  hintText: 'Enter your password to confirm',
                  obscureText: controller.isPasswordHidden.value,
                  controller: controller.passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                      color: AppColors.primarytext,
                      size: 20,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),
              16.verticalSpace,

              // ─── Agreement Checkbox ───────────────────────────────────────
              Obx(
                () => GestureDetector(
                  onTap: () => controller.toggleAgreement(null),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: Checkbox(
                          value: controller.isAgreed.value,
                          onChanged: controller.toggleAgreement,
                          activeColor: const Color(0xFFE53935),
                          checkColor: Colors.white,
                          side: BorderSide(
                            color: const Color(0xFFE53935).withValues(alpha: 0.7),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          'I understand that deleting my account is irreversible and all my data will be permanently deleted.',
                          style: AppTextStyle(context).regularTextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primarytext,
                            lineHeight: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              32.verticalSpace,

              // ─── Delete Account Button ────────────────────────────────────
              Obx(
                () => ProElevatedButton(
                  text: 'Delete Account',
                  leadingIcon: Icons.delete_forever_rounded,
                  backgroundColor: const Color(0xFFE53935),
                  textColor: Colors.white,
                  isLoading: controller.isDeleting.value,
                  onPressed: controller.isDeleting.value
                      ? null
                      : () => _showConfirmationBottomSheet(context, controller),
                ),
              ),
              12.verticalSpace,

              // ─── Keep My Account Button ───────────────────────────────────
              ProElevatedButton(
                text: 'Keep My Account',
                backgroundColor: Colors.transparent,
                textColor: AppColors.primarytext,
                border: BorderSide(
                  color: AppColors.primarytext.withValues(alpha: 0.3),
                  width: 1.2,
                ),
                onPressed: () => Get.back(),
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningPoint(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFFE53935),
            shape: BoxShape.circle,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: AppTextStyle(context).regularTextStyle(
              fontSize: 12.sp,
              color: AppColors.primarytext,
              lineHeight: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _showConfirmationBottomSheet(
    BuildContext context,
    UserDeleteAccountController controller,
  ) {
    if (controller.passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Password Required',
        'Please enter your password to confirm account deletion.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
      );
      return;
    }

    if (!controller.isAgreed.value) {
      Get.snackbar(
        'Confirmation Required',
        'Please confirm that you understand this action cannot be undone.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
      );
      return;
    }

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.primarytext.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            18.verticalSpace,
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE53935).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.delete_forever_rounded,
                  color: Color(0xFFE53935),
                  size: 28,
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              'Are you absolutely sure?',
              style: AppTextStyle(context).boldTextStyle(
                fontSize: 17.sp,
                color: Colors.white,
              ),
            ),
            8.verticalSpace,
            Text(
              'Once deleted, your account will be permanently deactivated and cannot be recovered.',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 12.5.sp,
                color: AppColors.primarytext,
                lineHeight: 18,
              ),
            ),
            24.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: ProElevatedButton(
                    text: 'Cancel',
                    backgroundColor: Colors.transparent,
                    textColor: AppColors.primarytext,
                    border: BorderSide(
                      color: AppColors.primarytext.withValues(alpha: 0.3),
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: ProElevatedButton(
                    text: 'Yes, Delete',
                    backgroundColor: const Color(0xFFE53935),
                    textColor: Colors.white,
                    onPressed: () {
                      Get.back();
                      controller.confirmDeleteAccount();
                    },
                  ),
                ),
              ],
            ),
            12.verticalSpace,
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
