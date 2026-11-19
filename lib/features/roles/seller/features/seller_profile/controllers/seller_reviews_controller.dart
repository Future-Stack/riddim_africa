import 'package:get/get.dart';
import '../data/models/seller_review_model.dart';

class SellerReviewsController extends GetxController {
  final RxDouble avgRating = 4.8.obs;
  final RxInt totalReviews = 156.obs;
  final RxList<SellerRatingBreakdown> breakdowns =
      SellerRatingBreakdown.mockBreakdown.obs;
  final RxList<SellerReviewModel> reviews =
      SellerReviewModel.mockReviews.obs;
}
