import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_transaction_entity.dart';

class ArtistPaymentDetailsScreen extends StatelessWidget {
  final ArtistTransactionEntity transaction;

  const ArtistPaymentDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,##0', 'en_US');

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
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
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
            fontSize: 18.sp,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Top Main Card (Product + Info Rows) ─────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.cardBorder.withValues(alpha: 0.35),
                  ),
                ),
                child: Column(
                  children: [
                    // Product Header Row
                    Padding(
                      padding: EdgeInsets.all(14.w),
                      child: Row(
                        children: [
                          Container(
                            width: 46.w,
                            height: 46.w,
                            decoration: BoxDecoration(
                              color: AppColors.tealDark,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.north_east,
                                color: AppColors.greenBright,
                                size: 22.sp,
                              ),
                            ),
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.productTitle,
                                  style: AppTextStyle(context).boldTextStyle(
                                    color: AppColors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  transaction.id,
                                  style: AppTextStyle(context).regularTextStyle(
                                    color: AppColors.primarytext,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildCardDivider(),

                    // Details Rows
                    _buildDetailsItem('Order ID', transaction.id),
                    _buildCardDivider(),
                    _buildDetailsItem(
                      'Order Delivered',
                      transaction.orderDeliveredDate.isNotEmpty
                          ? transaction.orderDeliveredDate
                          : 'Jun 8, 2026 · 2:14 PM',
                    ),
                    _buildCardDivider(),
                    _buildDetailsItem(
                      'Payment Method',
                      transaction.paymentMethod,
                    ),
                    _buildCardDivider(),
                    _buildDetailsItem(
                      'Payment Received',
                      transaction.paymentReceivedDate.isNotEmpty
                          ? transaction.paymentReceivedDate
                          : 'Jun 12, 2026 · 2:14 PM',
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // ─── Revenue Breakdown Card ──────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.cardBorder.withValues(alpha: 0.35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      child: Text(
                        'Revenue Breakdown',
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.goldText,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    _buildCardDivider(),
                    _buildBreakdownItem(
                      'Order Revenue',
                      'UGX ${currencyFormatter.format(transaction.grossRevenue)}',
                      AppColors.white,
                    ),
                    _buildCardDivider(),
                    _buildBreakdownItem(
                      'Platform Commission',
                      '-UGX ${currencyFormatter.format(transaction.commission)}',
                      AppColors.error,
                    ),
                    _buildCardDivider(),
                    _buildBreakdownItem(
                      'Net Earnings',
                      'UGX ${currencyFormatter.format(transaction.netAmount)}',
                      AppColors.greenBright,
                      isBold: true,
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // ─── Status Timeline Card (Image 3) ──────────────────────────
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.cardBorder.withValues(alpha: 0.35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status Timeline',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.goldText,
                        fontSize: 14.sp,
                      ),
                    ),
                    14.verticalSpace,
                    _buildCardDivider(),
                    14.verticalSpace,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: timelineSteps.length,
                      itemBuilder: (context, index) {
                        final isLast = index == timelineSteps.length - 1;
                        return IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.greenBright,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 16.w,
                                        height: 16.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.greenBright
                                                .withValues(alpha: 0.7),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.greenBright,
                                          size: 11.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!isLast)
                                    Expanded(
                                      child: Container(
                                        width: 1.5,
                                        margin: EdgeInsets.symmetric(
                                          vertical: 3.h,
                                        ),
                                        color: AppColors.greenBright,
                                      ),
                                    ),
                                ],
                              ),
                              14.horizontalSpace,
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text(
                                    timelineSteps[index],
                                    style: AppTextStyle(context).regularTextStyle(
                                      color: AppColors.white,
                                      fontSize: 13.5.sp,
                                    ),
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
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.cardBorder.withValues(alpha: 0.2),
    );
  }

  Widget _buildDetailsItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.primarytext,
              fontSize: 13.sp,
              fontFamily: 'Satoshi',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(
    String label,
    String value,
    Color valueColor, {
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isBold ? AppColors.white : AppColors.primarytext,
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Satoshi',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontFamily: 'Satoshi',
            ),
          ),
        ],
      ),
    );
  }
}
