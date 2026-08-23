import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'artist_profile_menu_item.dart';

class ArtistProfileMenuCard extends StatelessWidget {
  const ArtistProfileMenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primarytext.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // 1. Edit Profile
          ArtistProfileMenuItem(
            icon: Iconsax.edit,
            iconColor: const Color(0xFFE6B650),
            iconBackgroundColor: const Color(0xFF382B1B),
            title: 'Edit Profile',
            onTap: () => Get.toNamed(AppRoute.artistEditProfile),
          ),

          // 2. Verification badge
          ArtistProfileMenuItem(
            icon: Iconsax.verify,
            iconColor: const Color(0xFF24A61E),
            iconBackgroundColor: const Color(0xFF1B3821),
            title: 'Verification badge',
            onTap: () => Get.toNamed(AppRoute.artistVerification),
          ),

          // 3. Documents
          ArtistProfileMenuItem(
            icon: Iconsax.document_text,
            iconColor: const Color(0xFF4C8DFF),
            iconBackgroundColor: const Color(0xFF1B293D),
            title: 'Documents',
            onTap: () {
              Get.snackbar(
                'Documents',
                'Your artist legal documents are up to date.',
                backgroundColor: AppColors.primaryappbrown,
                colorText: AppColors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
              );
            },
          ),

          // 4. Review & Ratings
          ArtistProfileMenuItem(
            icon: Iconsax.profile_tick,
            iconColor: const Color(0xFFB55FE6),
            iconBackgroundColor: const Color(0xFF331B38),
            title: 'Review & Ratings',
            onTap: () {
              Get.snackbar(
                'Review & Ratings',
                'Rating: 4.8 / 5.0 across 120 client reviews.',
                backgroundColor: AppColors.primaryappbrown,
                colorText: AppColors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
              );
            },
          ),

          // 5. Payment Method
          ArtistProfileMenuItem(
            icon: Iconsax.card,
            iconColor: const Color(0xFF3BD5B8),
            iconBackgroundColor: const Color(0xFF173835),
            title: 'Payment Method',
            onTap: () {
              Get.snackbar(
                'Payment Method',
                'Mobile Money and Bank accounts linked.',
                backgroundColor: AppColors.primaryappbrown,
                colorText: AppColors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
              );
            },
          ),

          // 6. Support
          ArtistProfileMenuItem(
            icon: Iconsax.info_circle,
            iconColor: const Color(0xFF3BA7D5),
            iconBackgroundColor: const Color(0xFF1B3038),
            title: 'Support',
            onTap: () => Get.toNamed(AppRoute.faq),
          ),

          // 7. Settings
          ArtistProfileMenuItem(
            icon: Iconsax.setting_2,
            iconColor: const Color(0xFFC7987A),
            iconBackgroundColor: const Color(0xFF38251B),
            title: 'Settings',
            showDivider: false,
            onTap: () => Get.toNamed(AppRoute.settings),
          ),
        ],
      ),
    );
  }
}
