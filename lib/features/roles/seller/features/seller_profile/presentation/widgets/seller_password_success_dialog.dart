import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class SellerPasswordSuccessDialog extends StatelessWidget {
  final VoidCallback? onClose;

  const SellerPasswordSuccessDialog({super.key, this.onClose});

  static void show(BuildContext context, {VoidCallback? onClose}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SellerPasswordSuccessDialog(onClose: onClose),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2B170C),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Big Badge Checkmark
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.verified_rounded,
                  color: const Color(0xFF34C759),
                  size: 72.sp,
                ),
              ),
            ),
            18.verticalSpace,

            // Title
            Text(
              'Password Changed Successfully',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).boldTextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            10.verticalSpace,

            // Subtitle
            Text(
              'Your account is now protected with your new password.',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 13.sp,
                color: AppColors.primarytext,
                lineHeight: 20,
              ),
            ),
            22.verticalSpace,

            // Done Button
            SizedBox(
              width: double.infinity,
              height: 46.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onClose != null) onClose!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Done',
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
