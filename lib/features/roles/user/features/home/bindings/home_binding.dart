import 'package:get/get.dart';
import 'package:riddimafrica/features/notification/bindings/notification_binding.dart';
import 'package:riddimafrica/features/roles/user/features/radio/bindings/radio_binding.dart';
import 'package:riddimafrica/features/roles/user/features/market/binding/market_binding.dart';
import 'package:riddimafrica/features/roles/user/features/profile/binding/profile_binding.dart';
import 'package:riddimafrica/features/roles/user/features/settings/binding/settings_binding.dart';
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
    RadioBinding().dependencies();
    MarketBinding().dependencies();
    ProfileBinding().dependencies();
    SettingsBinding().dependencies();
    NotificationBinding().dependencies();

    // Home specific registrations
    Get.lazyPut<HomeLocalDataSource>(() => HomeLocalDataSourceImpl());
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(Get.find<HomeLocalDataSource>()),
    );
    Get.lazyPut(() => GetHomeProductsUseCase(Get.find<HomeRepository>()));
    Get.lazyPut(() => GetSuggestedArtistsUseCase(Get.find<HomeRepository>()));
    Get.lazyPut(
      () => GlobalSearchController(
        Get.find<GetHomeProductsUseCase>(),
        Get.find<GetSuggestedArtistsUseCase>(),
      ),
    );
    Get.lazyPut(
      () => UserHomeController(Get.find<GetHomeProductsUseCase>()),
    );
  }
}

