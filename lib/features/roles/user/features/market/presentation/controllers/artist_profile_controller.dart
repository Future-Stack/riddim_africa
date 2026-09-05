import 'package:get/get.dart';
import '../../domain/entities/market_product_entity.dart';
import '../../domain/usecases/get_artist_products_usecase.dart';

class MarketArtistProfileController extends GetxController {
  final GetArtistProductsUseCase _getArtistProductsUseCase;

  MarketArtistProfileController(this._getArtistProductsUseCase);

  // Loading state
  final RxBool isLoading = false.obs;

  // Selected tab: 0 for Merchandise, 1 for About
  final RxInt selectedTab = 0.obs;

  // Artist info
  final RxString name = ''.obs;
  final RxString avatarUrl = ''.obs;
  final RxDouble rating = 0.0.obs;
  final RxBool isVerified = false.obs;

  // Artist products list
  final RxList<MarketProductEntity> productsList = <MarketProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    
    // Read route arguments
    final dynamic args = Get.arguments;
    if (args is Map<String, dynamic>) {
      name.value = args['name'] as String? ?? 'Bobi Wine';
      avatarUrl.value = args['avatarUrl'] as String? ?? '';
      rating.value = (args['rating'] as num?)?.toDouble() ?? 4.9;
      isVerified.value = args['isVerified'] as bool? ?? false;
    } else if (args is String) {
      name.value = args;
      avatarUrl.value = '';
      rating.value = 4.9;
      isVerified.value = true;
    } else {
      // Fallback defaults
      name.value = 'Bobi Wine';
      avatarUrl.value = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop';
      rating.value = 4.9;
      isVerified.value = true;
    }

    _loadArtistProducts();
  }

  Future<void> _loadArtistProducts() async {
    isLoading.value = true;
    try {
      final products = await _getArtistProductsUseCase.execute(name.value);
      productsList.value = products;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load artist merchandise');
    } finally {
      isLoading.value = false;
    }
  }

  void selectTab(int index) {
    selectedTab.value = index;
  }
}
