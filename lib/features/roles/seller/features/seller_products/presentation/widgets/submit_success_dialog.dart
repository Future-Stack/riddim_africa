import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';

class SubmitSuccessDialog extends StatelessWidget {
  final String productName;
  final VoidCallback onTrackStatus;

  const SubmitSuccessDialog({
    super.key,
    required this.productName,
    required this.onTrackStatus,
  });

  static Future<void> show(
    BuildContext context, {
    required String productName,
    required VoidCallback onTrackStatus,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SubmitSuccessDialog(
        productName: productName,
        onTrackStatus: onTrackStatus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF23140C),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Close icon
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Exact Success Badge Check Icon from IconPath with subtle glow
            Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF22C55E).withValues(alpha: 0.25),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                IconPath.badgeCheck,
                width: 84,
                height: 84,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // Heading
            Text(
              'Submitted Successfully',
              textAlign: TextAlign.center,
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: const Color(0xFF4CAF50), fontSize: 18),
            ),
            const SizedBox(height: 6),

            // Subheading
            Text(
              'Product Sent for Review!',
              textAlign: TextAlign.center,
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              'Your product "$productName" has been submitted. Our admin team will review it and contact you within 2 business days.',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).regularTextStyle(
                color: AppColors.primarytext,
                fontSize: 13,
                lineHeight: 20,
              ),
            ),
            const SizedBox(height: 24),

            // Track Review Status Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  onTrackStatus();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Track Review Status',
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
