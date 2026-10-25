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

  final List<String> filterOptions = ['All', 'Active', 'Delivered', 'Cancelled'];

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders([String? status]) async {
    isLoading.value = true;
    final filter = status ?? selectedFilter.value;
    try {
      orders.value = await _getOrdersUseCase.execute(status: filter);
      applyFilter();
      try {
        stats.value = await _getOrderStatsUseCase.execute();
      } catch (_) {}
    } catch (_) {
      Get.snackbar('Error', 'Failed to load orders');
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    if (selectedFilter.value == filter && !isLoading.value) return;
    selectedFilter.value = filter;
    loadOrders(filter);
  }

  void applyFilter() {
    final filter = selectedFilter.value.toLowerCase();
    if (filter == 'all') {
      filteredOrders.value = orders;
    } else if (filter == 'active') {
      final activeList = orders
          .where((o) =>
              o.statusLabel.toLowerCase() != 'delivered' &&
              o.statusLabel.toLowerCase() != 'cancelled' &&
              o.statusLabel.toLowerCase() != 'canceled')
          .toList();
      filteredOrders.value = activeList.isNotEmpty ? activeList : orders;
    } else if (filter == 'cancelled') {
      final cancelledList = orders
          .where((o) =>
              o.statusLabel.toLowerCase() == 'cancelled' ||
              o.statusLabel.toLowerCase() == 'canceled')
          .toList();
      filteredOrders.value = cancelledList.isNotEmpty ? cancelledList : orders;
    } else if (filter == 'delivered') {
      final deliveredList = orders
          .where((o) => o.statusLabel.toLowerCase() == 'delivered')
          .toList();
      filteredOrders.value = deliveredList.isNotEmpty ? deliveredList : orders;
    } else {
      final matchedList = orders
          .where((o) => o.statusLabel.toLowerCase() == filter)
          .toList();
      filteredOrders.value = matchedList.isNotEmpty ? matchedList : orders;
    }
  }
}
