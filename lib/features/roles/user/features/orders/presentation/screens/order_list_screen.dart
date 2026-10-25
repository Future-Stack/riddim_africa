import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../bindings/order_binding.dart';
import '../../domain/entities/order_entity.dart';
import '../controllers/order_list_controller.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_app_bar.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<OrderListController>()) {
      OrderBinding().dependencies();
    } else {
      Get.find<OrderListController>().loadOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderListController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const OrdersAppBar(
        title: 'My Orders',
      ),
      body: Column(
        children: [
          _buildFilterTabs(context, controller),
          Expanded(child: _buildOrdersList(context, controller)),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context, OrderListController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ctrl.filterOptions.map((filter) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => ctrl.setFilter(filter),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: ctrl.selectedFilter.value == filter
                          ? AppColors.purple
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: ctrl.selectedFilter.value == filter
                            ? Colors.transparent
                            : AppColors.bordercolor,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: AppTextStyle(context).mediumTextStyle(
                        color: ctrl.selectedFilter.value == filter
                            ? AppColors.white
                            : AppColors.white,
                        fontSize: AppTextStyle.sm,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, OrderListController ctrl) {
    return Obx(() {
      final isLoading = ctrl.isLoading.value;

      if (!isLoading && ctrl.filteredOrders.isEmpty) {
        return RefreshIndicator(
          onRefresh: ctrl.loadOrders,
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Iconsax.box, size: 64, color: AppColors.primarytext),
                      const SizedBox(height: 16),
                      Text(
                        'No orders found',
                        style: AppTextStyle(context).semiBoldTextStyle(
                          color: AppColors.primarytext,
                          fontSize: AppTextStyle.lg,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }

      final ordersToDisplay = isLoading
          ? List.generate(
              5,
              (index) => OrderEntity(
                id: 'shimmer_$index',
                orderNumber: 'RA-2026-00000',
                imageUrl: '',
                title: 'African Rhythm Drum Loop',
                sellerName: 'Riddim Seller',
                price: 'UGX 150,000',
                quantity: 1,
                statusLabel: 'Processing',
                orderDate: DateTime.now(),
                totalPrice: 'UGX 150,000',
              ),
            )
          : ctrl.filteredOrders;

      return Skeletonizer(
        enabled: isLoading,
        effect: ShimmerEffect(
          baseColor: AppColors.primaryappbrownsecond.withValues(alpha: 0.6),
          highlightColor: AppColors.secondary.withValues(alpha: 0.25),
        ),
        child: RefreshIndicator(
          onRefresh: ctrl.loadOrders,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: ordersToDisplay.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = ordersToDisplay[index];
              return OrderCard(
                order: order,
                onTap: isLoading
                    ? null
                    : () {
                        Get.toNamed('/orderDetail', arguments: order.id);
                      },
              );
            },
          ),
        ),
      );
    });
  }
}
