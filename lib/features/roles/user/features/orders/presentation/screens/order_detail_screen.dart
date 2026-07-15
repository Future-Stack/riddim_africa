import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/order_detail_controller.dart';
import '../widgets/order_info_row.dart';
import '../widgets/tracking_timeline.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: AppTextStyle(context).boldTextStyle(
                color: AppColors.white,
                fontSize: AppTextStyle.xl,
              ),
            ),
            Obx(() {
              if (controller.order.value == null) return const SizedBox.shrink();
              return Text(
                controller.order.value!.orderNumber,
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: AppTextStyle.sm,
                ),
              );
            }),
          ],
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.onboardingbutton,
            ),
          );
        }

        final order = controller.order.value;
        if (order == null) {
          return const Center(child: Text('Order not found'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductInfo(context, order),
              const SizedBox(height: 20),
              _buildTrackingCard(context),
              const SizedBox(height: 20),
              _buildOrderInfo(context, order),
              const SizedBox(height: 20),
              _buildActions(context),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProductInfo(BuildContext context, dynamic order) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryappbrownsecond, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                order.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.primaryappbrownsecond,
                  child: const Icon(Iconsax.image, color: AppColors.primarytext),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.title,
                  style: AppTextStyle(context).semiBoldTextStyle(
                    color: AppColors.white,
                    fontSize: AppTextStyle.lg,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  order.sellerName,
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: AppTextStyle.sm,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  order.price,
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: AppTextStyle.md,
                  ),
                ),
                if (order.selectedColor != null ||
                    order.selectedSize != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    _variantText(order),
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _variantText(dynamic order) {
    final parts = <String>[];
    if (order.selectedColor != null) parts.add('Color: ${order.selectedColor}');
    if (order.selectedSize != null) parts.add('Size: ${order.selectedSize}');
    return parts.join(', ');
  }

  Widget _buildTrackingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryappbrownsecond, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Iconsax.location, color: AppColors.onboardingbutton, size: 20),
              const SizedBox(width: 8),
              Text(
                'Tracking',
                style: AppTextStyle(context).semiBoldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.lg,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TrackingTimeline(events: controller.trackingEvents),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context, dynamic order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryappbrownsecond, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Iconsax.info_circle, color: AppColors.onboardingbutton, size: 20),
              const SizedBox(width: 8),
              Text(
                'Order Information',
                style: AppTextStyle(context).semiBoldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.lg,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          OrderInfoRow(
            label: 'Order ID',
            value: order.orderNumber,
            icon: Iconsax.box,
          ),
          const Divider(color: AppColors.primaryappbrown, height: 24),
          OrderInfoRow(
            label: 'Order Date',
            value: _formatDate(order.orderDate),
            icon: Iconsax.calendar,
          ),
          const Divider(color: AppColors.primaryappbrown, height: 24),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Status',
                  style: AppTextStyle(context).mediumTextStyle(
                    color: AppColors.primarytext,
                    fontSize: AppTextStyle.md,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: order.isPaid ? AppColors.success : AppColors.warning,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        order.isPaid ? Icons.check : Icons.access_time,
                        color: AppColors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order.isPaid ? 'Paid' : 'Unpaid',
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.white,
                          fontSize: AppTextStyle.sm,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (order.paymentMethod.isNotEmpty) ...[
            const Divider(color: AppColors.primaryappbrown, height: 24),
            OrderInfoRow(
              label: 'Payment Method',
              value: order.paymentMethod,
              icon: Iconsax.card,
            ),
          ],
          if (order.shippingAddress.isNotEmpty) ...[
            const Divider(color: AppColors.primaryappbrown, height: 24),
            OrderInfoRow(
              label: 'Shipping To',
              value: order.shippingAddress,
              icon: Iconsax.location,
            ),
          ],
          if (order.expectedDelivery.isNotEmpty) ...[
            const Divider(color: AppColors.primaryappbrown, height: 24),
            OrderInfoRow(
              label: 'Expected Delivery',
              value: order.expectedDelivery,
              icon: Iconsax.timer,
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        ProElevatedButton(
          onPressed: () {},
          text: 'Track Order',
          leadingIcon: Iconsax.location,
          backgroundColor: AppColors.secondary,
          textColor: AppColors.white,
          fontSize: AppTextStyle.lg,
          borderRadius: 16,
          showGlow: true,
          glowColor: AppColors.secondary.withValues(alpha: 0.4),
        ),
        const SizedBox(height: 12),
        ProElevatedButton(
          onPressed: () {
            Get.back();
          },
          text: 'Back to Orders',
          leadingIcon: Iconsax.arrow_left,
          backgroundColor: Colors.transparent,
          textColor: AppColors.white,
          fontSize: AppTextStyle.lg,
          borderRadius: 16,
          border: const BorderSide(
            color: AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
        ),
      ],
    );
  }
}
