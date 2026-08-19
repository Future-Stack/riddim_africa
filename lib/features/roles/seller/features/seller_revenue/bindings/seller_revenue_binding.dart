import 'package:get/get.dart';
import '../presentation/controllers/seller_revenue_controller.dart';
import '../presentation/controllers/seller_request_payment_controller.dart';

class SellerRevenueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerRevenueController>(() => SellerRevenueController());
    Get.lazyPut<SellerRequestPaymentController>(
      () => SellerRequestPaymentController(),
    );
  }
}
