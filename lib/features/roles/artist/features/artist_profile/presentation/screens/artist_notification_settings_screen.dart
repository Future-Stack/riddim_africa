import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../controllers/artist_settings_controller.dart';

class ArtistNotificationSettingsScreen extends StatelessWidget {
  const ArtistNotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistSettingsController>()
        ? Get.find<ArtistSettingsController>()
        : Get.put(ArtistSettingsController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Notifications',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Control which notifications you receive from Riddim Africa.',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                  lineHeight: 18,
                ),
              ),
              20.verticalSpace,

              // Orders Switch
              Obx(
                () => _buildToggleCard(
                  context: context,
                  icon: Icons.shopping_cart_outlined,
                  title: 'Orders',
                  description: 'Receive notifications when new orders arrive.',
                  value: controller.ordersNotification.value,
                  onChanged: (val) => controller.toggleOrders(val),
                ),
              ),
              12.verticalSpace,

              // Product Approval Updates Switch
              Obx(
                () => _buildToggleCard(
                  context: context,
                  icon: Icons.inventory_2_outlined,
                  title: 'Product Approval Updates',
                  description:
                      'Receive alerts when products are approved or rejected.',
                  value: controller.productApprovalNotification.value,
                  onChanged: (val) => controller.toggleProductApproval(val),
                ),
              ),
              12.verticalSpace,

              // Earnings & Settlements Switch
              Obx(
                () => _buildToggleCard(
                  context: context,
                  icon: Icons.attach_money_rounded,
                  title: 'Earnings & Settlements',
                  description: 'Receive payout notifications.',
                  value: controller.earningsSettlementNotification.value,
                  onChanged: (val) =>
                      controller.toggleEarningsSettlement(val),
                ),
              ),
              12.verticalSpace,

              // Promotions & Announcements Switch
              Obx(
                () => _buildToggleCard(
                  context: context,
                  icon: Icons.notifications_none_rounded,
                  title: 'Promotions & Announcements',
                  description: 'Receive platform news and updates.',
                  value: controller.promotionsNotification.value,
                  onChanged: (val) => controller.togglePromotions(val),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF22140A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: Color(0xFF382313),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFD49B53),
              size: 18.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle(context).boldTextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  description,
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 11.sp,
                    color: AppColors.primarytext,
                    lineHeight: 15,
                  ),
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          Switch(
            value: value,
            activeThumbColor: const Color(0xFFD49B53),
            activeTrackColor: const Color(0xFFD49B53).withValues(alpha: 0.4),
            inactiveThumbColor: AppColors.primarytext,
            inactiveTrackColor: const Color(0xFF382313),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
