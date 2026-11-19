import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_revenue_controller.dart';
import '../../data/models/artist_revenue_model.dart';
import 'artist_payment_details_screen.dart';
import 'artist_payout_detail_screen.dart';

class ArtistRevenueTransactionsScreen extends StatelessWidget {
  const ArtistRevenueTransactionsScreen({super.key});

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
          'Revenue',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Underline Tab Bar
            Obx(
              () => Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0x1AFFFFFF), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    _buildUnderlineTab(
                      title: 'Settled to Mobile money',
                      isSelected: c.selectedTab.value == 0,
                      onTap: () => c.setTab(0),
                    ),
                    _buildUnderlineTab(
                      title: 'Payout in progress',
                      isSelected: c.selectedTab.value == 1,
                      onTap: () => c.setTab(1),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Dual Stat Hero Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF5A2814), Color(0xFF381A0D)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B4E38),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.white.withValues(
                                      alpha: 0.06,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Settled to Mobile\nmoney',
                                      style: AppTextStyle(context)
                                          .regularTextStyle(
                                            color: AppColors.primarytext
                                                .withValues(alpha: 0.7),
                                            fontSize: 10,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'UGX 189,200',
                                      style: AppTextStyle(context).boldTextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B4E38),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.white.withValues(
                                      alpha: 0.06,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'payout in progress\n',
                                      style: AppTextStyle(context)
                                          .regularTextStyle(
                                            color: AppColors.primarytext
                                                .withValues(alpha: 0.7),
                                            fontSize: 10,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'UGX 65,575',
                                      style: AppTextStyle(context).boldTextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
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
                    const SizedBox(height: 16),

                    // Transaction List
                    Obx(() {
                      final list = c.currentTabTransactions;
                      if (list.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            'No transactions found',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext,
                              fontSize: 14,
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
                          return _buildExactTransactionCard(context, tx);
                        },
                      );
                    }),
                    const SizedBox(height: 16),
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFF388E8E)
                    : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primarytext,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExactTransactionCard(
    BuildContext context,
    ArtistTransactionModel tx,
  ) {
    final bool isSettled = tx.status == ArtistTransactionStatus.settled;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E130B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (isSettled) {
              Get.to(() => ArtistPaymentDetailsScreen(transaction: tx));
            } else {
              Get.to(() => ArtistPayoutDetailScreen(transaction: tx));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Avatar
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSettled
                        ? const Color(0xFF1A3B35)
                        : const Color(0xFF3B2B1B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      isSettled ? Icons.north_east : Icons.access_time_rounded,
                      color: isSettled
                          ? const Color(0xFF00E676)
                          : const Color(0xFFF5A623),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Title & Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.productTitle,
                        style: AppTextStyle(
                          context,
                        ).boldTextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 3),
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
                      const SizedBox(height: 6),
                      // Pill badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSettled
                              ? const Color(0xFF132B1C)
                              : const Color(0xFF3E2800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSettled
                                  ? Icons.check_circle
                                  : Icons.access_time,
                              size: 10,
                              color: isSettled
                                  ? const Color(0xFF00E676)
                                  : const Color(0xFFF5A623),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isSettled
                                  ? 'Payment Received'
                                  : 'Payout in Progress',
                              style: TextStyle(
                                color: isSettled
                                    ? const Color(0xFF00E676)
                                    : const Color(0xFFF5A623),
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Amount
                Text(
                  tx.formattedAmount,
                  style: TextStyle(
                    color: isSettled
                        ? const Color(0xFF00E676)
                        : const Color(0xFFF5A623),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
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
