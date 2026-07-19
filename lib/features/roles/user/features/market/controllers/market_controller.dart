import 'package:get/get.dart';
import '../domain/entities/market_product_entity.dart';
import '../domain/usecases/get_market_products_usecase.dart';

class MarketController extends GetxController {
  final GetMarketProductsUseCase _getMarketProductsUseCase;

  MarketController(this._getMarketProductsUseCase);

  // State
  final RxString selectedMainCategory = 'Featured'.obs;
  final RxString selectedSubCategory = 'All'.obs;
  final RxBool isLoading = false.obs;

  // Products
  final RxList<MarketProductEntity> productsList = <MarketProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    isLoading.value = true;
    try {
      final products = await _getMarketProductsUseCase.execute();
      productsList.value = products;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void selectMainCategory(String category) {
    selectedMainCategory.value = category;
    // Filter products if needed
  }

  void selectSubCategory(String category) {
    selectedSubCategory.value = category;
    // Filter products if needed
  }
}
