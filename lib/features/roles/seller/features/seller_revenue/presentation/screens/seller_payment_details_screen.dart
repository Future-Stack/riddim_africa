import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_revenue_model.dart';

class SellerPaymentDetailsScreen extends StatelessWidget {
  final SellerTransactionModel transaction;

  const SellerPaymentDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final List<String> timelineSteps = [
      'Order Completed',
      'Delivery Confirmed',
      'Payment Released',
      'Sent to Mobile Money',
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
          'Payment Details',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18,
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
              // Product Card
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
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B3B2B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          transaction.iconLetter,
                          style: const TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                            transaction.productTitle,
                            style: AppTextStyle(context).boldTextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            transaction.id,
                            style: AppTextStyle(context).regularTextStyle(
                              color:
                                  AppColors.primarytext.withValues(alpha: 0.7),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Details Info Card
              Container(
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
                    _buildInfoRow(context, 'Order ID', transaction.id),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      context,
                      'Order Delivered',
                      transaction.orderDelivered,
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      context,
                      'Payment Method',
                      transaction.paymentMethod,
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      context,
                      'Payment Received',
                      transaction.paymentReceived,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Revenue Breakdown Card
              Text(
                'Revenue Breakdown',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Container(
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
                    _buildBreakdownRow(
                      context,
                      'Order Revenue',
                      transaction.grossRevenue,
                      Colors.white,
                    ),
                    const SizedBox(height: 10),
                    _buildBreakdownRow(
                      context,
                      'Platform Commission',
                      transaction.commission,
                      const Color(0xFFE53935),
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0x1AFFFFFF)),
                    const SizedBox(height: 12),
                    _buildBreakdownRow(
                      context,
                      'Net Earnings',
                      transaction.netAmount,
                      const Color(0xFFF5A623),
                      isBold: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Status Timeline Card
              Text(
                'Status Timeline',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Container(
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
                    final isLast = index == timelineSteps.length - 1;
                    return IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1B4324),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Color(0xFF4CAF50),
                                  size: 13,
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 3,
                                    ),
                                    color: const Color(0xFF4CAF50),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Text(
                              timelineSteps[index],
                              style: AppTextStyle(context).mediumTextStyle(
                                color: Colors.white,
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
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

  Widget _buildBreakdownRow(
    BuildContext context,
    String label,
    String value,
    Color valueColor, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppTextStyle(context).boldTextStyle(
                  color: Colors.white,
                  fontSize: 13,
                )
              : AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
        ),
        Text(
          value,
          style: isBold
              ? AppTextStyle(context).boldTextStyle(
                  color: valueColor,
                  fontSize: 14,
                )
              : AppTextStyle(context).mediumTextStyle(
                  color: valueColor,
                  fontSize: 12,
                ),
        ),
      ],
    );
  }
}
