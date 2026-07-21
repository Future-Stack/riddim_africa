import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../controllers/profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If the controller isn't registered, initialize it.
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(16),

              // ─── Profile Photo with Camera Badge ─────────────────────────
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      final imagePath = controller.profileImagePath.value;
                      return Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primarytext,
                            width: 3,
                          ),
                          image: DecorationImage(
                            image: imagePath.isNotEmpty
                                ? FileImage(File(imagePath)) as ImageProvider
                                : const NetworkImage(
                                    'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=500',
                                  ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: controller.pickProfileImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 3,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // ─── Name, Email & Phone ─────────────────────────────────────
              Obx(
                () => Text(
                  controller.name.value,
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: AppColors.white, fontSize: 22),
                ),
              ),
              const Gap(4),
              Obx(
                () => Text(
                  controller.email.value,
                  style: AppTextStyle(
                    context,
                  ).mediumTextStyle(color: AppColors.primarytext, fontSize: 14),
                ),
              ),
              const Gap(4),
              Obx(
                () => Text(
                  '${controller.phoneNumber.value} • ${controller.city.value}, ${controller.country.value}',
                  style: AppTextStyle(
                    context,
                  ).mediumTextStyle(color: AppColors.primarytext, fontSize: 13),
                ),
              ),
              const Gap(24),

              // ─── Stats Card ──────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primarytext.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(
                      context,
                      icon: Iconsax.bag_2,
                      value: '12',
                      label: 'Orders',
                    ),
                    _buildDivider(),
                    Obx(
                      () => _buildStatItem(
                        context,
                        icon: Iconsax.heart,
                        value: controller.wishlist.length.toString(),
                        label: 'Wishlist',
                      ),
                    ),
                    _buildDivider(),
                    _buildStatItem(
                      context,
                      icon: Iconsax.star,
                      value: '5',
                      label: 'Artist',
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // ─── Riddim Africa Member Card ───────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrownsecond,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primarytext.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(ImagePath.logo1, width: 56, height: 56),
                    const Gap.h(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Riddim Africa Member',
                            style: AppTextStyle(context).mediumTextStyle(
                              color: AppColors.onboardingbutton,
                              fontSize: 14,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            'Supporter since January 2024',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.onboardingbutton.withValues(
                          alpha: 0.11,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.onboardingbutton.withValues(
                            alpha: 0.4,
                          ),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        'Member',
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.onboardingbutton,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // ─── Navigation Menu List Card ───────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primarytext.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Iconsax.edit_2,
                      iconBg: const Color(0xFFE6B650).withValues(alpha: 0.1),
                      iconColor: const Color(0xFFE6B650),
                      title: 'Edit Profile',
                      onTap: () => Get.toNamed(AppRoute.editProfile),
                    ),
                    _buildMenuDivider(),
                    _buildMenuItem(
                      context,
                      icon: Iconsax.box,
                      iconBg: const Color(0xFF377A7D).withValues(alpha: 0.1),
                      iconColor: const Color(0xFF377A7D),
                      title: 'My Orders',
                      onTap: () => Get.toNamed('/orderList'),
                    ),
                    _buildMenuDivider(),
                    _buildMenuItem(
                      context,
                      icon: Iconsax.heart,
                      iconBg: const Color(0xFFBB483D).withValues(alpha: 0.1),
                      iconColor: const Color(0xFFBB483D),
                      title: 'Wishlist',
                      onTap: () => Get.toNamed(AppRoute.wishlist),
                    ),
                    _buildMenuDivider(),
                    _buildMenuItem(
                      context,
                      icon: Iconsax.notification,
                      iconBg: const Color(0xFFE6B650).withValues(alpha: 0.1),
                      iconColor: const Color(0xFFE6B650),
                      title: 'Notifications',
                      onTap: () => Get.toNamed('/notifications'),
                    ),
                    _buildMenuDivider(),
                    _buildMenuItem(
                      context,
                      icon: Iconsax.setting_2,
                      iconBg: const Color(0xFFB1A290).withValues(alpha: 0.1),
                      iconColor: const Color(0xFFB1A290),
                      title: 'Settings',
                      onTap: () => Get.toNamed(AppRoute.settings),
                    ),
                  ],
                ),
              ),
              const Gap(24),

              // ─── Logout Button ───────────────────────────────────────────
              ProElevatedButton(
                text: 'Logout',
                textColor: AppColors.secondary,
                backgroundColor: Colors.transparent,
                border: const BorderSide(
                  color: AppColors.secondary,
                  width: 1.5,
                ),
                leadingIcon: Icons.logout,
                onPressed: () {
                  Get.offAllNamed(AppRoute.welcomescreen);
                },
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.onboardingbutton, size: 24),
        const Gap(6),
        Text(
          value,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 20),
        ),
        const Gap(2),
        Text(
          label,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: AppColors.primarytext.withValues(alpha: 0.1),
    );
  }

  Widget _buildMenuDivider() {
    return Divider(
      color: AppColors.primarytext.withValues(alpha: 0.1),
      height: 1,
      thickness: 1,
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.white, fontSize: 16),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.primarytext,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ─── Custom Painter for solid red Ankh ─────────────────────────────────────
class RedAnkhPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.fill;

    double cx = size.width / 2;
    double top = 2;
    double loopHeight = size.height * 0.46;

    // Draw loop as an oval
    final loopPath = Path()
      ..addOval(
        Rect.fromLTWH(
          cx - size.width * 0.26,
          top,
          size.width * 0.52,
          loopHeight,
        ),
      );
    canvas.drawPath(loopPath, paint);

    // Inner cutout to make it a loop ring (using transparent paint to cut, or paint with background color)
    final cutoutPaint = Paint()
      ..color = AppColors.primaryappbrown
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromLTWH(
        cx - size.width * 0.11,
        top + 6,
        size.width * 0.22,
        loopHeight - 12,
      ),
      cutoutPaint,
    );

    // Crossbar
    final crossRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - size.width * 0.46, loopHeight, size.width * 0.92, 6),
      const Radius.circular(3),
    );
    canvas.drawRRect(crossRect, paint);

    // Stem
    final stemRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - 4, loopHeight + 6, 8, size.height - loopHeight - 6),
      const Radius.circular(2),
    );
    canvas.drawRRect(stemRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
