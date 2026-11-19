import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_product_detail_controller.dart';
import '../widgets/earnings_chart_widget.dart';
import '../widgets/rating_breakdown_widget.dart';

class ArtistLiveProductDetailScreen extends GetView<ArtistProductDetailController> {
  const ArtistLiveProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.isRegistered<ArtistProductDetailController>()
        ? Get.find<ArtistProductDetailController>()
        : Get.put(ArtistProductDetailController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Obx(() {
        final product = c.product.value;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Sliver App Bar with Hero Image Banner
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: AppColors.primary,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Banner Image
                    Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFF2C1A0D),
                        child: const Icon(Icons.image, color: Colors.grey, size: 60),
                      ),
                    ),

                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.2),
                            Colors.black.withValues(alpha: 0.85),
                            AppColors.primary,
                          ],
                          stops: const [0.0, 0.7, 1.0],
                        ),
                      ),
                    ),

                    // Title & Price Info at bottom of banner
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  product.name,
                                  style: AppTextStyle(context).boldTextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${product.category} • ${product.code}',
                                  style: AppTextStyle(context).regularTextStyle(
                                    color: AppColors.primarytext,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            product.formattedPrice,
                            style: AppTextStyle(context).boldTextStyle(
                              color: const Color(0xFFFFB300),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Body
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Metric Stats Row: Orders & Revenue
                    Row(
                      children: [
                        // Orders Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF382111),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Color(0xFFCE93D8),
                                  size: 22,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  '${product.totalOrders}',
                                  style: AppTextStyle(context).boldTextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Orders',
                                  style: AppTextStyle(context).regularTextStyle(
                                    color: AppColors.primarytext,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Revenue Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF382111),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: Color(0xFF81C784),
                                  size: 22,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'UGX ${(product.totalRevenue / 1000).toStringAsFixed(0)}K',
                                  style: AppTextStyle(context).boldTextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Revenue',
                                  style: AppTextStyle(context).regularTextStyle(
                                    color: AppColors.primarytext,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Earnings Line Chart
                    EarningsChartWidget(
                      growthPercentage: product.monthlyEarningsGrowth,
                    ),
                    const SizedBox(height: 16),

                    // Rating & Reviews Breakdown
                    RatingBreakdownWidget(
                      rating: product.rating,
                      reviewsCount: product.reviewsCount,
                      distribution: product.ratingDistribution,
                    ),
                    const SizedBox(height: 20),

                    // PRODUCT DETAILS Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PRODUCT DETAILS',
                            style: AppTextStyle(context).boldTextStyle(
                              color: AppColors.primarytext,
                              fontSize: 11,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 14),

                          _buildDetailRow(context, 'Product ID', product.code),
                          _buildDivider(),
                          _buildDetailRow(context, 'Category', product.category),
                          _buildDivider(),
                          _buildDetailRow(
                            context,
                            'Material',
                            product.material ?? '100% Handwoven Cotton',
                          ),
                          _buildDivider(),
                          _buildDetailRow(
                            context,
                            'Published',
                            product.submittedDate,
                          ),
                          _buildDivider(),
                          _buildDetailRow(
                            context,
                            'Avg. Rating',
                            '${product.rating} ★ (${product.reviewsCount} reviews)',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle(context).regularTextStyle(
              color: AppColors.primarytext,
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
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 8,
      color: Color(0x14FFFFFF),
    );
  }
}
