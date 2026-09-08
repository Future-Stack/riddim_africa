import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/common/widgets/custom_search_bar.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/global_search_controller.dart';
import '../widgets/recent_search_tile.dart';
import '../widgets/suggested_product_tile.dart';
import '../widgets/suggested_artist_tile.dart';

class GlobalSearchScreen extends GetView<GlobalSearchController> {
  const GlobalSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Dark brown background
      body: SafeArea(
        child: Column(
          children: [
            // Top Search Bar Row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  // Circular Back Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryappbrown, // Dark brown circle
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Expanded Search Bar
                  Expanded(
                    child: CustomSearchBar(
                      controller: controller.searchBarController,
                      autofocus: true,
                      onSubmitted: controller.onSearchSubmitted,
                    ),
                  ),
                ],
              ),
            ),

            // Search Content Area
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.onboardingbutton,
                    ),
                  );
                }

                // If Search Input is Empty -> Show Suggestions
                if (controller.searchText.value.isEmpty) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // 1. Recent Searches Section
                        if (controller.recentSearches.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Searches',
                                style: AppTextStyle(context).semiBoldTextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: controller.clearRecentSearches,
                                child: Text(
                                  'Clear',
                                  style: AppTextStyle(context).mediumTextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: controller.recentSearches.map((query) {
                              return RecentSearchTile(
                                query: query,
                                onTap: () =>
                                    controller.selectRecentSearch(query),
                                onRemove: () =>
                                    controller.removeRecentSearch(query),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // 2. Suggested Products Section
                        if (controller.allProducts.isNotEmpty) ...[
                          Text(
                            'Suggested Products',
                            style: AppTextStyle(context).semiBoldTextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Column(
                            children: controller.allProducts.take(3).map((
                              product,
                            ) {
                              return SuggestedProductTile(
                                product: product,
                                onTap: () {
                                  controller.addRecentSearch(product.title);
                                  Get.toNamed(
                                    '/marketProductDetail',
                                    arguments: product.id,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // 3. Suggested Artists Section
                        if (controller.allArtists.isNotEmpty) ...[
                          Text(
                            'Suggested Artists',
                            style: AppTextStyle(context).semiBoldTextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 140,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.allArtists.length,
                              itemBuilder: (context, index) {
                                final artist = controller.allArtists[index];
                                return SuggestedArtistTile(
                                  artist: artist,
                                  onTap: () {
                                    controller.addRecentSearch(artist.name);
                                    controller.selectRecentSearch(artist.name);
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ],
                    ),
                  );
                }

                // If Search Input is NOT Empty -> Show Search Results
                final hasProducts = controller.filteredProducts.isNotEmpty;
                final hasArtists = controller.filteredArtists.isNotEmpty;

                if (!hasProducts && !hasArtists) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.search_status,
                            color: AppColors.primarytext,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No results found',
                            style: AppTextStyle(context).semiBoldTextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'We couldn\'t find any products or artists matching "${controller.searchText.value}"',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Matching Products
                      if (hasProducts) ...[
                        Text(
                          'Products',
                          style: AppTextStyle(context).semiBoldTextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: controller.filteredProducts.map((product) {
                            return SuggestedProductTile(
                              product: product,
                              onTap: () {
                                controller.addRecentSearch(product.title);
                                Get.toNamed(
                                  '/marketProductDetail',
                                  arguments: product.id,
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Matching Artists
                      if (hasArtists) ...[
                        Text(
                          'Artists',
                          style: AppTextStyle(context).semiBoldTextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.filteredArtists.length,
                            itemBuilder: (context, index) {
                              final artist = controller.filteredArtists[index];
                              return SuggestedArtistTile(
                                artist: artist,
                                onTap: () {
                                  controller.addRecentSearch(artist.name);
                                  controller.selectRecentSearch(artist.name);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
