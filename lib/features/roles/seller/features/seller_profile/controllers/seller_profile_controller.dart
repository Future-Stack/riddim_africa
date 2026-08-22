import 'package:get/get.dart';
import '../data/models/seller_profile_model.dart';

class SellerProfileController extends GetxController {
  final Rx<SellerProfileModel> profile = SellerProfileModel.mockSeller.obs;
  final RxBool isLoading = false.obs;

  void refreshProfile() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      profile.value = SellerProfileModel.mockSeller;
      isLoading.value = false;
    });
  }

  void updateProfile(SellerProfileModel updated) {
    profile.value = updated;
  }
}
