import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(title: 'Settings'),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Account Section ─────────────────────────────────────────
              Text(
                'ACCOUNT',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.onboardingtext, fontSize: 12),
              ),
              const Gap(10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryappbrownsecond.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    _buildActionRow(
                      context,
                      icon: Iconsax.lock,
                      iconBg: const Color(0xFFE6B650).withValues(alpha: 0.1),
                      iconColor: const Color(0xFFE6B650),
                      title: 'Change Password',
                      onTap: () => Get.toNamed(AppRoute.changePassword),
                    ),
                    _buildDivider(),
                    _buildActionRow(
                      context,
                      icon: Iconsax.trash,
                      iconBg: const Color(0xFFE53935).withValues(alpha: 0.12),
                      iconColor: const Color(0xFFE53935),
                      title: 'Delete Account',
                      titleColor: const Color(0xFFFF6B6B),
                      onTap: () => Get.toNamed(AppRoute.deleteAccount),
                    ),
                  ],
                ),
              ),
              const Gap(20),

              // ─── Notifications Section ───────────────────────────────────
              Text(
                'NOTIFICATIONS',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.onboardingtext, fontSize: 12),
              ),
              const Gap(10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryappbrownsecond.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      _buildSwitchRow(
                        context,
                        icon: Iconsax.notification,
                        iconBg: const Color(0xFFBB483D).withValues(alpha: 0.1),
                        iconColor: const Color(0xFFBB483D),
                        title: 'Order Notifications',
                        value: controller.orderNotifications.value,
                        onChanged: controller.setOrderNotifications,
                      ),
                      _buildDivider(),
                      _buildSwitchRow(
                        context,
                        icon: Iconsax.notification,
                        iconBg: const Color(0xFFBB483D).withValues(alpha: 0.1),
                        iconColor: const Color(0xFFBB483D),
                        title: 'Artist Updates',
                        value: controller.artistUpdates.value,
                        onChanged: controller.setArtistUpdates,
                      ),
                      _buildDivider(),
                      _buildSwitchRow(
                        context,
                        icon: Iconsax.notification,
                        iconBg: const Color(0xFFBB483D).withValues(alpha: 0.1),
                        iconColor: const Color(0xFFBB483D),
                        title: 'Radio Alerts',
                        value: controller.radioAlerts.value,
                        onChanged: controller.setRadioAlerts,
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),

              // ─── About Section ───────────────────────────────────────────
              Text(
                'ABOUT',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.onboardingtext, fontSize: 12),
              ),
              const Gap(10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryappbrownsecond.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    _buildActionRow(
                      context,
                      icon: Iconsax.info_circle,
                      iconBg: const Color(0xFF377A7D).withValues(alpha: 0.1),
                      iconColor: const Color(0xFF377A7D),
                      title: 'FAQ',
                      onTap: () => Get.toNamed(AppRoute.faq),
                    ),
                    _buildDivider(),
                    _buildActionRow(
                      context,
                      icon: Iconsax.info_circle,
                      iconBg: const Color(0xFF377A7D).withValues(alpha: 0.1),
                      iconColor: const Color(0xFF377A7D),
                      title: 'Refund Policy',
                      onTap: () => Get.toNamed(AppRoute.refundPolicy),
                    ),
                    _buildDivider(),
                    _buildActionRow(
                      context,
                      icon: Iconsax.info_circle,
                      iconBg: const Color(0xFF377A7D).withValues(alpha: 0.1),
                      iconColor: const Color(0xFF377A7D),
                      title: 'Community Guidelines',
                      onTap: () => Get.toNamed(AppRoute.communityGuidelines),
                    ),
                    _buildDivider(),
                    _buildActionRow(
                      context,
                      icon: Iconsax.info_circle,
                      iconBg: const Color(0xFF377A7D).withValues(alpha: 0.1),
                      iconColor: const Color(0xFF377A7D),
                      title: 'Privacy Policy',
                      onTap: () => Get.toNamed(AppRoute.privacyPolicy),
                    ),
                    _buildDivider(),
                    _buildActionRow(
                      context,
                      icon: Iconsax.info_circle,
                      iconBg: const Color(0xFF377A7D).withValues(alpha: 0.1),
                      iconColor: const Color(0xFF377A7D),
                      title: 'Cookie Notice',
                      onTap: () => Get.toNamed(AppRoute.cookieNotice),
                    ),
                  ],
                ),
              ),
              const Gap(32),

              // ─── Footer Section ──────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Text(
                      'Riddim Africa v2.6.1',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.textfieldelementcolor,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '© 2026 Riddim Africa Limited',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    Color? titleColor,
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
          ).mediumTextStyle(color: titleColor ?? AppColors.white, fontSize: 16),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: titleColor ?? AppColors.primarytext,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchRow(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.white, fontSize: 16),
        ),
        trailing: Transform.scale(
          scale: 0.8,
          child: Switch.adaptive(
            value: value,

            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.purple,
            inactiveThumbColor: AppColors.white.withValues(alpha: 0.6),
            inactiveTrackColor: AppColors.primaryappbrownsecond,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.primaryappbrownsecond,
      height: 1,
      thickness: 1,
    );
  }
}
