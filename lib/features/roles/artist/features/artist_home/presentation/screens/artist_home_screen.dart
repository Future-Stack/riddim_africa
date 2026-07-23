import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/widgets/custom_search_bar.dart';
import 'package:riddimafrica/routes/app_routes.dart';

import '../controllers/artist_home_controller.dart';
import '../widgets/artist_home_app_bar.dart';
import '../widgets/verification_banner.dart';
import '../widgets/revenue_card.dart';
import '../widgets/stats_row.dart';
import '../widgets/recent_order_card.dart';

class ArtistHomeScreen extends GetView<ArtistHomeController> {
  const ArtistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const ArtistHomeAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.secondary),
          );
        }

        if (controller.stats.value == null) {
          return const Center(
            child: Text(
              'Failed to load data',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              CustomSearchBar(
                readOnly: true,
                onTap: () => Get.toNamed(AppRoute.globalSearch),
                backgroundColor: AppColors.white.withValues(alpha: 0.06),
                borderColor: AppColors.white.withValues(alpha: 0.08),
                textColor: AppColors.primarytext,
                hintTextColor: AppColors.primarytext,
                prefixIconColor: AppColors.primarytext,
                suffixIconColor: AppColors.primarytext,
              ),
              const SizedBox(height: 20),

              // Verification Banner
              if (controller.isBannerVisible.value) ...[
                VerificationBanner(onClose: controller.hideBanner),
                const SizedBox(height: 20),
              ],

              // Revenue Card
              RevenueCard(stats: controller.stats.value!),
              const SizedBox(height: 20),

              // Stats Row
              StatsRow(stats: controller.stats.value!),
              const SizedBox(height: 24),

              // Recent Orders Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Orders',
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(color: AppColors.white, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to full orders view
                    },
                    child: Row(
                      children: [
                        Text(
                          'View all',
                          style: AppTextStyle(context).mediumTextStyle(
                            color: AppColors.secondary,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppColors.secondary,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Recent Orders List
              if (controller.recentOrders.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'No recent orders.',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.recentOrders.length,
                  itemBuilder: (context, index) {
                    return RecentOrderCard(
                      order: controller.recentOrders[index],
                    );
                  },
                ),
            ],
          ),
        );
      }),
    );
  }
}
