import 'package:get/get.dart';
import '../presentation/controllers/artist_revenue_controller.dart';
import '../presentation/controllers/artist_request_payment_controller.dart';

class ArtistRevenueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistRevenueController>(() => ArtistRevenueController());
    Get.lazyPut<ArtistRequestPaymentController>(
      () => ArtistRequestPaymentController(),
    );
  }
}
