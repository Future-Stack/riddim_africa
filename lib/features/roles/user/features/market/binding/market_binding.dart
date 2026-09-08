import 'package:get/get.dart';
import '../data/datasources/market_local_data_source.dart';
import '../data/repositories/market_repository_impl.dart';
import '../domain/repositories/market_repository.dart';
import '../domain/usecases/get_cart_items_usecase.dart';
import '../domain/usecases/get_delivery_addresses_usecase.dart';
import '../domain/usecases/get_product_detail_usecase.dart';
import '../domain/usecases/get_related_products_usecase.dart';
import '../domain/usecases/get_artist_products_usecase.dart';
import '../domain/usecases/get_market_products_usecase.dart';
import '../presentation/controllers/cart_controller.dart';
import '../presentation/controllers/checkout_controller.dart';
import '../presentation/controllers/product_detail_controller.dart';
import '../presentation/controllers/artist_profile_controller.dart';
import '../controllers/market_controller.dart';

class MarketBinding extends Bindings {
  @override
  void dependencies() {
    // Data Source
    Get.lazyPut<MarketLocalDataSource>(() => MarketLocalDataSourceImpl());

    // Repository
    Get.lazyPut<MarketRepository>(
      () => MarketRepositoryImpl(Get.find<MarketLocalDataSource>()),
    );

    // Use Cases
    Get.lazyPut(() => GetProductDetailUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(() => GetRelatedProductsUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(() => GetCartItemsUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(
      () => GetDeliveryAddressesUseCase(Get.find<MarketRepository>()),
    );
    Get.lazyPut(() => GetArtistProductsUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(() => GetMarketProductsUseCase(Get.find<MarketRepository>()));

    // Controllers
    Get.lazyPut(
      () => ProductDetailController(
        Get.find<GetProductDetailUseCase>(),
        Get.find<GetRelatedProductsUseCase>(),
      ),
    );
    Get.lazyPut(() => CartController(Get.find<GetCartItemsUseCase>()));
    Get.lazyPut(
      () => CheckoutController(Get.find<GetDeliveryAddressesUseCase>()),
    );
    Get.lazyPut(
      () => MarketArtistProfileController(Get.find<GetArtistProductsUseCase>()),
    );
    Get.lazyPut(
      () => MarketController(Get.find<GetMarketProductsUseCase>()),
    );
  }
}
