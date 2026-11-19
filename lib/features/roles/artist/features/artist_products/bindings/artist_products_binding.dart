import 'package:get/get.dart';
import '../presentation/controllers/artist_products_controller.dart';
import '../presentation/controllers/submit_product_controller.dart';
import '../presentation/controllers/artist_product_detail_controller.dart';
import '../presentation/controllers/artist_admin_chat_controller.dart';

class ArtistProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistProductsController>(() => ArtistProductsController());
    Get.lazyPut<ArtistSubmitProductController>(() => ArtistSubmitProductController());
    Get.lazyPut<ArtistProductDetailController>(() => ArtistProductDetailController());
    Get.lazyPut<ArtistAdminChatController>(() => ArtistAdminChatController());
  }
}
