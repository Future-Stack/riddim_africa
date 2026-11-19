import 'package:get/get.dart';
import '../presentation/controllers/seller_orders_controller.dart';
import '../presentation/controllers/seller_order_shipment_controller.dart';

class SellerOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerOrdersController>(() => SellerOrdersController());
    Get.lazyPut<SellerOrderShipmentController>(
      () => SellerOrderShipmentController(),
    );
  }
}
