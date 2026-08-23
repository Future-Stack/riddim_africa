import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/controllers/artist_bottom_nav_controller.dart';
import '../controllers/artist_revenue_controller.dart';
import '../screens/artist_revenue_screen.dart';
import '../screens/artist_revenue_transactions_screen.dart';

class ArtistRevenueHeroCard extends StatelessWidget {
  final double? totalRevenue;
  final double? growthPercentage;
  final double? settledRevenue;
  final double? payoutInProgress;
  final VoidCallback? onCardTap;
  final VoidCallback? onSettledTap;
  final VoidCallback? onPayoutTap;

  const ArtistRevenueHeroCard({
    super.key,
    this.totalRevenue,
    this.growthPercentage,
    this.settledRevenue,
    this.payoutInProgress,
    this.onCardTap,
    this.onSettledTap,
    this.onPayoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,##0', 'en_US');

    return GestureDetector(
      onTap:
          onCardTap ??
          () {
            if (Get.isRegistered<ArtistBottomNavController>()) {
              Get.find<ArtistBottomNavController>().changeIndex(3);
            } else {
              Get.to(() => const ArtistRevenueScreen());
            }
          },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          gradient: AppColors.revenueCardGradient,

          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Subtitle: "Total Revenue of this month" ───────────────────
            Text(
              'Total Revenue of this month',
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.onboardingtext, fontSize: 12.sp),
            ),
            5.verticalSpace,

            // ─── Total Revenue Amount ──────────────────────────────────────
            _buildTotalAmount(currencyFormatter, context),
            6.verticalSpace,

            // ─── Growth Badge Pill (Directly Underneath Amount) ─────────────
            _buildGrowthBadge(context),
            14.verticalSpace,

            // ─── Two Equal Sub-cards (Settled & Payout) ─────────────────────
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Settled Card
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          onSettledTap ??
                          () {
                            if (Get.isRegistered<ArtistRevenueController>()) {
                              Get.find<ArtistRevenueController>().setTab(0);
                            }
                            Get.to(
                              () => const ArtistRevenueTransactionsScreen(),
                            );
                          },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              'Settled to Mobile money',
                              style: AppTextStyle(context).getTextStyle(
                                color: AppColors.textfieldelementcolor,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            6.verticalSpace,
                            _buildSettledAmount(currencyFormatter, context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  10.horizontalSpace,

                  // Payout in Progress Card
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          onPayoutTap ??
                          () {
                            if (Get.isRegistered<ArtistRevenueController>()) {
                              Get.find<ArtistRevenueController>().setTab(1);
                            }
                            Get.to(
                              () => const ArtistRevenueTransactionsScreen(),
                            );
                          },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payout in progress',
                              style: AppTextStyle(context).getTextStyle(
                                color: AppColors.textfieldelementcolor,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            6.verticalSpace,
                            _buildPayoutAmount(currencyFormatter, context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmount(NumberFormat formatter, BuildContext context) {
    if (totalRevenue != null) {
      return Text(
        'UGX ${formatter.format(totalRevenue)}',
        style: AppTextStyle(
          context,
        ).boldTextStyle(color: AppColors.white, fontSize: 25.sp),
      );
    }
    if (Get.isRegistered<ArtistRevenueController>()) {
      final c = Get.find<ArtistRevenueController>();
      return Obx(
        () => Text(
          c.formattedTotalRevenue,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 25.sp),
        ),
      );
    }
    return Text(
      'UGX ${formatter.format(234500.0)}',
      style: AppTextStyle(
        context,
      ).boldTextStyle(color: AppColors.white, fontSize: 25.sp),
    );
  }

  Widget _buildGrowthBadge(BuildContext context) {
    if (growthPercentage != null) {
      return _renderBadge(
        '↗ ${growthPercentage!.toStringAsFixed(0)}% this month',
      );
    }
    if (Get.isRegistered<ArtistRevenueController>()) {
      final c = Get.find<ArtistRevenueController>();
      return Obx(() {
        final growth = c.revenueStats.value?.revenueGrowthPercentage ?? 18.0;
        return _renderBadge('↗ ${growth.toStringAsFixed(0)}% this month');
      });
    }
    return _renderBadge('↗ 18% this month');
  }

  Widget _renderBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.5.h),
      decoration: BoxDecoration(
        color: const Color(0xFF133829),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.trending_up, color: AppColors.greenBright, size: 13.sp),
          4.horizontalSpace,
          Text(
            text.replaceFirst('↗ ', ''),
            style: TextStyle(
              color: AppColors.greenBright,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Satoshi',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettledAmount(NumberFormat formatter, BuildContext context) {
    if (settledRevenue != null) {
      return Text(
        'UGX ${formatter.format(settledRevenue)}',
        style: AppTextStyle(context).getTextStyle(
          color: AppColors.white,
          fontSize: 15.5.sp,
          fontWeight: FontWeight.w800,
        ),
      );
    }
    if (Get.isRegistered<ArtistRevenueController>()) {
      final c = Get.find<ArtistRevenueController>();
      return Obx(
        () => Text(
          c.formattedSettledRevenue,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 15.5.sp),
        ),
      );
    }
    return Text(
      'UGX ${formatter.format(189200.0)}',
      style: AppTextStyle(
        context,
      ).boldTextStyle(color: AppColors.white, fontSize: 15.5.sp),
    );
  }

  Widget _buildPayoutAmount(NumberFormat formatter, BuildContext context) {
    if (payoutInProgress != null) {
      return Text(
        'UGX ${formatter.format(payoutInProgress)}',
        style: AppTextStyle(context).getTextStyle(
          color: AppColors.white,
          fontSize: 15.5.sp,
          fontWeight: FontWeight.w800,
        ),
      );
    }
    if (Get.isRegistered<ArtistRevenueController>()) {
      final c = Get.find<ArtistRevenueController>();
      return Obx(
        () => Text(
          c.formattedPayoutInProgress,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 15.5.sp),
        ),
      );
    }
    return Text(
      'UGX ${formatter.format(45300.0)}',
      style: AppTextStyle(
        context,
      ).boldTextStyle(color: AppColors.white, fontSize: 15.5.sp),
    );
  }
}
