import 'package:get/get.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_home_products_usecase.dart';

class UserHomeController extends GetxController {
  final GetHomeProductsUseCase _getHomeProductsUseCase;

  UserHomeController(this._getHomeProductsUseCase);

  // State
  final RxString searchText = ''.obs;
  final RxString selectedMainCategory = 'Featured'.obs;
  final RxString selectedSubCategory = 'All'.obs;
  final RxBool isLoading = false.obs;

  // Products
  final RxList<ProductEntity> productsList = <ProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    isLoading.value = true;
    try {
      final products = await _getHomeProductsUseCase.execute();
      productsList.value = products;
    } catch (e) {
      // Handle error gracefully
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    // Implement search filtering logic here if needed
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
