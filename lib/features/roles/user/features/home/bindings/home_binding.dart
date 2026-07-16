import 'package:get/get.dart';
import 'package:riddimafrica/features/notification/presentation/controllers/notification_controller.dart';
import 'package:riddimafrica/features/roles/user/features/radio/bindings/radio_binding.dart';
import 'package:riddimafrica/features/roles/user/features/market/binding/market_binding.dart';
import '../data/datasources/home_local_data_source.dart';
import '../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';
import '../domain/usecases/get_home_products_usecase.dart';
import '../domain/usecases/get_suggested_artists_usecase.dart';
import '../presentation/controllers/user_home_controller.dart';
import '../presentation/controllers/global_search_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<HomeLocalDataSource>(() => HomeLocalDataSourceImpl());
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(Get.find<HomeLocalDataSource>()));
    Get.lazyPut(() => GetHomeProductsUseCase(Get.find<HomeRepository>()));
    Get.lazyPut(() => GetSuggestedArtistsUseCase(Get.find<HomeRepository>()));
    Get.lazyPut(() => UserHomeController(Get.find<GetHomeProductsUseCase>()));
    Get.lazyPut(() => GlobalSearchController(
          Get.find<GetHomeProductsUseCase>(),
          Get.find<GetSuggestedArtistsUseCase>(),
        ));
        
    // Inject Radio and Market dependencies
    RadioBinding().dependencies();
    MarketBinding().dependencies();
  }
}
