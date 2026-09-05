import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_orders_controller.dart';
import '../../data/models/artist_order_model.dart';
import 'artist_new_order_alert_screen.dart';
import 'artist_order_completed_screen.dart';
import 'artist_order_cancelled_detail_screen.dart';

class ArtistOrdersScreen extends StatelessWidget {
  const ArtistOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.isRegistered<ArtistOrdersController>()
        ? Get.find<ArtistOrdersController>()
        : Get.put(ArtistOrdersController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
        leading: Navigator.canPop(context)
            ? Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                // child: GestureDetector(
                //   onTap: () => Get.back(),
                //   child: Container(
                //     decoration: const BoxDecoration(
                //       color: AppColors.appbardivider,
                //       shape: BoxShape.circle,
                //     ),
                //     child: const Icon(
                //       Icons.arrow_back,
                //       color: AppColors.white,
                //       size: 20,
                //     ),
                //   ),
                // ),
              )
            : null,
        title: Text(
          'Orders',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => c.toggleSearch(),
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.appbardivider,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search field if visible
            Obx(() {
              if (!c.isSearchVisible.value) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  controller: c.searchController,
                  onChanged: (val) => c.onSearchChanged(val),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search by product, order ID, buyer...',
                    hintStyle: TextStyle(
                      color: AppColors.primarytext.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primarytext,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: AppColors.white.withValues(alpha: 0.06),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.secondary),
                    ),
                  ),
                ),
              );
            }),

            // Pill Tabs: Active (count) | Completed (count) | Cancelled (count)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Obx(
                () => Row(
                  children: [
                    _buildPillTab(
                      context,
                      title: 'Active',
                      count: c.activeCount,
                      isSelected: c.selectedTab.value == 0,
                      onTap: () => c.setTab(0),
                    ),
                    const SizedBox(width: 8),
                    _buildPillTab(
                      context,
                      title: 'Completed',
                      count: c.completedCount,
                      isSelected: c.selectedTab.value == 1,
                      onTap: () => c.setTab(1),
                    ),
                    const SizedBox(width: 8),
                    _buildPillTab(
                      context,
                      title: 'Cancelled',
                      count: c.cancelledCount,
                      isSelected: c.selectedTab.value == 2,
                      onTap: () => c.setTab(2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Filtered Orders List
            Expanded(
              child: Obx(() {
                final list = c.filteredOrders;

                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 48,
                          color: AppColors.primarytext.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No orders found',
                          style: AppTextStyle(context).mediumTextStyle(
                            color: AppColors.primarytext,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final order = list[index];
                    return _buildOrderCard(context, order);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillTab(
    BuildContext context, {
    required String title,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6F2C57)
                : AppColors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6F2C57)
                  : AppColors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyle(context).mediumTextStyle(
                  color: isSelected ? Colors.white : AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
              if (count > 0 && !isSelected) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE65100),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, ArtistOrderModel order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF22140A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (order.status == ArtistOrderStatus.cancelled) {
              Get.to(() => ArtistOrderCancelledDetailScreen(order: order));
            } else if (order.status == ArtistOrderStatus.delivered) {
              Get.to(() => ArtistOrderCompletedScreen(order: order));
            } else {
              // Active: New Order or Processing
              Get.to(() => ArtistNewOrderAlertScreen(order: order));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    order.productImage,
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 58,
                      height: 58,
                      color: Colors.white10,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.white38,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Order details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        order.productTitle,
                        style: AppTextStyle(
                          context,
                        ).boldTextStyle(color: Colors.white, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),

                      // Order ID
                      Text(
                        order.id,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext.withValues(alpha: 0.7),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Customer Name
                      Text(
                        order.customerName,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Right Side: Price & Status Badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusBadge(order.status),
                    const SizedBox(height: 10),
                    Text(
                      order.price,
                      style: AppTextStyle(context).boldTextStyle(
                        color: const Color(0xFFF5A623),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ArtistOrderStatus status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case ArtistOrderStatus.newOrder:
        bgColor = const Color(0xFF4A2800);
        textColor = const Color(0xFFFF9800);
        break;
      case ArtistOrderStatus.processing:
      case ArtistOrderStatus.pending:
        bgColor = const Color(0xFF3E2800);
        textColor = const Color(0xFFF5A623);
        break;
      case ArtistOrderStatus.delivered:
        bgColor = const Color(0xFF14301B);
        textColor = const Color(0xFF4CAF50);
        break;
      case ArtistOrderStatus.cancelled:
        bgColor = const Color(0xFF3B1414);
        textColor = const Color(0xFFE53935);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
