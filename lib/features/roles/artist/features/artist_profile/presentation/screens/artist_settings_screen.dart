import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../widgets/artist_profile_menu_item.dart';
import '../widgets/artist_delete_account_dialog.dart';
import 'artist_notification_settings_screen.dart';
import 'artist_change_password_screen.dart';
import 'artist_refund_policy_screen.dart';
import 'artist_community_guidelines_screen.dart';
import 'artist_privacy_policy_screen.dart';
import 'artist_cookie_notice_screen.dart';

class ArtistSettingsScreen extends StatelessWidget {
  const ArtistSettingsScreen({super.key});

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
              ArtistProfileMenuItem(
                icon: Icons.notifications_outlined,
                iconColor: const Color(0xFFD49B53),
                iconBackgroundColor: const Color(0xFF382313),
                title: 'Notification',
                onTap: () =>
                    Get.to(() => const ArtistNotificationSettingsScreen()),
              ),

              // Change Password
              ArtistProfileMenuItem(
                icon: Icons.lock_outline_rounded,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Change Password',
                onTap: () =>
                    Get.to(() => const ArtistChangePasswordScreen()),
              ),

              // Refund Policy
              ArtistProfileMenuItem(
                icon: Icons.history_rounded,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Refund Policy',
                onTap: () => Get.to(() => const ArtistRefundPolicyScreen()),
              ),

              // Community Guidelines
              ArtistProfileMenuItem(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Community Guidelines',
                onTap: () =>
                    Get.to(() => const ArtistCommunityGuidelinesScreen()),
              ),

              // Privacy Policy
              ArtistProfileMenuItem(
                icon: Icons.privacy_tip_outlined,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Privacy Policy',
                onTap: () => Get.to(() => const ArtistPrivacyPolicyScreen()),
              ),

              // Cookie Notice
              ArtistProfileMenuItem(
                icon: Icons.cookie_outlined,
                iconColor: const Color(0xFFB1A290),
                iconBackgroundColor: const Color(0xFF2C241D),
                title: 'Cookie Notice',
                onTap: () => Get.to(() => const ArtistCookieNoticeScreen()),
              ),

              // Delete Account
              ArtistProfileMenuItem(
                icon: Icons.delete_outline_rounded,
                iconColor: AppColors.secondary,
                iconBackgroundColor: const Color(0xFF381510),
                title: 'Delete Account',
                onTap: () =>
                    ArtistDeleteAccountConfirmationDialog.show(context),
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
