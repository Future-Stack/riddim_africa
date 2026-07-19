import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'package:riddimafrica/features/notification/presentation/controllers/notification_controller.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            // Logo in the center
            Image.asset(
              ImagePath.logo1,
              height: 50.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: AppColors.secondary),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.notifications),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          IconPath.notification, // path to your svg
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors
                                .appbardivider, // tint the icon if it's a single-color svg
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Obx(() {
                          final unread =
                              Get.find<NotificationController>().unreadCount;
                          if (unread == 0) return const SizedBox.shrink();
                          return Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$unread',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Authentic Products",
                    textAlign: TextAlign.center,
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(color: AppColors.white, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),

                // Shopping Cart Icon
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoute.marketCart);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 1.5),
                    ),
                    child: SvgPicture.asset(
                      IconPath.cartNew, // path to your svg
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors
                            .white, // tint the icon if it's a single-color svg
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140.0);
}
