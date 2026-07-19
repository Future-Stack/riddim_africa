import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/profile_controller.dart';
import '../../../home/data/models/product_model.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: GlobalAppBar(
        titleWidget: Obx(() {
          final count = controller.wishlist.length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Wishlist',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$count saved items',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
            ],
          );
        }),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.wishlist.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.heart5,
                    size: 64,
                    color: AppColors.primaryappbrownsecond,
                  ),
                  const Gap(16),
                  Text(
                    'Your wishlist is empty',
                    style: AppTextStyle(context).semiBoldTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.wishlist.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final product = controller.wishlist[index];
              return _WishlistProductCard(
                product: product,
                onRemove: () => controller.toggleWishlist(product),
                onAddToCart: () {
                  Get.snackbar(
                    'Added to Cart',
                    '${product.title} added to shopping cart!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.bordercolor.withValues(alpha: 0.9),
                    colorText: AppColors.white,
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}

class _WishlistProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const _WishlistProductCard({
    required this.product,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.primaryappbrownsecond.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Heart overlay
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primaryappbrownsecond,
                      width: double.infinity,
                      child: const Icon(
                        Iconsax.image,
                        color: AppColors.primarytext,
                      ),
                    ),
                  ),
                ),
                // Solid Red Heart on dark transparent circle
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.heart5,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details text
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  product.subtitle,
                  style: AppTextStyle(context).mediumTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.price,
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.onboardingbutton,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.bordercolor, // Teal color
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.shopping_cart,
                          color: AppColors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
