import 'package:get/get.dart';
import '../../domain/entities/market_product_entity.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';
import '../../domain/usecases/get_related_products_usecase.dart';

class ProductDetailController extends GetxController {
  final GetProductDetailUseCase _getProductDetailUseCase;
  final GetRelatedProductsUseCase _getRelatedProductsUseCase;

  ProductDetailController(
    this._getProductDetailUseCase,
    this._getRelatedProductsUseCase,
  );

  // State
  final RxBool isLoading = true.obs;
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

  void addToCart() {
    Get.snackbar('Success', '${product.value?.title} added to cart');
  }

  void buyNow() {
    Get.toNamed('/marketCart');
  }
}
