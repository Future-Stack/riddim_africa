import 'package:get/get.dart';
import '../../data/models/artist_review_model.dart';

class ArtistFollowersRatingsController extends GetxController {
  final RxString followersCount = '1,245'.obs;
  final RxDouble avgRating = 4.8.obs;
  final RxInt totalReviews = 156.obs;

  final RxList<ArtistRatingBreakdown> breakdowns = <ArtistRatingBreakdown>[].obs;
  final RxList<ArtistReviewModel> reviews = <ArtistReviewModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadReviewsData();
  }

  void loadReviewsData() {
    breakdowns.assignAll(ArtistRatingBreakdown.mockBreakdown);
    reviews.assignAll(ArtistReviewModel.mockReviews);
  }
}
