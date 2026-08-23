import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_revenue_controller.dart';
import '../widgets/artist_revenue_hero_card.dart';
import '../widgets/artist_earning_analytics_chart.dart';
import '../widgets/artist_transaction_card.dart';
import 'artist_revenue_transactions_screen.dart';

class ArtistRevenueScreen extends StatelessWidget {
  const ArtistRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistRevenueController>()
        ? Get.find<ArtistRevenueController>()
        : Get.find<ArtistRevenueController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
        leading: Navigator.canPop(context)
            ? Padding(
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
              )
            : null,
        title: Text(
          'Revenue',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.secondary,
          backgroundColor: AppColors.primaryappbrown,
          onRefresh: () => controller.loadDashboardData(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Top Hero Card ─────────────────────────────────────────
                const ArtistRevenueHeroCard(),
                18.verticalSpace,

                // ─── Earning Analytics Bezier Chart ────────────────────────
                ArtistEarningAnalyticsChart(controller: controller),
                20.verticalSpace,

                // ─── Recent Transactions Header ────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ArtistRevenueTransactionsScreen());
                      },
                      child: Text(
                        'See All',
                        style: AppTextStyle(context).mediumTextStyle(
                          color: AppColors.primarytext,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                14.verticalSpace,

                // ─── Recent Transactions List ──────────────────────────────
                Obx(() {
                  if (controller.isLoading.value &&
                      controller.recentTransactions.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(
                          color: AppColors.secondary,
                        ),
                      ),
                    );
                  }

                  if (controller.recentTransactions.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: Text(
                          'No transactions yet',
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
                    itemCount: controller.recentTransactions.length,
                    itemBuilder: (context, index) {
                      final tx = controller.recentTransactions[index];
                      return ArtistTransactionCard(transaction: tx);
                    },
                  );
                }),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
