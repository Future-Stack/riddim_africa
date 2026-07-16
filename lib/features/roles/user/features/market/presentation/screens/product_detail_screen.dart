import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../controllers/product_detail_controller.dart';
import '../widgets/product_image_gallery.dart';
import '../widgets/rating_row.dart';
import '../widgets/related_product_card.dart';
import '../widgets/seller_info_row.dart';
import '../widgets/stock_badge.dart';
import '../widgets/customer_review_card.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/product_spec_dropdown.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.onboardingbutton),
          );
        }

        final product = controller.product.value;
        if (product == null) {
          return Center(
            child: Text(
              'Product not found',
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white),
            ),
          );
        }

        return SafeArea(
          child: Column(
            children: [
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Gallery Section
                      ProductImageGallery(
                        mainImageUrl: product.imageUrl,
                        galleryImages: product.galleryImages,
                        selectedIndex: controller.selectedImageIndex.value,
                        onImageSelected: controller.selectGalleryImage,
                        onBackPressed: () => Get.back(),
                        onFavoritePressed: controller.toggleFavorite,
                        isFavorite: controller.isFavorite.value,
                      ),

                      // Details Section
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title & Stock Status
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title,
                                    style: AppTextStyle(context).boldTextStyle(
                                      color: AppColors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                StockBadge(inStock: product.inStock),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Price (UGX 78,000)
                            Text(
                              product.price,
                              style: AppTextStyle(context).boldTextStyle(
                                color: AppColors.onboardingbutton,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Rating Row
                            RatingRow(
                              rating: product.rating,
                              reviewCount: product.reviewCount,
                            ),
                            const SizedBox(height: 12),

                            // Category
                            Row(
                              children: [
                                Text(
                                  'Category: ',
                                  style: AppTextStyle(context).mediumTextStyle(
                                    color: AppColors.primarytext,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  product.category,
                                  style: AppTextStyle(context).boldTextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Seller Info
                            SellerInfoRow(
                              sellerName: product.sellerName,
                              avatarUrl: product.sellerAvatarUrl,
                              isVerified: product.isVerifiedSeller,
                              rating: product.sellerRating,
                              salesCount: product.sellerSales,
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.artistProfile,
                                  arguments: {
                                    'name': product.sellerName,
                                    'avatarUrl': product.sellerAvatarUrl,
                                    'rating': product.sellerRating,
                                    'isVerified': product.isVerifiedSeller,
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 20),

                            // Description (Optional)
                            if (product.description != null) ...[
                              Text(
                                'Description',
                                style: AppTextStyle(context).boldTextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.description!,
                                style: AppTextStyle(context).regularTextStyle(
                                  color: AppColors.primarytext,
                                  fontSize: 14,
                                  lineHeight: 20,
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],

                            // Quantity Selector Row
                            Obx(
                              () => QuantitySelector(
                                quantity: controller.quantity.value,
                                onIncrement: controller.incrementQuantity,
                                onDecrement: controller.decrementQuantity,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Color & Size Selectors Row
                            Row(
                              children: [
                                Obx(
                                  () => ProductSpecDropdown(
                                    label: 'Color:',
                                    items: product.availableColors,
                                    selectedIndex:
                                        controller.selectedColorIndex.value,
                                    onSelected: controller.selectColor,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Obx(
                                  () => ProductSpecDropdown(
                                    label: 'Size:',
                                    items: product.availableSizes,
                                    selectedIndex:
                                        controller.selectedSizeIndex.value,
                                    onSelected: controller.selectSize,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Customer Reviews Section
                            Text(
                              'Customer Reviews',
                              style: AppTextStyle(context).boldTextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const CustomerReviewCard(
                              name: 'Nakato Sarah',
                              timeAgo: '2 days ago',
                              avatarUrl:
                                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop',
                              rating: 5,
                              comment:
                                  'Beautiful quality! The fabric is amazing and delivery was fast.',
                            ),
                            const CustomerReviewCard(
                              name: 'Mugisha Alex',
                              timeAgo: '1 week ago',
                              avatarUrl:
                                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
                              rating: 4,
                              comment:
                                  'Great product, exactly as described. Will buy again!',
                            ),
                            const SizedBox(height: 24),

                            // Related Products Header
                            Text(
                              'Related Products',
                              style: AppTextStyle(context).boldTextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Related Products List
                            SizedBox(
                              height: 170,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.relatedProducts.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 16),
                                itemBuilder: (context, index) {
                                  final related =
                                      controller.relatedProducts[index];
                                  return RelatedProductCard(
                                    imageUrl: related.imageUrl,
                                    title: related.title,
                                    price: related.price,
                                    onTap: () {
                                      // Reload product details for this related product
                                      Get.offNamed(
                                        '/marketProductDetail',
                                        arguments: related.id,
                                        preventDuplicates: false,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Action Buttons Row
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: AppColors.primaryappbrown,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.primaryappbrownsecond,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // Add To Cart Button
                    Expanded(
                      child: ProElevatedButton(
                        leadingIcon: Iconsax.shopping_cart,
                        onPressed: controller.addToCart,
                        backgroundColor: AppColors.onboardingbutton,
                        text: "Add to Cart",
                        textColor: AppColors.black,
                        showGlow: true,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Buy Now Button
                    Expanded(
                      child: ProElevatedButton(
                        leadingIcon: Iconsax.flash,
                        onPressed: controller.buyNow,
                        backgroundColor: AppColors.secondary,
                        text: "Buy Now",
                        textColor: AppColors.white,
                        showGlow: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
