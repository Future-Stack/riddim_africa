import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../widgets/seller_profile_menu_item.dart';
import '../widgets/seller_delete_account_dialog.dart';
import 'seller_notification_settings_screen.dart';
import 'seller_change_password_screen.dart';
import 'seller_refund_policy_screen.dart';
import 'seller_community_guidelines_screen.dart';
import 'seller_privacy_policy_screen.dart';
import 'seller_cookie_notice_screen.dart';

class SellerSettingsScreen extends StatelessWidget {
  const SellerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Settings',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage your account preferences and app information.',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                  lineHeight: 18,
                ),
              ),
              20.verticalSpace,

              // Notification
              SellerProfileMenuItem(
                icon: Icons.notifications_outlined,
                iconColor: const Color(0xFFD49B53),
                iconBackgroundColor: const Color(0xFF382313),
                title: 'Notification',
                onTap: () =>
                    Get.to(() => const SellerNotificationSettingsScreen()),
              ),

              // Change Password
              SellerProfileMenuItem(
                icon: Icons.lock_outline_rounded,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Change Password',
                onTap: () =>
                    Get.to(() => const SellerChangePasswordScreen()),
              ),

              // Refund Policy
              SellerProfileMenuItem(
                icon: Icons.history_rounded,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Refund Policy',
                onTap: () => Get.to(() => const SellerRefundPolicyScreen()),
              ),

              // Community Guidelines
              SellerProfileMenuItem(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Community Guidelines',
                onTap: () =>
                    Get.to(() => const SellerCommunityGuidelinesScreen()),
              ),

              // Privacy Policy
              SellerProfileMenuItem(
                icon: Icons.privacy_tip_outlined,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Privacy Policy',
                onTap: () => Get.to(() => const SellerPrivacyPolicyScreen()),
              ),

              // Cookie Notice
              SellerProfileMenuItem(
                icon: Icons.cookie_outlined,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Cookie Notice',
                onTap: () => Get.to(() => const SellerCookieNoticeScreen()),
              ),

              // Delete Account
              SellerProfileMenuItem(
                icon: Icons.delete_outline_rounded,
                iconColor: AppColors.secondary,
                iconBackgroundColor: const Color(0xFF381510),
                title: 'Delete Account',
                onTap: () =>
                    SellerDeleteAccountConfirmationDialog.show(context),
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
