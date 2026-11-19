import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_revenue_model.dart';
import 'seller_request_payment_screen.dart';

class SellerPayoutDetailScreen extends StatelessWidget {
  final SellerTransactionModel transaction;

  const SellerPayoutDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> timelineSteps = [
      {'title': 'Order Completed', 'isCompleted': true, 'isActive': false},
      {'title': 'Delivery Confirmed', 'isCompleted': true, 'isActive': false},
      {'title': 'Payment Released', 'isCompleted': false, 'isActive': true},
      {
        'title': 'Sent to Mobile Money',
        'isCompleted': false,
        'isActive': false,
      },
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
          'Payout in progress',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),

                    // Top center yellow clock icon with subtle glow
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B2800),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFF5A623).withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.access_time,
                          color: Color(0xFFF5A623),
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Header & Subtitle
                    Text(
                      'Payout in progress',
                      style: AppTextStyle(
                        context,
                      ).boldTextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Your earnings will be released after delivery confirmation.',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Details Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22140A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            context,
                            'Product',
                            transaction.productTitle,
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(context, 'Order ID', transaction.id),
                          const SizedBox(height: 10),
                          _buildDetailRow(
                            context,
                            'Order Delivered',
                            transaction.orderDelivered,
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(
                            context,
                            'Amount',
                            transaction.formattedAmount,
                            isGold: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Timeline Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Timeline',
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.primarytext,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22140A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: timelineSteps.length,
                        itemBuilder: (context, index) {
                          final step = timelineSteps[index];
                          final isLast = index == timelineSteps.length - 1;
                          final isCompleted = step['isCompleted'] as bool;
                          final isActive = step['isActive'] as bool;

                          return IntrinsicHeight(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    _buildTimelineDot(
                                      isCompleted: isCompleted,
                                      isActive: isActive,
                                    ),
                                    if (!isLast)
                                      Expanded(
                                        child: Container(
                                          width: 2,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          color: isCompleted
                                              ? const Color(0xFF4CAF50)
                                              : Colors.white12,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: Text(
                                    step['title'] as String,
                                    style: AppTextStyle(context)
                                        .mediumTextStyle(
                                          color: (isCompleted || isActive)
                                              ? Colors.white
                                              : AppColors.primarytext
                                                    .withValues(alpha: 0.45),
                                          fontSize: 13,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Info disclaimer footer
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.primarytext,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Payments are usually settled within 2-3 business days after successful delivery.',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext.withValues(
                                alpha: 0.7,
                              ),
                              fontSize: 11,
                              lineHeight: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Request Payment Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () =>
                          SellerRequestPaymentScreen(transaction: transaction),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Request Payment',
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineDot({
    required bool isCompleted,
    required bool isActive,
  }) {
    if (isCompleted) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Color(0xFF1B4324),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Color(0xFF4CAF50), size: 13),
      );
    } else if (isActive) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFF5A623), width: 2),
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFF5A623),
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
            color: Colors.white.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
      );
    }
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isGold = false,
  }) {
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
          style: isGold
              ? AppTextStyle(
                  context,
                ).boldTextStyle(color: const Color(0xFFF5A623), fontSize: 13)
              : AppTextStyle(
                  context,
                ).mediumTextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
