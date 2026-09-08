import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../controllers/artist_profile_controller.dart';
import '../widgets/artist_profile_header.dart';
import '../widgets/artist_profile_menu_item.dart';
import 'artist_edit_profile_screen.dart';
import 'artist_verification_badge_screen.dart';
import 'artist_documents_screen.dart';
import 'artist_review_ratings_screen.dart';
import 'artist_profile_payment_screen.dart';
import 'artist_support_screen.dart';
import 'artist_settings_screen.dart';

class ArtistProfileScreen extends StatelessWidget {
  const ArtistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistProfileController>()
        ? Get.find<ArtistProfileController>()
        : Get.put(ArtistProfileController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            );
          }

          final profile = controller.profile.value;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header with Avatar, Verified badge, Info and 3-Stats card
                ArtistProfileHeader(
                  profile: profile,
                  onAvatarTap: () {
                    Get.to(() => const ArtistEditProfileScreen());
                  },
                ),
                20.verticalSpace,

                // Menu Items List
                ArtistProfileMenuItem(
                  icon: Icons.edit_outlined,
                  iconColor: const Color(0xFFD49B53),
                  iconBackgroundColor: const Color(0xFF382313),
                  title: 'Edit Profile',
                  onTap: () => Get.to(() => const ArtistEditProfileScreen()),
                ),
                ArtistProfileMenuItem(
                  icon: Icons.verified_outlined,
                  iconColor: const Color(0xFF34C759),
                  iconBackgroundColor: const Color(0xFF163E1C),
                  title: 'Verification badge',
                  onTap: () =>
                      Get.to(() => const ArtistVerificationBadgeScreen()),
                ),
                ArtistProfileMenuItem(
                  icon: Icons.folder_outlined,
                  iconColor: const Color(0xFF5AC8FA),
                  iconBackgroundColor: const Color(0xFF133246),
                  title: 'Documents',
                  onTap: () => Get.to(() => const ArtistDocumentsScreen()),
                ),
                ArtistProfileMenuItem(
                  icon: Icons.star_outline_rounded,
                  iconColor: const Color(0xFFAF52DE),
                  iconBackgroundColor: const Color(0xFF381545),
                  title: 'Review & Ratings',
                  onTap: () => Get.to(() => const ArtistReviewRatingsScreen()),
                ),
                ArtistProfileMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: const Color(0xFF30B0C7),
                  iconBackgroundColor: const Color(0xFF12343B),
                  title: 'Payment Method',
                  onTap: () =>
                      Get.to(() => const ArtistProfilePaymentScreen()),
                ),
                ArtistProfileMenuItem(
                  icon: Icons.headset_mic_outlined,
                  iconColor: const Color(0xFF32D74B),
                  iconBackgroundColor: const Color(0xFF143B22),
                  title: 'Support',
                  onTap: () => Get.to(() => const ArtistSupportScreen()),
                ),
                ArtistProfileMenuItem(
                  icon: Icons.settings_outlined,
                  iconColor: const Color(0xFFB1A290),
                  iconBackgroundColor: const Color(0xFF2C241D),
                  title: 'Settings',
                  onTap: () => Get.to(() => const ArtistSettingsScreen()),
                ),
                16.verticalSpace,

                // Logout Button
                Center(
                  child: GestureDetector(
                    onTap: () => _showLogoutConfirmation(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF24140D),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppColors.secondary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: AppColors.secondary,
                            size: 18.sp,
                          ),
                          8.horizontalSpace,
                          Text(
                            'Logout',
                            style: AppTextStyle(context).boldTextStyle(
                              fontSize: 14.sp,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                24.verticalSpace,
              ],
            ),
          );
        }),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2B170C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Logout',
          style: AppTextStyle(context).boldTextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        content: Text(
          'Are you sure you want to log out from your seller account?',
          style: AppTextStyle(context).regularTextStyle(
            fontSize: 13.sp,
            color: AppColors.primarytext,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTextStyle(context).mediumTextStyle(
                fontSize: 13.sp,
                color: AppColors.primarytext,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.offAllNamed(AppRoute.welcomescreen);
            },
            child: Text(
              'Logout',
              style: AppTextStyle(context).boldTextStyle(
                fontSize: 13.sp,
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
