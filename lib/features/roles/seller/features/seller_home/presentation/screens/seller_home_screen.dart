import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/widgets/custom_search_bar.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/controllers/seller_bottom_nav_controller.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/data/models/seller_order_model.dart';
import 'package:riddimafrica/routes/app_routes.dart';

import '../controllers/seller_home_controller.dart';
import '../widgets/seller_home_app_bar.dart';
import '../widgets/seller_verification_banner.dart';
import '../widgets/seller_revenue_card.dart';
import '../widgets/seller_stats_row.dart';
import '../widgets/seller_recent_order_card.dart';

class SellerHomeScreen extends GetView<SellerHomeController> {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const SellerHomeAppBar(),
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
                SellerVerificationBanner(onClose: controller.hideBanner),
                const SizedBox(height: 20),
              ],

              // Revenue Card
              GestureDetector(
                onTap: () {
                  if (Get.isRegistered<SellerBottomNavController>()) {
                    Get.find<SellerBottomNavController>().changeIndex(3);
                  } else {
                    Get.toNamed(AppRoute.sellerRevenue);
                  }
                },
                child: SellerRevenueCard(stats: controller.stats.value!),
              ),
              const SizedBox(height: 20),

              // Stats Row
              SellerStatsRow(stats: controller.stats.value!),
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
                      if (Get.isRegistered<SellerBottomNavController>()) {
                        Get.find<SellerBottomNavController>().changeIndex(2);
                      } else {
                        Get.toNamed(AppRoute.sellerOrders);
                      }
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
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.recentOrders.length,
                  itemBuilder: (context, index) {
                    final recentOrder = controller.recentOrders[index];
                    return GestureDetector(
                      onTap: () {
                        // Find matching order in mock data or construct model
                        final match = SellerOrderModel.getInitialOrders().firstWhere(
                          (o) => o.id == recentOrder.id,
                          orElse: () => SellerOrderModel(
                            id: recentOrder.id,
                            productCode: recentOrder.id,
                            productTitle: recentOrder.productName,
                            customerName: recentOrder.customerName,
                            price: 'UGX ${recentOrder.price.toInt()}',
                            status: SellerOrderStatus.newOrder,
                            orderTime: recentOrder.date,
                            paymentMethod: 'Paid via Mobile Money',
                            productImage: recentOrder.productImageUrl,
                          ),
                        );
                        Get.toNamed(
                          AppRoute.sellerNewOrderAlert,
                          arguments: match,
                        );
                      },
                      child: SellerRecentOrderCard(
                        order: recentOrder,
                      ),
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
