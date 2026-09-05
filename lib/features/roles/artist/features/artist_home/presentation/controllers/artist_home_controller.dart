import 'package:get/get.dart';
import '../../domain/entities/artist_dashboard_stats_entity.dart';
import '../../domain/entities/artist_recent_order_entity.dart';
import '../../domain/usecases/get_artist_dashboard_stats_usecase.dart';
import '../../domain/usecases/get_artist_recent_orders_usecase.dart';

class ArtistHomeController extends GetxController {
  final GetArtistDashboardStatsUseCase _getStatsUseCase;
  final GetArtistRecentOrdersUseCase _getRecentOrdersUseCase;

  ArtistHomeController(this._getStatsUseCase, this._getRecentOrdersUseCase);

  final RxBool isLoading = false.obs;
  final RxBool isBannerVisible = true.obs;

  final Rxn<ArtistDashboardStatsEntity> stats = Rxn<ArtistDashboardStatsEntity>();
  final RxList<ArtistRecentOrderEntity> recentOrders = <ArtistRecentOrderEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        _getStatsUseCase.execute(),
        _getRecentOrdersUseCase.execute(),
      ]);

      stats.value = results[0] as ArtistDashboardStatsEntity;
      recentOrders.value = results[1] as List<ArtistRecentOrderEntity>;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load seller dashboard data');
    } finally {
      isLoading.value = false;
    }
  }

  void hideBanner() {
    isBannerVisible.value = false;
  }
}
