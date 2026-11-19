import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:riddimafrica/core/core.dart';
import '../data/models/seller_faq_model.dart';

class SellerSupportController extends GetxController {
  final RxList<SellerFaqModel> faqs = SellerFaqModel.mockFaqs.obs;
  final RxSet<String> expandedFaqIds = <String>{}.obs;

  void toggleFaq(String id) {
    if (expandedFaqIds.contains(id)) {
      expandedFaqIds.remove(id);
    } else {
      expandedFaqIds.add(id);
    }
  }

  bool isFaqExpanded(String id) => expandedFaqIds.contains(id);

  Future<void> sendEmail({
    String email = 'support@riddim.africa',
    String subject = 'Riddim Africa - Seller Support Request',
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
      },
    );

    try {
      final bool launched = await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        showEmailFallbackBottomSheet(email);
      }
    } catch (_) {
      showEmailFallbackBottomSheet(email);
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri telLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(' ', ''),
    );

    try {
      final bool launched = await launchUrl(
        telLaunchUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Clipboard.setData(ClipboardData(text: phoneNumber));
        Get.snackbar(
          'Phone Copied',
          '$phoneNumber copied to clipboard.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1B4324),
          colorText: Colors.white,
        );
      }
    } catch (_) {
      Clipboard.setData(ClipboardData(text: phoneNumber));
      Get.snackbar(
        'Phone Copied',
        '$phoneNumber copied to clipboard.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1B4324),
        colorText: Colors.white,
      );
    }
  }

  void showEmailFallbackBottomSheet(String email) {
    final context = Get.context;
    if (context == null) return;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF22140A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              16.verticalSpace,
              Container(
                width: 52.w,
                height: 52.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF382111),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: const Color(0xFFD49B53),
                  size: 26.sp,
                ),
              ),
              12.verticalSpace,
              Text(
                'Email Support',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              6.verticalSpace,
              Text(
                email,
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF35C0AD),
                ),
              ),
              10.verticalSpace,
              Text(
                'Reach out directly to our dedicated seller care team. We usually respond within a few hours.',
                textAlign: TextAlign.center,
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                  lineHeight: 18,
                ),
              ),
              20.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: email));
                    Get.back();
                    Get.snackbar(
                      'Email Copied',
                      '$email copied to clipboard.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF1B4324),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 3),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.copy_rounded, size: 16),
                  label: Text(
                    'Copy Email Address',
                    style: AppTextStyle(context).boldTextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              8.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
