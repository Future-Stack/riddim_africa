import 'package:get/get.dart';
import '../data/datasources/seller_home_remote_data_source.dart';
import '../data/repositories/seller_home_repository_impl.dart';
import '../domain/repositories/seller_home_repository.dart';
import '../domain/usecases/get_seller_dashboard_stats_usecase.dart';
import '../domain/usecases/get_seller_recent_orders_usecase.dart';
import '../presentation/controllers/seller_home_controller.dart';

class SellerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerHomeRemoteDataSource>(() => SellerHomeRemoteDataSource());
    Get.lazyPut<SellerHomeRepository>(
        () => SellerHomeRepositoryImpl(Get.find<SellerHomeRemoteDataSource>()));
    Get.lazyPut(() => GetSellerDashboardStatsUseCase(Get.find<SellerHomeRepository>()));
    Get.lazyPut(() => GetSellerRecentOrdersUseCase(Get.find<SellerHomeRepository>()));
    Get.lazyPut(() => SellerHomeController(
        Get.find<GetSellerDashboardStatsUseCase>(),
        Get.find<GetSellerRecentOrdersUseCase>()));
  }
}
