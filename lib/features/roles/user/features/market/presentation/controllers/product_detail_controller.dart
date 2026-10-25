import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../domain/entities/market_product_entity.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';
import '../../domain/usecases/get_related_products_usecase.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';

class ProductDetailController extends GetxController {
  final GetProductDetailUseCase _getProductDetailUseCase;
  final GetRelatedProductsUseCase _getRelatedProductsUseCase;
  final AddToCartUseCase _addToCartUseCase;

  ProductDetailController(
    this._getProductDetailUseCase,
    this._getRelatedProductsUseCase,
    this._addToCartUseCase,
  );

  // State
  final RxBool isLoading = true.obs;
  final RxBool isAddingToCart = false.obs;
  final RxBool isFavorite = false.obs;
  final RxInt selectedImageIndex = 0.obs;
  final RxInt selectedColorIndex = 0.obs;
  final RxInt selectedSizeIndex = 0.obs;
  final RxInt quantity = 1.obs;

  // Data
  final Rx<MarketProductEntity?> product = Rx<MarketProductEntity?>(null);
  final RxList<MarketProductEntity> relatedProducts =
      <MarketProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final String productId = Get.arguments as String? ?? '1';
    _loadProductDetail(productId);
  }

  Future<void> _loadProductDetail(String productId) async {
    isLoading.value = true;
    selectedImageIndex.value = 0;
    selectedColorIndex.value = 0;
    selectedSizeIndex.value = 0;
    quantity.value = 1;

    try {
      final productDetail = await _getProductDetailUseCase.execute(productId);
      product.value = productDetail;
      isFavorite.value = productDetail.isWishlisted;

      if (productDetail.relatedProducts.isNotEmpty) {
        relatedProducts.value = productDetail.relatedProducts;
      } else {
        try {
          final rel = await _getRelatedProductsUseCase.execute(productId);
          relatedProducts.value = rel;
        } catch (_) {
          relatedProducts.value = [];
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product details');
    } finally {
      isLoading.value = false;
    }
  }

  void selectGalleryImage(int index) {
    selectedImageIndex.value = index;
  }

  void selectColor(int index) {
    selectedColorIndex.value = index;
  }

  void selectSize(int index) {
    selectedSizeIndex.value = index;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  Future<void> addToCart() async {
    final currentProduct = product.value;
    if (currentProduct == null) return;

    isAddingToCart.value = true;
    try {
      final String? selectedColor = currentProduct.availableColors.isNotEmpty &&
              selectedColorIndex.value < currentProduct.availableColors.length
          ? currentProduct.availableColors[selectedColorIndex.value]
          : null;
      final String? selectedSize = currentProduct.availableSizes.isNotEmpty &&
              selectedSizeIndex.value < currentProduct.availableSizes.length
          ? currentProduct.availableSizes[selectedSizeIndex.value]
          : null;

      final success = await _addToCartUseCase.execute(
        productId: currentProduct.id,
        quantity: quantity.value,
        color: selectedColor,
        size: selectedSize,
      );

      if (success) {
        Get.snackbar(
          'Added to Cart',
          '${currentProduct.title} added to cart successfully',
          backgroundColor: AppColors.onboardingbutton.withValues(alpha: 0.95),
          colorText: AppColors.primary,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Cart',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isAddingToCart.value = false;
    }
  }

  void buyNow() {
    final currentProduct = product.value;
    if (currentProduct == null) return;

    final String? selectedColor = currentProduct.availableColors.isNotEmpty &&
            selectedColorIndex.value < currentProduct.availableColors.length
        ? currentProduct.availableColors[selectedColorIndex.value]
        : null;
    final String? selectedSize = currentProduct.availableSizes.isNotEmpty &&
            selectedSizeIndex.value < currentProduct.availableSizes.length
        ? currentProduct.availableSizes[selectedSizeIndex.value]
        : null;

    Get.toNamed(
      AppRoute.marketCheckout,
      arguments: {
        'checkoutType': 'DIRECT',
        'product': currentProduct,
        'productId': currentProduct.id,
        'title': currentProduct.title,
        'imageUrl': currentProduct.imageUrl,
        'price': currentProduct.price,
        'rawPrice': currentProduct.rawPrice,
        'quantity': quantity.value,
        'color': selectedColor,
        'size': selectedSize,
      },
    );
  }
}
