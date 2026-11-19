import 'package:get/get.dart';
import '../../domain/entities/seller_dashboard_stats_entity.dart';
import '../../domain/entities/seller_recent_order_entity.dart';
import '../../domain/usecases/get_seller_dashboard_stats_usecase.dart';
import '../../domain/usecases/get_seller_recent_orders_usecase.dart';

class SellerHomeController extends GetxController {
  final GetSellerDashboardStatsUseCase _getStatsUseCase;
  final GetSellerRecentOrdersUseCase _getRecentOrdersUseCase;

  SellerHomeController(this._getStatsUseCase, this._getRecentOrdersUseCase);

  final RxBool isLoading = false.obs;
  final RxBool isBannerVisible = true.obs;

  final Rxn<SellerDashboardStatsEntity> stats = Rxn<SellerDashboardStatsEntity>();
  final RxList<SellerRecentOrderEntity> recentOrders = <SellerRecentOrderEntity>[].obs;

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

      stats.value = results[0] as SellerDashboardStatsEntity;
      recentOrders.value = results[1] as List<SellerRecentOrderEntity>;
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
