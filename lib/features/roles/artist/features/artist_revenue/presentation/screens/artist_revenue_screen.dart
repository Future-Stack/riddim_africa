import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_revenue_controller.dart';
import '../../data/models/artist_revenue_model.dart';
import '../widgets/artist_revenue_chart.dart';
import 'artist_payment_details_screen.dart';
import 'artist_payout_detail_screen.dart';
import 'artist_revenue_transactions_screen.dart';

class ArtistRevenueScreen extends StatelessWidget {
  const ArtistRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.isRegistered<ArtistRevenueController>()
        ? Get.find<ArtistRevenueController>()
        : Get.put(ArtistRevenueController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
        leading: Navigator.canPop(context)
            ? Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                // child: GestureDetector(
                //   onTap: () => Get.back(),
                //   child: Container(
                //     decoration: const BoxDecoration(
                //       color: AppColors.appbardivider,
                //       shape: BoxShape.circle,
                //     ),
                //     child: const Icon(
                //       Icons.arrow_back,
                //       color: AppColors.white,
                //       size: 20,
                //     ),
                //   ),
                // ),
              )
            : null,
        title: Text(
          'Revenue',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
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
              // Top Gradient Hero Card
              _buildTopHeroCard(context, c),
              const SizedBox(height: 18),

              // Earning Analytics Chart
              const ArtistRevenueChart(),
              const SizedBox(height: 20),

              // Recent Transactions Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(color: Colors.white, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ArtistRevenueTransactionsScreen());
                    },
                    child: Text(
                      'See All',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Recent Transactions List
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: c.recentTransactions.length,
                  itemBuilder: (context, index) {
                    final tx = c.recentTransactions[index];
                    return _buildTransactionCard(context, tx);
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

  Widget _buildTopHeroCard(BuildContext context, ArtistRevenueController c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5A2814), Color(0xFF381A0D)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Revenue of this month',
            style: AppTextStyle(
              context,
            ).regularTextStyle(color: AppColors.primarytext, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  c.totalRevenueMonth.value,
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B4324),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '+18% this month',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Two nested stat cards with equal height & width
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      c.setTab(0);
                      Get.to(() => const ArtistRevenueTransactionsScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B4E38),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Settled to Mobile\nmoney',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext.withValues(
                                alpha: 0.7,
                              ),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => Text(
                              c.settledAmount.value,
                              style: AppTextStyle(context).boldTextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      c.setTab(1);
                      Get.to(() => const ArtistRevenueTransactionsScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B4E38),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payout in progress\n',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext.withValues(
                                alpha: 0.7,
                              ),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => Text(
                              c.payoutInProgressAmount.value,
                              style: AppTextStyle(context).boldTextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
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
    );
  }

  Widget _buildTransactionCard(
    BuildContext context,
    ArtistTransactionModel tx,
  ) {
    final bool isSettled = tx.status == ArtistTransactionStatus.settled;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF22140A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            if (isSettled) {
              Get.to(() => ArtistPaymentDetailsScreen(transaction: tx));
            } else {
              Get.to(() => ArtistPayoutDetailScreen(transaction: tx));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Icon Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSettled
                        ? const Color(0xFF1B3B2B)
                        : const Color(0xFF3B2B1B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      tx.iconLetter,
                      style: TextStyle(
                        color: isSettled
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFF5A623),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.productTitle,
                        style: AppTextStyle(
                          context,
                        ).boldTextStyle(color: Colors.white, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tx.id,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext.withValues(alpha: 0.7),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tx.date,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext.withValues(alpha: 0.5),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSettled
                              ? const Color(0xFF14301B)
                              : const Color(0xFF3E2800),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tx.status.label,
                          style: TextStyle(
                            color: isSettled
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFF5A623),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Amount
                Text(
                  tx.formattedAmount,
                  style: AppTextStyle(context).boldTextStyle(
                    color: isSettled
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF5A623),
                    fontSize: 13,
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
