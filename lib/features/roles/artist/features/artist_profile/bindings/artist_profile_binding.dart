import 'package:get/get.dart';
import '../controllers/artist_profile_controller.dart';
import '../controllers/artist_edit_profile_controller.dart';
import '../controllers/artist_verification_controller.dart';
import '../controllers/artist_documents_controller.dart';
import '../controllers/artist_reviews_controller.dart';
import '../controllers/artist_payment_controller.dart';
import '../controllers/artist_support_controller.dart';
import '../controllers/artist_chat_controller.dart';
import '../controllers/artist_settings_controller.dart';
import '../controllers/artist_change_password_controller.dart';

class ArtistProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistProfileController>(() => ArtistProfileController());
    Get.lazyPut<ArtistEditProfileController>(
        () => ArtistEditProfileController());
    Get.lazyPut<ArtistVerificationController>(
        () => ArtistVerificationController());
    Get.lazyPut<ArtistDocumentsController>(() => ArtistDocumentsController());
    Get.lazyPut<ArtistReviewsController>(() => ArtistReviewsController());
    Get.lazyPut<ArtistPaymentController>(() => ArtistPaymentController());
    Get.lazyPut<ArtistSupportController>(() => ArtistSupportController());
    Get.lazyPut<ArtistChatController>(() => ArtistChatController());
    Get.lazyPut<ArtistSettingsController>(() => ArtistSettingsController());
    Get.lazyPut<ArtistChangePasswordController>(
        () => ArtistChangePasswordController());
  }
}
