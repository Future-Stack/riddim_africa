import 'package:get/get.dart';
import '../presentation/controllers/seller_products_controller.dart';
import '../presentation/controllers/submit_product_controller.dart';
import '../presentation/controllers/seller_product_detail_controller.dart';
import '../presentation/controllers/seller_admin_chat_controller.dart';

class SellerProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerProductsController>(() => SellerProductsController());
    Get.lazyPut<SellerSubmitProductController>(() => SellerSubmitProductController());
    Get.lazyPut<SellerProductDetailController>(() => SellerProductDetailController());
    Get.lazyPut<SellerAdminChatController>(() => SellerAdminChatController());
  }
}
