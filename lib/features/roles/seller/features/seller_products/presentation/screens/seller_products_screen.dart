import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/seller_products_controller.dart';
import '../widgets/seller_product_item_card.dart';

class SellerProductsScreen extends GetView<SellerProductsController> {
  const SellerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is registered
    final c = Get.isRegistered<SellerProductsController>()
        ? Get.find<SellerProductsController>()
        : Get.put(SellerProductsController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          // child: GestureDetector(
          //   onTap: () => Get.back(),
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: AppColors.appbardivider,
          //       shape: BoxShape.circle,
          //     ),
          //     // child: const Icon(
          //     //   Icons.arrow_back,
          //     //   color: AppColors.white,
          //     //   size: 20,
          //     // ),
          //   ),
          // ),
        ),
        title: Text(
          'My Products',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => c.toggleSearch(),
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.appbardivider,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Expandable Search Bar
              Obx(() {
                if (!c.isSearchVisible.value) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: c.searchController,
                    onChanged: (val) => c.onSearchChanged(val),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search products by name or code...',
                      hintStyle: TextStyle(
                        color: AppColors.primarytext.withValues(alpha: 0.6),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primarytext,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: AppColors.white.withValues(alpha: 0.06),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Pill Tabs: Live (count) | In Review (count) | Rejected (count)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Obx(
                  () => Row(
                    children: [
                      _buildPillTab(
                        context,
                        title: 'Live',
                        count: c.liveCount,
                        isSelected: c.selectedTab.value == 0,
                        onTap: () => c.setTab(0),
                      ),
                      const SizedBox(width: 8),
                      _buildPillTab(
                        context,
                        title: 'In Review',
                        count: c.inReviewCount,
                        isSelected: c.selectedTab.value == 1,
                        onTap: () => c.setTab(1),
                      ),
                      const SizedBox(width: 8),
                      _buildPillTab(
                        context,
                        title: 'Rejected',
                        count: c.rejectedCount,
                        isSelected: c.selectedTab.value == 2,
                        onTap: () => c.setTab(2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Filtered Products List
              Expanded(
                child: Obx(() {
                  final list = c.filteredProducts;

                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 48,
                            color: AppColors.primarytext.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No products found',
                            style: AppTextStyle(context).mediumTextStyle(
                              color: AppColors.primarytext,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 4,
                      bottom: 90, // Leave room for bottom sticky button
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final product = list[index];
                      return SellerProductItemCard(
                        product: product,
                        onTap: () => c.onProductTapped(product),
                      );
                    },
                  );
                }),
              ),
            ],
          ),

          // Sticky Bottom "+ Submit New" Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFBB483D).withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => c.navigateToSubmitNew(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB483D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Submit New',
                      style: AppTextStyle(
                        context,
                      ).boldTextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillTab(
    BuildContext context, {
    required String title,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6F2C57)
                : AppColors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6F2C57)
                  : AppColors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyle(context).mediumTextStyle(
                  color: isSelected ? Colors.white : AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
              if (count > 0 && !isSelected) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE65100),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
