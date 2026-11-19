import 'package:get/get.dart';
import '../data/models/artist_profile_model.dart';

class ArtistProfileController extends GetxController {
  final Rx<ArtistProfileModel> profile = ArtistProfileModel.mockArtist.obs;
  final RxBool isLoading = false.obs;

  void refreshProfile() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      profile.value = ArtistProfileModel.mockArtist;
      isLoading.value = false;
    });
  }

  void updateProfile(ArtistProfileModel updated) {
    profile.value = updated;
  }
}
