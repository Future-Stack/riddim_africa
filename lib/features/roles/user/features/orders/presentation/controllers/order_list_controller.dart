import 'package:get/get.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_stats_entity.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/get_order_stats_usecase.dart';

class OrderListController extends GetxController {
  final GetOrdersUseCase _getOrdersUseCase;
  final GetOrderStatsUseCase _getOrderStatsUseCase;

  OrderListController(this._getOrdersUseCase, this._getOrderStatsUseCase);

  final RxBool isLoading = true.obs;
  final RxList<OrderEntity> orders = <OrderEntity>[].obs;
  final RxList<OrderEntity> filteredOrders = <OrderEntity>[].obs;
  final Rx<OrderStatsEntity> stats = OrderStatsEntity().obs;
  final RxString selectedFilter = 'All'.obs;

  final List<String> filterOptions = ['All', 'Active','Processing', 'Shipped', 'Delivered','canceled'];

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading.value = true;
    try {
      orders.value = await _getOrdersUseCase.execute();
      stats.value = await _getOrderStatsUseCase.execute();
      applyFilter();
    } catch (_) {
      Get.snackbar('Error', 'Failed to load orders');
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void applyFilter() {
    if (selectedFilter.value == 'All') {
      filteredOrders.value = orders;
    } else {
      filteredOrders.value = orders
          .where((o) =>
              o.statusLabel.toLowerCase() == selectedFilter.value.toLowerCase())
          .toList();
    }
  }
}
