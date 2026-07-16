import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../../bindings/order_binding.dart';
import '../controllers/order_list_controller.dart';
import '../widgets/order_card.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderListController>();

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
                color: AppColors.primaryappbrownsecond,
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
        title: Text(
          'My Orders',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: AppTextStyle.title),
        ),
        centerTitle: false,
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
      if (ctrl.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.onboardingbutton),
        );
      }

      if (ctrl.filteredOrders.isEmpty) {
        return Center(
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
        );
      }

      return RefreshIndicator(
        onRefresh: ctrl.loadOrders,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: ctrl.filteredOrders.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final order = ctrl.filteredOrders[index];
            return OrderCard(
              order: order,
              onTap: () {
                Get.toNamed('/orderDetail', arguments: order.id);
              },
            );
          },
        ),
      );
    });
  }
}
