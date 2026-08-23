import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/utils/constants/sizer.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';
import '../controllers/artist_profile_controller.dart';
import '../widgets/verified_badge_pill.dart';
import '../widgets/artist_profile_stats_card.dart';
import '../widgets/artist_profile_menu_card.dart';

class ArtistProfileScreen extends GetView<ArtistProfileController> {
  const ArtistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If controller isn't registered via binding, lazy instantiate it safely
    final controller = Get.isRegistered<ArtistProfileController>()
        ? Get.find<ArtistProfileController>()
        : Get.put(ArtistProfileController(
            getArtistProfileUseCase: Get.find(),
            updateArtistProfileUseCase: Get.find(),
          ));

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
          if (profile == null) {
            return Center(
              child: Text(
                'Failed to load profile',
                style: AppTextStyle(context).mediumTextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),

                // ─── Avatar with Camera Overlay ─────────────────────────────
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Obx(() {
                        final localPath = controller.localAvatarPath.value;
                        return Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.cardBorder,
                              width: 2.5,
                            ),
                            image: DecorationImage(
                              image: localPath.isNotEmpty
                                  ? FileImage(File(localPath)) as ImageProvider
                                  : NetworkImage(profile.avatarUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 2,
                        child: GestureDetector(
                          onTap: controller.pickAvatarImage,
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ─── Verified Badge Pill ────────────────────────────────────
                if (profile.isVerified) const VerifiedBadgePill(),
                const SizedBox(height: 14),

                // ─── Full Name ──────────────────────────────────────────────
                Text(
                  profile.fullName,
                  style: AppTextStyle(context).boldTextStyle(
                    color: const Color(0xFFF0E8D8),
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),

                // ─── Email ──────────────────────────────────────────────────
                Text(
                  profile.email,
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),

                // ─── Phone • Location ───────────────────────────────────────
                Text(
                  '${profile.phoneNumber} • ${profile.cityName}, ${profile.country}',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // ─── Stats Card ─────────────────────────────────────────────
                ArtistProfileStatsCard(profile: profile),
                const SizedBox(height: 20),

                // ─── Menu Options Card ──────────────────────────────────────
                const ArtistProfileMenuCard(),
                const SizedBox(height: 24),

                // ─── Logout Button ──────────────────────────────────────────
                GestureDetector(
                  onTap: controller.logout,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryappbrown,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.35),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFD35446),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: AppTextStyle(context).semiBoldTextStyle(
                            color: const Color(0xFFD35446),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }
}
