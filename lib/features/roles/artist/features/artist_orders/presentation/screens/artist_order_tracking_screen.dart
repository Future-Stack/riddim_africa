import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/artist_order_model.dart';
import 'artist_order_shipment_screen.dart';

class ArtistOrderTrackingScreen extends StatelessWidget {
  final ArtistOrderModel order;

  const ArtistOrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> trackingSteps = [
      {'title': 'Order Placed', 'isCompleted': true, 'isActive': false},
      {'title': 'Payment Confirmed', 'isCompleted': true, 'isActive': false},
      {'title': 'Shipped', 'isCompleted': false, 'isActive': true},
      {'title': 'Received at Office', 'isCompleted': false, 'isActive': false},
      {'title': 'Quality Inspection', 'isCompleted': false, 'isActive': false},
      {'title': 'Dispatched', 'isCompleted': false, 'isActive': false},
      {'title': 'Delivered', 'isCompleted': false, 'isActive': false},
    ];

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
                    // Top Product Mini Card
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
                              width: 54,
                              height: 54,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 54,
                                height: 54,
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
                    const SizedBox(height: 24),

                    // ORDER STATUS header
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 16.0),
                      child: Text(
                        'ORDER STATUS',
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.primarytext.withValues(alpha: 0.8),
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),

                    // Vertical Timeline List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: trackingSteps.length,
                      itemBuilder: (context, index) {
                        final step = trackingSteps[index];
                        final bool isLast = index == trackingSteps.length - 1;
                        final bool isCompleted = step['isCompleted'] as bool;
                        final bool isActive = step['isActive'] as bool;

                        return IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Timeline node & connecting line
                              SizedBox(
                                width: 28,
                                child: Column(
                                  children: [
                                    _buildTimelineIndicator(
                                      isCompleted: isCompleted,
                                      isActive: isActive,
                                    ),
                                    if (!isLast)
                                      Expanded(
                                        child: Container(
                                          width: 2,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          color: isCompleted
                                              ? const Color(0xFFBB483D)
                                              : Colors.white.withValues(alpha: 0.15),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Step Title
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: Text(
                                  step['title'] as String,
                                  style: AppTextStyle(context).mediumTextStyle(
                                    color: (isCompleted || isActive)
                                        ? Colors.white
                                        : AppColors.primarytext
                                            .withValues(alpha: 0.5),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CTA Button: Ship Now
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => ArtistOrderShipmentScreen(order: order));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Ship Now',
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

  Widget _buildTimelineIndicator({
    required bool isCompleted,
    required bool isActive,
  }) {
    if (isCompleted) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Color(0xFFBB483D),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 13,
        ),
      );
    } else if (isActive) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFBB483D), width: 2),
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFBB483D),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 2,
          ),
        ),
      );
    }
  }
}
