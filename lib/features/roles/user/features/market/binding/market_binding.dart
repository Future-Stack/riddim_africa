import 'package:get/get.dart';
import '../data/datasources/market_local_data_source.dart';
import '../data/datasources/market_remote_data_source.dart';
import '../data/repositories/market_repository_impl.dart';
import '../domain/repositories/market_repository.dart';
import '../domain/usecases/get_cart_items_usecase.dart';
import '../domain/usecases/add_to_cart_usecase.dart';
import '../domain/usecases/get_delivery_addresses_usecase.dart';
import '../domain/usecases/save_delivery_address_usecase.dart';
import '../domain/usecases/process_checkout_usecase.dart';
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
    // Data Sources
    Get.lazyPut<MarketLocalDataSource>(() => MarketLocalDataSourceImpl());
    Get.lazyPut<MarketRemoteDataSource>(() => MarketRemoteDataSourceImpl());

    // Repository
    Get.lazyPut<MarketRepository>(
      () => MarketRepositoryImpl(
        Get.find<MarketLocalDataSource>(),
        remoteDataSource: Get.find<MarketRemoteDataSource>(),
      ),
    );

    // Use Cases
    Get.lazyPut(() => GetProductDetailUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(() => GetRelatedProductsUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(() => GetCartItemsUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(() => AddToCartUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(
      () => GetDeliveryAddressesUseCase(Get.find<MarketRepository>()),
    );
    Get.lazyPut(
      () => SaveDeliveryAddressUseCase(Get.find<MarketRepository>()),
    );
    Get.lazyPut(
      () => ProcessCheckoutUseCase(Get.find<MarketRepository>()),
    );
    Get.lazyPut(() => GetArtistProductsUseCase(Get.find<MarketRepository>()));
    Get.lazyPut(() => GetMarketProductsUseCase(Get.find<MarketRepository>()));

    // Controllers
    Get.lazyPut(
      () => ProductDetailController(
        Get.find<GetProductDetailUseCase>(),
        Get.find<GetRelatedProductsUseCase>(),
        Get.find<AddToCartUseCase>(),
      ),
    );
    Get.lazyPut(() => CartController(Get.find<GetCartItemsUseCase>()));
    Get.lazyPut(
      () => CheckoutController(
        Get.find<GetDeliveryAddressesUseCase>(),
        Get.find<SaveDeliveryAddressUseCase>(),
        Get.find<ProcessCheckoutUseCase>(),
        Get.find<GetCartItemsUseCase>(),
      ),
    );
    Get.lazyPut(
      () => MarketArtistProfileController(Get.find<GetArtistProductsUseCase>()),
    );
    Get.lazyPut(
      () => MarketController(Get.find<GetMarketProductsUseCase>()),
    );
  }
}
