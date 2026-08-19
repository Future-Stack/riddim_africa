import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_order_model.dart';
import 'seller_order_tracking_screen.dart';

class SellerNewOrderAlertScreen extends StatelessWidget {
  final SellerOrderModel order;

  const SellerNewOrderAlertScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
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
        title: Text(
          'New Order',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Bag Icon with Badge
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A1C14),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Color(0xFF388E3C),
                        size: 36,
                      ),
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE65100),
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Title & Subtitle
              Text(
                'New Order!',
                style: AppTextStyle(context).boldTextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'You have a new order from ${order.customerName}',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Product Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF22140A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  children: [
                    // Product Image & Title
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            order.productImage,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 60,
                              height: 60,
                              color: Colors.white10,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.white38,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.productTitle,
                                style: AppTextStyle(context).boldTextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                order.price,
                                style: AppTextStyle(context).boldTextStyle(
                                  color: const Color(0xFFF5A623),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0x1AFFFFFF)),
                    const SizedBox(height: 14),

                    // Key details rows
                    _buildDetailRow(context, 'Customer', order.customerName),
                    const SizedBox(height: 10),
                    _buildDetailRow(context, 'Order Time', order.orderTime),
                    const SizedBox(height: 10),
                    _buildDetailRow(context, 'Payment', order.paymentMethod),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // Bottom Button: Ready for Shipment
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => SellerOrderTrackingScreen(order: order));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Ready for Shipment',
                      style: AppTextStyle(context).boldTextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle(context).regularTextStyle(
            color: AppColors.primarytext.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: AppTextStyle(context).mediumTextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
