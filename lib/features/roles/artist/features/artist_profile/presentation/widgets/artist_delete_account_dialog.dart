import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../screens/artist_delete_account_screen.dart';

class ArtistDeleteAccountConfirmationDialog extends StatelessWidget {
  const ArtistDeleteAccountConfirmationDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const ArtistDeleteAccountConfirmationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2B170C),
          borderRadius: BorderRadius.circular(16.r),
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
            // Top Close Button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
            4.verticalSpace,

            // Title
            Text(
              'Are you sure you want to  delete your account ?',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).boldTextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                lineHeight: 22,
              ),
            ),
            12.verticalSpace,

            // Subtitle
            Text(
              'All account data and inspection records will be permanently removed.',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 12.sp,
                color: AppColors.primarytext,
                lineHeight: 18,
              ),
            ),
            20.verticalSpace,

            // Delete Account Button
            SizedBox(
              width: double.infinity,
              height: 46.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.to(() => const ArtistDeleteAccountScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
                label: Text(
                  'Delete account',
                  style: AppTextStyle(context).boldTextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
