import 'package:get/get.dart';
import '../presentation/controllers/artist_orders_controller.dart';
import '../presentation/controllers/artist_order_shipment_controller.dart';

class ArtistOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistOrdersController>(() => ArtistOrdersController());
    Get.lazyPut<ArtistOrderShipmentController>(
      () => ArtistOrderShipmentController(),
    );
  }
}
