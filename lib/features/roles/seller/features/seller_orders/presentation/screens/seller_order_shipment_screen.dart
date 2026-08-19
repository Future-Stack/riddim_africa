import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_order_model.dart';
import '../controllers/seller_order_shipment_controller.dart';
import 'seller_order_completed_screen.dart';

class SellerOrderShipmentScreen extends StatelessWidget {
  final SellerOrderModel order;

  const SellerOrderShipmentScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SellerOrderShipmentController());

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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Summary Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22140A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              order.productImage,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 50,
                                height: 50,
                                color: Colors.white10,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.white38,
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
                                  order.productTitle,
                                  style: AppTextStyle(context).boldTextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  order.productCode,
                                  style: AppTextStyle(context).regularTextStyle(
                                    color: AppColors.primarytext
                                        .withValues(alpha: 0.7),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                    const SizedBox(height: 16),

                    // Ship To (Riddim Africa Office) Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E190B),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ship To (Riddim Africa Office)',
                            style: AppTextStyle(context).boldTextStyle(
                              color: const Color(0xFFE6B650),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            order.shippingAddress,
                            style: AppTextStyle(context).regularTextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Send the product to our office within 48 hours',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext.withValues(alpha: 0.7),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Package Date Form Field
                    Text(
                      'Package Date',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () => c.pickPackageDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22140A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                c.formattedPackageDate,
                                style: AppTextStyle(context).regularTextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.primarytext,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Estimated Delivery Form Field
                    Text(
                      'Estimated Delivery',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF22140A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: TextField(
                        controller: c.estimatedDeliveryController,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'e.g. 2-3 days',
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Notes to Courier
                    Text(
                      'Notes to Courier',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF22140A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: TextField(
                        controller: c.notesController,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Fragile, handle with care...',
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Before You Ship Checklist
                    Text(
                      'Before You Ship',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),

                    _buildChecklistItem(
                      context,
                      title: 'Product is new and undamaged',
                      rxVal: c.isUndamagedChecked,
                      onTap: c.toggleUndamaged,
                    ),
                    const SizedBox(height: 8),
                    _buildChecklistItem(
                      context,
                      title: 'Securely wrapped / boxed',
                      rxVal: c.isSecurelyWrappedChecked,
                      onTap: c.toggleSecurelyWrapped,
                    ),
                    const SizedBox(height: 8),
                    _buildChecklistItem(
                      context,
                      title: 'Order ID written on package: #${order.id}',
                      rxVal: c.isOrderIdWrittenChecked,
                      onTap: c.toggleOrderIdWritten,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Confirm Shipment Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => SellerOrderCompletedScreen(order: order));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Confirm Shipment',
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
    );
  }

  Widget _buildChecklistItem(
    BuildContext context, {
    required String title,
    required RxBool rxVal,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Obx(
            () => Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: rxVal.value
                    ? const Color(0xFFE65100)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: rxVal.value
                      ? const Color(0xFFE65100)
                      : Colors.white38,
                  width: 1.5,
                ),
              ),
              child: rxVal.value
                  ? const Icon(Icons.check, color: Colors.white, size: 13)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: AppTextStyle(context).regularTextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
