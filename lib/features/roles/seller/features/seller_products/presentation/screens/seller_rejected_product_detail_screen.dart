import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/seller_product_detail_controller.dart';
import '../widgets/seller_product_item_card.dart';

class SellerRejectedProductDetailScreen extends GetView<SellerProductDetailController> {
  const SellerRejectedProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.isRegistered<SellerProductDetailController>()
        ? Get.find<SellerProductDetailController>()
        : Get.put(SellerProductDetailController());

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
          'My Products',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
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
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final product = c.product.value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Card
              SellerProductItemCard(
                product: product,
                onTap: () {},
              ),
              const SizedBox(height: 12),

              // Reason for Rejection Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for Rejection',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.rejectionReason ??
                          'Your product listing did not meet our marketplace quality standards.',
                      style: AppTextStyle(context).regularTextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        lineHeight: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: AppColors.primarytext,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Submitted ${product.rejectedAt ?? 'June 12, 2026 at 10:34 AM'}',
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext.withValues(alpha: 0.8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Edit & Resubmit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => c.navigateToEditSubmission(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBB483D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Edit & Resubmit Product',
                    style: AppTextStyle(context).boldTextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}
