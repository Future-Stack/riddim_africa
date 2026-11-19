import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/artist_order_model.dart';

class ArtistOrderCancelledDetailScreen extends StatelessWidget {
  final ArtistOrderModel order;

  const ArtistOrderCancelledDetailScreen({super.key, required this.order});

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
          'Order RA-2026-47281',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CANCELED ON DATE
              Center(
                child: Text(
                  'CANCELED ON: APR 12, 2026 AT 10:14 AM',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext.withValues(alpha: 0.6),
                    fontSize: 11,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // PRODUCT HEADER
              Text(
                'PRODUCT',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.primarytext.withValues(alpha: 0.7),
                  fontSize: 11,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),

              // Product Info Card
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
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                          width: 56,
                          height: 56,
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
                            '${order.productCode} • Qty: ${order.quantity}',
                            style: AppTextStyle(context).regularTextStyle(
                              color:
                                  AppColors.primarytext.withValues(alpha: 0.7),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B1414),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '• Cancelled',
                            style: TextStyle(
                              color: Color(0xFFE53935),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
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
              const SizedBox(height: 20),

              // Reason for Cancellation Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF22140A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for Cancellation:',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '"${order.cancellationReason ?? 'Product doesn\'t match my expectations. The colour shown in the listing photo was different from what I received.'}"',
                      style: AppTextStyle(context).regularTextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        lineHeight: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Date: ${order.cancellationDate ?? 'Wed, June 12, 2024 • 10:14 AM'}',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Evidence Uploaded by Buyer Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF22140A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Evidence Uploaded by Buyer',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Photos Row
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            order.buyerEvidenceImages.isNotEmpty
                                ? order.buyerEvidenceImages[0]
                                : 'https://images.unsplash.com/photo-1590736969955-71cc94801759?w=300',
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            order.buyerEvidenceImages.length > 1
                                ? order.buyerEvidenceImages[1]
                                : 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=300',
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
