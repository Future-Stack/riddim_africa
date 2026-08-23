import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_revenue_controller.dart';
import '../widgets/artist_transaction_card.dart';

class ArtistRevenueTransactionsScreen extends StatelessWidget {
  const ArtistRevenueTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ArtistRevenueController>();

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
          'Revenue',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18.sp),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ─── Top Underline Tab Bar ─────────────────────────────────────
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.cardBorder.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _buildUnderlineTab(
                      title: 'Settled to Mobile money',
                      isSelected: controller.selectedTab.value == 0,
                      onTap: () => controller.setTab(0),
                    ),
                    _buildUnderlineTab(
                      title: 'Payout in progress',
                      isSelected: controller.selectedTab.value == 1,
                      onTap: () => controller.setTab(1),
                    ),
                  ],
                ),
              ),
            ),
            14.verticalSpace,

            // ─── Body Content ──────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Dual Stat Hero Card (Images 4 & 5) - Compact Height
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.revenueCardGradient,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.cardBorder.withValues(alpha: 0.35),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.white.withValues(
                                      alpha: 0.08,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Settled to Mobile money',
                                      style: AppTextStyle(context)
                                          .boldTextStyle(
                                            color: AppColors.onboardingtext,
                                            fontSize: 10.5.sp,
                                          ),
                                    ),
                                    6.verticalSpace,
                                    Obx(
                                      () => Text(
                                        controller.formattedSettledRevenue,
                                        style: AppTextStyle(context)
                                            .boldTextStyle(
                                              color: AppColors.white,
                                              fontSize: 15.sp,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.white.withValues(
                                      alpha: 0.08,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Payout in progress',
                                      style: AppTextStyle(context)
                                          .boldTextStyle(
                                            color: AppColors.onboardingtext,
                                            fontSize: 10.5.sp,
                                          ),
                                    ),
                                    6.verticalSpace,
                                    Obx(
                                      () => Text(
                                        controller.formattedPayoutInProgress,
                                        style: AppTextStyle(context)
                                            .boldTextStyle(
                                              color: AppColors.white,
                                              fontSize: 15.sp,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    16.verticalSpace,

                    // ─── Filtered Transaction List ─────────────────────────
                    Obx(() {
                      final list = controller.currentTabTransactions;
                      if (list.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Center(
                            child: Text(
                              'No transactions found',
                              style: AppTextStyle(context).regularTextStyle(
                                color: AppColors.primarytext,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final tx = list[index];
                          return ArtistTransactionCard(transaction: tx);
                        },
                      );
                    }),
                    20.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnderlineTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? AppColors.tabUnderlineTeal
                    : AppColors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.primarytext,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Satoshi',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
