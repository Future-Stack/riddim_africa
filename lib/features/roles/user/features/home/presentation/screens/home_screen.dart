import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/widgets/home_app_bar.dart';
import 'package:riddimafrica/core/common/widgets/custom_search_bar.dart';
import 'package:riddimafrica/core/common/widgets/product_card.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../controllers/user_home_controller.dart';
import '../widgets/campaign_banner_card.dart';
import '../widgets/live_radio_card.dart';
import '../widgets/featured_artist_card.dart';

class UserHomeScreen extends GetView<UserHomeController> {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Dark brown background
      appBar: const HomeAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const HomeScreenShimmer();
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar Section (tapping navigates to global search)
              CustomSearchBar(
                readOnly: true,
                onTap: () => Get.toNamed(AppRoute.globalSearch),
              ),
              const SizedBox(height: 20),

              // Marketplace Campaign Card
              const CampaignBannerCard(),
              const SizedBox(height: 20),

              // Live Radio Card
              const LiveRadioCard(),
              const SizedBox(height: 24),
              // ─── Featured Products ─────────────────────────────────────────
              _buildSectionHeader(
                context,
                title: 'Featured Products',
                onSeeAll: () {},
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.featuredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.featuredProducts[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SizedBox(
                        width: 150.w,
                        child: ProductCard(
                          imageUrl: product.imageUrl,
                          title: product.title,
                          subtitle: product.subtitle,
                          rating: product.rating,
                          categoryText: product.categoryText,
                          price: product.price,
                          onTap: () {
                            Get.toNamed(
                              AppRoute.marketProductDetail,
                              arguments: product.id,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // ─── Artist Merchandise ────────────────────────────────────────
              _buildSectionHeader(
                context,
                title: 'Artist Merchandise',
                onSeeAll: () {},
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 170.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.artistMerchandise.length,
                  itemBuilder: (context, index) {
                    final product = controller.artistMerchandise[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SizedBox(
                        width: 160.w,
                        child: ProductCard(
                          imageUrl: product.imageUrl,
                          title: product.title,
                          subtitle: '',
                          rating: 0,
                          categoryText: '',
                          price: product.price,
                          showRatingRow: false,
                          showAddButton: false,
                          actionText: 'View',
                          artistName: product.artistName,
                          artistAvatarUrl: product.artistAvatarUrl,
                          isVerifiedArtist: product.isVerifiedArtist,
                          onTap: () {
                            Get.toNamed(
                              AppRoute.marketProductDetail,
                              arguments: product.id,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // ─── Trending Products ─────────────────────────────────────────
              _buildSectionHeader(
                context,
                title: 'Trending Products',
                onSeeAll: () => Get.toNamed(AppRoute.getUserhomescreen()),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 170.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.trendingProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.trendingProducts[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SizedBox(
                        width: 140.w,
                        child: ProductCard(
                          imageUrl: product.imageUrl,
                          title: product.title,
                          subtitle: '',
                          rating: 0,
                          categoryText: '',
                          price: product.price,
                          rank: index + 1,
                          showFavoriteButton: false,
                          showRatingRow: false,
                          showAddButton: false,
                          onTap: () {
                            Get.toNamed(
                              AppRoute.marketProductDetail,
                              arguments: product.id,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // ─── Featured Artists ──────────────────────────────────────────
              _buildSectionHeader(
                context,
                title: 'Featured Artists',
                onSeeAll: () {},
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 145.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.featuredArtists.length,
                  itemBuilder: (context, index) {
                    final artist = controller.featuredArtists[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: FeaturedArtistCard(
                        artist: artist,
                        onTap: () {
                          Get.toNamed(
                            AppRoute.artistProfile,
                            arguments: {
                              'name': artist.name,
                              'avatarUrl': artist.imageUrl,
                              'rating': 4.9,
                              'isVerified': true,
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 20),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See all ',
                style: AppTextStyle(
                  context,
                ).mediumTextStyle(color: AppColors.secondary, fontSize: 14),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.secondary,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
