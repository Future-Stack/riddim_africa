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
  List<MarketProductEntity> _allFetchedProducts = [];
  final RxList<MarketProductEntity> productsList = <MarketProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts({bool showLoading = true}) async {
    if (showLoading) isLoading.value = true;
    try {
      final String? collection = selectedMainCategory.value.isNotEmpty
          ? selectedMainCategory.value
          : null;

      final products = await _getMarketProductsUseCase.execute(
        collectionTitle: collection,
      );
      _allFetchedProducts = products;
      _applyFilters();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await loadProducts(showLoading: false);
  }

  void selectMainCategory(String category) {
    if (selectedMainCategory.value == category) return;
    selectedMainCategory.value = category;
    loadProducts(showLoading: true);
  }

  void selectSubCategory(String category) {
    selectedSubCategory.value = category;
    _applyFilters();
  }

  void _applyFilters() {
    if (selectedSubCategory.value == 'All') {
      productsList.value = _allFetchedProducts;
      return;
    }

    final query = selectedSubCategory.value.toLowerCase().replaceAll(' ', '');
    final filtered = _allFetchedProducts.where((p) {
      final cat = p.category.toLowerCase().replaceAll(' ', '');
      return cat.contains(query) || query.contains(cat);
    }).toList();

    productsList.value = filtered;
  }
}
