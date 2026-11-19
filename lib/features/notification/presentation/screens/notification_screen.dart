import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/notification_controller.dart';
import '../../data/models/notification_model.dart';
import '../widgets/notification_filter_chips.dart';
import '../widgets/notification_tile.dart';
import '../widgets/notification_detail_sheet.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.appbardivider,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.white, fontSize: 20),
              ),
              const SizedBox(height: 2),
              Text(
                '${controller.unreadCount} unread',
                style: AppTextStyle(
                  context,
                ).regularTextStyle(color: AppColors.primarytext, fontSize: 13),
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                controller.markAllAsRead();
                Get.snackbar(
                  'Success',
                  'All notifications marked as read',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primaryappbrown,
                  colorText: AppColors.white,
                  duration: const Duration(seconds: 2),
                );
              },
              child: Text(
                'Mark all read',
                style: AppTextStyle(
                  context,
                ).mediumTextStyle(color: AppColors.secondary, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // Category Filters Row
          NotificationFilterChips(controller: controller),
          const SizedBox(height: 16),
          // Divider below chips
          const Divider(
            color: AppColors.primaryappbrownsecond,
            thickness: 1,
            height: 1,
          ),
          // Notifications List
          Expanded(
            child: Obx(() {
              final items = controller.filteredNotifications;
              if (items.isEmpty) {
                return _buildEmptyState(context);
              }
              return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.primaryappbrownsecond,
                  thickness: 1,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return NotificationTile(
                    item: item,
                    onTap: () {
                      controller.markAsRead(item.id);
                      _showNotificationDetail(context, item);
                    },
                    onViewTap: () {
                      controller.markAsRead(item.id);
                      _showNotificationDetail(context, item);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.primaryappbrown,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              size: 48,
              color: AppColors.primarytext,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'You are all caught up!',
            style: AppTextStyle(
              context,
            ).regularTextStyle(color: AppColors.primarytext, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _showNotificationDetail(BuildContext context, NotificationModel item) {
    Get.bottomSheet(NotificationDetailSheet(item: item));
  }
}
