import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_transaction_entity.dart';
import '../screens/artist_payment_details_screen.dart';
import '../screens/artist_payout_detail_screen.dart';

class ArtistTransactionCard extends StatelessWidget {
  final ArtistTransactionEntity transaction;

  const ArtistTransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isSettled = transaction.status == ArtistTransactionStatus.settled;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.cardBorder.withValues(alpha: 0.35),
        ),
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            if (isSettled) {
              Get.to(() => ArtistPaymentDetailsScreen(transaction: transaction));
            } else {
              Get.to(() => ArtistPayoutDetailScreen(transaction: transaction));
            }
          },
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Leading Icon Box ──────────────────────────────────────
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: isSettled
                        ? AppColors.tealDark
                        : AppColors.amberDeep,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Icon(
                      isSettled ? Icons.north_east : Icons.access_time_rounded,
                      color: isSettled
                          ? AppColors.greenBright
                          : AppColors.amberBright,
                      size: 22.sp,
                    ),
                  ),
                ),
                12.horizontalSpace,

                // ─── Middle Column: Title, ID, Date, Status Pill ───────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.productTitle,
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      3.verticalSpace,
                      Text(
                        transaction.id,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: 11.sp,
                        ),
                      ),
                      2.verticalSpace,
                      Text(
                        transaction.date,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext.withValues(alpha: 0.7),
                          fontSize: 10.sp,
                        ),
                      ),
                      6.verticalSpace,

                      // Status Badge Pill
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSettled
                              ? AppColors.greenDark
                              : AppColors.amberDark,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSettled
                                  ? Icons.check_circle_outline_rounded
                                  : Icons.access_time_rounded,
                              size: 11.sp,
                              color: isSettled
                                  ? AppColors.greenBright
                                  : AppColors.amberBright,
                            ),
                            5.horizontalSpace,
                            Text(
                              isSettled
                                  ? 'Payment Received'
                                  : 'Payout in Progress',
                              style: TextStyle(
                                color: isSettled
                                    ? AppColors.greenBright
                                    : AppColors.amberBright,
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                8.horizontalSpace,

                // ─── Trailing Amount ───────────────────────────────────────
                Text(
                  transaction.formattedAmount,
                  style: AppTextStyle(context).boldTextStyle(
                    color: isSettled
                        ? AppColors.greenBright
                        : AppColors.amberBright,
                    fontSize: 13.5.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
