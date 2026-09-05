import 'package:get/get.dart';
import '../data/models/artist_review_model.dart';

class ArtistReviewsController extends GetxController {
  final RxDouble avgRating = 4.8.obs;
  final RxInt totalReviews = 156.obs;
  final RxList<ArtistRatingBreakdown> breakdowns =
      ArtistRatingBreakdown.mockBreakdown.obs;
  final RxList<ArtistReviewModel> reviews =
      ArtistReviewModel.mockReviews.obs;
}
