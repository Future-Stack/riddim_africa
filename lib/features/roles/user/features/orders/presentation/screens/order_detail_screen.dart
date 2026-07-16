import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/order_detail_controller.dart';
import '../widgets/tracking_timeline.dart';
import '../widgets/orders_app_bar.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: OrdersAppBar(
        titleWidget: Obx(() {
          final order = controller.order.value;
          if (order == null) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order ${order.orderNumber}',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.lg,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatDate(order.orderDate),
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: AppTextStyle.xs,
                ),
              ),
            ],
          );
        }),
        actions: [
          Obx(() {
            final order = controller.order.value;
            if (order == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(child: _buildStatusBadge(context, order)),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.onboardingbutton),
          );
        }

        final order = controller.order.value;
        if (order == null) {
          return const Center(child: Text('Order not found'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductCard(context, order),
              const SizedBox(height: 16),
              _buildDeliveryDetailsCard(context, order),
              const SizedBox(height: 16),
              _buildTrackingCard(context),
              const SizedBox(height: 24),
              _buildActionButtons(context, order),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatusBadge(BuildContext context, dynamic order) {
    Color bgColor;
    Color textColor;
    final status = order.statusLabel.toLowerCase();

    if (status == 'delivered') {
      bgColor = AppColors.success.withValues(alpha: 0.15);
      textColor = AppColors.success;
    } else if (status == 'cancelled' || status == 'canceled') {
      bgColor = AppColors.error.withValues(alpha: 0.15);
      textColor = AppColors.error;
    } else if (status == 'out for delivery') {
      bgColor = AppColors.onboardingbutton.withValues(alpha: 0.15);
      textColor = AppColors.onboardingbutton;
    } else {
      bgColor = AppColors.warning.withValues(alpha: 0.15);
      textColor = AppColors.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        order.statusLabel,
        style: AppTextStyle(
          context,
        ).boldTextStyle(color: textColor, fontSize: AppTextStyle.xs),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, dynamic order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryappbrownsecond, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                order.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.primaryappbrownsecond,
                  child: const Icon(
                    Iconsax.image,
                    color: AppColors.primarytext,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.white,
                          fontSize: AppTextStyle.md,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Qty: ${order.quantity}',
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: AppTextStyle.sm,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (order.selectedColor != null ||
                          order.selectedSize != null)
                        Text(
                          'Color: ${order.selectedColor ?? 'N/A'}    Size: ${order.selectedSize ?? 'N/A'}',
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext,
                            fontSize: AppTextStyle.sm,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  order.price,
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: AppTextStyle.md,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetailsCard(BuildContext context, dynamic order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryappbrownsecond, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DELIVERY DETAILS',
            style: AppTextStyle(context).boldTextStyle(
              color: AppColors.primarytext,
              fontSize: AppTextStyle.sm,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            order.shippingAddress.isNotEmpty
                ? order.shippingAddress
                : 'Plot 12, Buganda Road, Kampala',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: AppTextStyle.md),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery fee',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: AppTextStyle.md,
                ),
              ),
              Text(
                order.deliveryFee,
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.onboardingbutton,
                  fontSize: AppTextStyle.md,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order total',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.md,
                ),
              ),
              Text(
                order.totalPrice.isNotEmpty ? order.totalPrice : order.price,
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.onboardingbutton,
                  fontSize: AppTextStyle.lg,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryappbrownsecond, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tracking Timeline',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: AppTextStyle.md),
          ),
          const SizedBox(height: 16),
          TrackingTimeline(events: controller.trackingEvents),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, dynamic order) {
    final status = order.statusLabel.toLowerCase();

    if (status == 'cancelled' || status == 'canceled') {
      return const SizedBox.shrink();
    }

    if (status == 'delivered') {
      // If delivered, show Add Review directly
      return ProElevatedButton(
        text: 'Add Review',
        backgroundColor: const Color(0xFFA13C33), // red/brown
        textColor: AppColors.white,
        borderRadius: 16,
        onPressed: () {
          Get.toNamed('/orderReview', arguments: order);
        },
      );
    }

    return Row(
      children: [
        Expanded(
          child: ProElevatedButton(
            text: 'Mark as Received',
            backgroundColor: const Color(0xFFCCA13E), // Gold
            textColor: AppColors.white,
            borderRadius: 16,
            onPressed: () {
              _showConfirmReceiptPopup(context);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ProElevatedButton(
            text: 'Cancel Order',
            backgroundColor: const Color(0xFFA13C33), // Red
            textColor: AppColors.white,
            borderRadius: 16,
            onPressed: () {
              _showCancelOrderPopup(context);
            },
          ),
        ),
      ],
    );
  }

  void _showConfirmReceiptPopup(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.primaryappbrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
        ),
        title: Text(
          'Confirm Receipt',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: AppTextStyle.lg),
        ),
        content: Text(
          'Are you sure you have received your order?',
          style: AppTextStyle(context).regularTextStyle(
            color: AppColors.primarytext,
            fontSize: AppTextStyle.md,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyle(
                context,
              ).semiBoldTextStyle(color: AppColors.primarytext),
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await controller.confirmDelivery();
              Get.toNamed('/orderConfirmed', arguments: controller.order.value);
            },
            child: Text(
              'Confirm',
              style: AppTextStyle(
                context,
              ).semiBoldTextStyle(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelOrderPopup(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.primaryappbrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
        ),
        title: Text(
          'Cancel Order',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: AppTextStyle.lg),
        ),
        content: Text(
          'Are you sure you want to cancel this order?',
          style: AppTextStyle(context).regularTextStyle(
            color: AppColors.primarytext,
            fontSize: AppTextStyle.md,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'No',
              style: AppTextStyle(
                context,
              ).semiBoldTextStyle(color: AppColors.primarytext),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.cancelOrder();
            },
            child: Text(
              'Yes, Cancel',
              style: AppTextStyle(
                context,
              ).semiBoldTextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const allMonths = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${allMonths[date.month - 1]} ${date.day}, ${date.year}';
  }
}
