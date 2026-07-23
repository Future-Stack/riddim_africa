import 'package:get/get.dart';
import '../data/datasources/artist_home_remote_data_source.dart';
import '../data/repositories/artist_home_repository_impl.dart';
import '../domain/repositories/artist_home_repository.dart';
import '../domain/usecases/get_artist_dashboard_stats_usecase.dart';
import '../domain/usecases/get_artist_recent_orders_usecase.dart';
import '../presentation/controllers/artist_home_controller.dart';

class ArtistHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistHomeRemoteDataSource>(() => ArtistHomeRemoteDataSource());
    Get.lazyPut<ArtistHomeRepository>(
        () => ArtistHomeRepositoryImpl(Get.find<ArtistHomeRemoteDataSource>()));
    Get.lazyPut(() => GetArtistDashboardStatsUseCase(Get.find<ArtistHomeRepository>()));
    Get.lazyPut(() => GetArtistRecentOrdersUseCase(Get.find<ArtistHomeRepository>()));
    Get.lazyPut(() => ArtistHomeController(
        Get.find<GetArtistDashboardStatsUseCase>(),
        Get.find<GetArtistRecentOrdersUseCase>()));
  }
}
