import 'package:get/get.dart';
import '../controllers/seller_profile_controller.dart';
import '../controllers/seller_edit_profile_controller.dart';
import '../controllers/seller_verification_controller.dart';
import '../controllers/seller_documents_controller.dart';
import '../controllers/seller_reviews_controller.dart';
import '../controllers/seller_payment_controller.dart';
import '../controllers/seller_support_controller.dart';
import '../controllers/seller_chat_controller.dart';
import '../controllers/seller_settings_controller.dart';
import '../controllers/seller_change_password_controller.dart';

class SellerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerProfileController>(() => SellerProfileController());
    Get.lazyPut<SellerEditProfileController>(
        () => SellerEditProfileController());
    Get.lazyPut<SellerVerificationController>(
        () => SellerVerificationController());
    Get.lazyPut<SellerDocumentsController>(() => SellerDocumentsController());
    Get.lazyPut<SellerReviewsController>(() => SellerReviewsController());
    Get.lazyPut<SellerPaymentController>(() => SellerPaymentController());
    Get.lazyPut<SellerSupportController>(() => SellerSupportController());
    Get.lazyPut<SellerChatController>(() => SellerChatController());
    Get.lazyPut<SellerSettingsController>(() => SellerSettingsController());
    Get.lazyPut<SellerChangePasswordController>(
        () => SellerChangePasswordController());
  }
}
