import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_transaction_entity.dart';
import 'artist_request_payment_screen.dart';

class ArtistPayoutDetailScreen extends StatelessWidget {
  final ArtistTransactionEntity transaction;

  const ArtistPayoutDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
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
          'Payout in progress',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.verticalSpace,

              // ─── Center Clock Icon ───────────────────────────────────────
              Center(
                child: Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: AppColors.amberDeep,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.amberBright.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.access_time_rounded,
                      color: AppColors.amberBright,
                      size: 38.sp,
                    ),
                  ),
                ),
              ),
              18.verticalSpace,

              // ─── Title & Subtitle ────────────────────────────────────────
              Text(
                'Payout in progress',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 20.sp,
                ),
              ),
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Your earnings will be released after\ndelivery confirmation.',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 13.sp,
                    lineHeight: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              28.verticalSpace,

              // ─── Details Card (Image 2) ──────────────────────────────────
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
                    _buildRowItem(
                      'Product',
                      transaction.productTitle,
                    ),
                    _buildCardDivider(),
                    _buildRowItem(
                      'Order ID',
                      transaction.date.isNotEmpty
                          ? transaction.date
                          : '6th May, 2026',
                    ),
                    _buildCardDivider(),
                    _buildRowItem(
                      'Order Delivered',
                      transaction.id.isNotEmpty
                          ? transaction.id
                          : 'PRD ID: 5454',
                    ),
                    _buildCardDivider(),
                    _buildRowItem(
                      'Amount',
                      transaction.formattedAmount.isNotEmpty
                          ? transaction.formattedAmount
                          : 'UGX 165,000',
                    ),
                  ],
                ),
              ),
              32.verticalSpace,

              // ─── Request Payment Action ──────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => ArtistRequestPaymentScreen(transaction: transaction),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Request Payment',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
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

  Widget _buildRowItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
}
