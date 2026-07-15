import 'package:get/get.dart';
import '../data/datasources/order_local_data_source.dart';
import '../data/datasources/order_local_data_source_impl.dart';
import '../data/repositories/order_repository_impl.dart';
import '../domain/repositories/order_repository.dart';
import '../domain/usecases/get_orders_usecase.dart';
import '../domain/usecases/get_order_detail_usecase.dart';
import '../domain/usecases/get_tracking_events_usecase.dart';
import '../domain/usecases/get_order_stats_usecase.dart';
import '../presentation/controllers/order_list_controller.dart';
import '../presentation/controllers/order_detail_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderLocalDataSource>(() => OrderLocalDataSourceImpl());

    Get.lazyPut<OrderRepository>(
      () => OrderRepositoryImpl(Get.find<OrderLocalDataSource>()),
    );

    Get.lazyPut(() => GetOrdersUseCase(Get.find<OrderRepository>()));
    Get.lazyPut(() => GetOrderDetailUseCase(Get.find<OrderRepository>()));
    Get.lazyPut(
      () => GetTrackingEventsUseCase(Get.find<OrderRepository>()),
    );
    Get.lazyPut(() => GetOrderStatsUseCase(Get.find<OrderRepository>()));

    Get.lazyPut(
      () => OrderListController(
        Get.find<GetOrdersUseCase>(),
        Get.find<GetOrderStatsUseCase>(),
      ),
    );
    Get.lazyPut(
      () => OrderDetailController(
        Get.find<GetOrderDetailUseCase>(),
        Get.find<GetTrackingEventsUseCase>(),
      ),
    );
  }
}
