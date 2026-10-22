import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class UserAccountDeletedDialog extends StatelessWidget {
  const UserAccountDeletedDialog({super.key});

  static void show([BuildContext? context]) {
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const UserAccountDeletedDialog(),
      );
    } else {
      Get.dialog(
        const UserAccountDeletedDialog(),
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Automatically log out and redirect to welcome screen after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () async {
      await StorageService.logoutUser();
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.offAllNamed(AppRoute.welcomescreen);
    });

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Scalloped Badge with Red Checkmark
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFBE4E2).withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE53935).withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFFE53935),
                  size: 40,
                ),
              ),
            ),
            20.verticalSpace,

            // Title
            Text(
              'Account Deleted Successfully',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).boldTextStyle(
                fontSize: 17.sp,
                color: Colors.white,
              ),
            ),
            10.verticalSpace,

            // Subtitle
            Text(
              'Your account and all associated data have been permanently removed.',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 12.5.sp,
                color: AppColors.primarytext,
                lineHeight: 18,
              ),
            ),
            24.verticalSpace,

            // Redirection indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.secondary,
                  ),
                ),
                8.horizontalSpace,
                Text(
                  'Redirecting...',
                  style: AppTextStyle(context).mediumTextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primarytext,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
