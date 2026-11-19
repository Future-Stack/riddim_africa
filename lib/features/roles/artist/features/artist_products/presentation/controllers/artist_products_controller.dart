import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../data/models/artist_product_model.dart';
import '../../data/models/product_variant_model.dart';

class ArtistProductsController extends GetxController {
  // Tab index: 0 = Live, 1 = In Review, 2 = Rejected
  final RxInt selectedTab = 0.obs;

  // Search
  final RxBool isSearchVisible = false.obs;
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // All Products list
  final RxList<ArtistProductModel> allProducts = <ArtistProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialProducts();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void setTab(int index) {
    selectedTab.value = index;
  }

  void toggleSearch() {
    isSearchVisible.value = !isSearchVisible.value;
    if (!isSearchVisible.value) {
      searchQuery.value = '';
      searchController.clear();
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  int get liveCount =>
      allProducts.where((p) => p.status == ArtistProductStatus.live).length;

  int get inReviewCount =>
      allProducts.where((p) => p.status == ArtistProductStatus.pending).length;

  int get rejectedCount => allProducts
      .where((p) =>
          p.status == ArtistProductStatus.rejected ||
          p.status == ArtistProductStatus.cancelled)
      .length;

  List<ArtistProductModel> get filteredProducts {
    ArtistProductStatus targetStatus;
    if (selectedTab.value == 0) {
      targetStatus = ArtistProductStatus.live;
    } else if (selectedTab.value == 1) {
      targetStatus = ArtistProductStatus.pending;
    } else {
      // Tab 2: rejected or cancelled
      return allProducts.where((p) {
        final matchesStatus = p.status == ArtistProductStatus.rejected ||
            p.status == ArtistProductStatus.cancelled;
        if (!matchesStatus) return false;
        if (searchQuery.value.isEmpty) return true;
        return p.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            p.code.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    return allProducts.where((p) {
      final matchesStatus = p.status == targetStatus;
      if (!matchesStatus) return false;
      if (searchQuery.value.isEmpty) return true;
      return p.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          p.code.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  void onProductTapped(ArtistProductModel product) {
    if (product.status == ArtistProductStatus.live) {
      Get.toNamed(
        AppRoute.artistLiveProductDetail,
        arguments: product,
      );
    } else if (product.status == ArtistProductStatus.pending) {
      Get.toNamed(
        AppRoute.artistReviewTracking,
        arguments: product,
      );
    } else {
      Get.toNamed(
        AppRoute.artistRejectedProductDetail,
        arguments: product,
      );
    }
  }

  void navigateToSubmitNew() {
    Get.toNamed(AppRoute.artistSubmitProduct);
  }

  void _loadInitialProducts() {
    allProducts.assignAll([
      // Live Products
      const ArtistProductModel(
        id: '1',
        name: 'Kente Fabric Roll (6 yards)',
        code: 'PRD-2024-00182',
        category: 'Textiles & Fabrics',
        submittedDate: 'Jun 15, 2026',
        status: ArtistProductStatus.live,
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=250',
        material: '100% Handwoven Cotton',
        origin: 'Kumasi, Ghana',
        totalOrders: 14,
        totalRevenue: 175000,
        monthlyEarningsGrowth: '+31% this month',
        rating: 4.9,
        reviewsCount: 57,
        ratingDistribution: {5: 46, 4: 8, 3: 2, 2: 1, 1: 0},
      ),
      const ArtistProductModel(
        id: '2',
        name: 'Ankara Wrap Dress',
        code: 'PRD-2024-00182',
        category: 'Textiles & Fabrics',
        submittedDate: 'Jun 15, 2026',
        status: ArtistProductStatus.live,
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=250',
        material: 'Wax Print Cotton',
        origin: 'Lagos, Nigeria',
        totalOrders: 9,
        totalRevenue: 112000,
        rating: 4.8,
        reviewsCount: 32,
      ),
      const ArtistProductModel(
        id: '3',
        name: 'Adinkra Beaded Necklace',
        code: 'PRD-2024-00182',
        category: 'Textiles & Fabrics',
        submittedDate: 'Jun 15, 2026',
        status: ArtistProductStatus.live,
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=250',
        material: 'Recycled Glass & Brass',
        origin: 'Accra, Ghana',
        totalOrders: 21,
        totalRevenue: 240000,
        rating: 5.0,
        reviewsCount: 64,
      ),

      // In Review (Pending) Products
      const ArtistProductModel(
        id: '4',
        name: 'Ashanti Kente Scarf',
        code: 'PRD-2024-00182',
        category: 'Textiles & Fabrics',
        submittedDate: 'Jun 15, 2026',
        status: ArtistProductStatus.pending,
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=250',
        material: '100% Silk',
        origin: 'Kumasi, Ghana',
        colorVariants: [
          ColorVariantModel(
            colorName: 'Red',
            sizes: [
              ProductVariantItem(size: 'XXL', quantity: 220, price: 1200),
              ProductVariantItem(size: 'XL', quantity: 370, price: 1500),
            ],
          ),
          ColorVariantModel(
            colorName: 'Purple',
            sizes: [
              ProductVariantItem(size: 'XXL', quantity: 220, price: 1200),
              ProductVariantItem(size: 'XL', quantity: 370, price: 1500),
            ],
          ),
        ],
      ),
      const ArtistProductModel(
        id: '5',
        name: 'Masai Beaded Bracelet Set',
        code: 'PRD-2024-00182',
        category: 'Textiles & Fabrics',
        submittedDate: 'Jun 15, 2026',
        status: ArtistProductStatus.pending,
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=250',
        material: 'Beads & Leather',
        origin: 'Nairobi, Kenya',
      ),

      // Rejected / Cancelled Products
      const ArtistProductModel(
        id: '6',
        name: 'Ashanti Kente Scarf',
        code: 'PRD-2024-00182',
        category: 'Textiles & Fabrics',
        submittedDate: 'Jun 12, 2026',
        status: ArtistProductStatus.rejected,
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=250',
        rejectionReason:
            'Your product listing did not meet our marketplace quality standards. Image quality must be high resolution with good lighting.',
        rejectedAt: 'June 12, 2026 at 10:34 AM',
      ),
    ]);
  }
}
