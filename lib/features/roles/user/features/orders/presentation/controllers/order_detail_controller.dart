import 'package:get/get.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/tracking_event_entity.dart';
import '../../domain/usecases/get_order_detail_usecase.dart';
import '../../domain/usecases/get_tracking_events_usecase.dart';
import '../../domain/usecases/cancel_order_usecase.dart';
import '../../domain/usecases/confirm_delivery_usecase.dart';

class OrderDetailController extends GetxController {
  final GetOrderDetailUseCase _getOrderDetailUseCase;
  final GetTrackingEventsUseCase _getTrackingEventsUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;
  final ConfirmDeliveryUseCase _confirmDeliveryUseCase;

  OrderDetailController(
    this._getOrderDetailUseCase,
    this._getTrackingEventsUseCase,
    this._cancelOrderUseCase,
    this._confirmDeliveryUseCase,
  );

  final RxBool isLoading = true.obs;
  final Rx<OrderEntity?> order = Rx<OrderEntity?>(null);
  final RxList<TrackingEventEntity> trackingEvents =
      <TrackingEventEntity>[].obs;

  String? _orderId;

  @override
  void onInit() {
    super.onInit();
    _orderId = Get.arguments as String?;
    if (_orderId != null) {
      loadOrderDetail();
    }
  }

  Future<void> loadOrderDetail() async {
    if (_orderId == null) return;
    isLoading.value = true;
    try {
      order.value = await _getOrderDetailUseCase.execute(_orderId!);
      trackingEvents.value =
          await _getTrackingEventsUseCase.execute(_orderId!);
    } catch (_) {
      Get.snackbar('Error', 'Failed to load order details');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder() async {
    if (_orderId == null) return;
    isLoading.value = true;
    try {
      await _cancelOrderUseCase.execute(_orderId!);
      await loadOrderDetail();
      Get.snackbar('Success', 'Order cancelled successfully');
    } catch (_) {
      Get.snackbar('Error', 'Failed to cancel order');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmDelivery() async {
    if (_orderId == null) return;
    isLoading.value = true;
    try {
      await _confirmDeliveryUseCase.execute(_orderId!);
      await loadOrderDetail();
    } catch (_) {
      Get.snackbar('Error', 'Failed to confirm delivery');
    } finally {
      isLoading.value = false;
    }
  }
}
