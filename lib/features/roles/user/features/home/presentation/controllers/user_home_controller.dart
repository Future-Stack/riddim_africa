import 'package:get/get.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/artist_entity.dart';
import '../../domain/usecases/get_trending_products_usecase.dart';
import '../../domain/usecases/get_featured_artists_usecase.dart';
import '../../domain/usecases/get_featured_products_usecase.dart';
import '../../domain/usecases/get_artist_merchandise_usecase.dart';

class UserHomeController extends GetxController {
  final GetTrendingProductsUseCase _getTrendingProductsUseCase;
  final GetFeaturedArtistsUseCase _getFeaturedArtistsUseCase;
  final GetFeaturedProductsUseCase _getFeaturedProductsUseCase;
  final GetArtistMerchandiseUseCase _getArtistMerchandiseUseCase;

  UserHomeController(
    this._getTrendingProductsUseCase,
    this._getFeaturedArtistsUseCase,
    this._getFeaturedProductsUseCase,
    this._getArtistMerchandiseUseCase,
  );

  // States
  final RxBool isLoading = false.obs;

  // Lists
  final RxList<ProductEntity> trendingProducts = <ProductEntity>[].obs;
  final RxList<ArtistEntity> featuredArtists = <ArtistEntity>[].obs;
  final RxList<ProductEntity> featuredProducts = <ProductEntity>[].obs;
  final RxList<ProductEntity> artistMerchandise = <ProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        _getTrendingProductsUseCase.execute(),
        _getFeaturedArtistsUseCase.execute(),
        _getFeaturedProductsUseCase.execute(),
        _getArtistMerchandiseUseCase.execute(),
      ]);

      trendingProducts.value = results[0] as List<ProductEntity>;
      featuredArtists.value = results[1] as List<ArtistEntity>;
      featuredProducts.value = results[2] as List<ProductEntity>;
      artistMerchandise.value = results[3] as List<ProductEntity>;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load home dashboard data');
    } finally {
      isLoading.value = false;
    }
  }
}
