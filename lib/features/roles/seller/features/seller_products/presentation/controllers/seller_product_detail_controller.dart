import 'package:get/get.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../data/models/seller_product_model.dart';
import '../../data/models/review_timeline_step_model.dart';

class SellerProductDetailController extends GetxController {
  late final Rx<SellerProductModel> product;
  final RxList<ReviewTimelineStepModel> timelineSteps = <ReviewTimelineStepModel>[].obs;
  final RxString overallProgress = '3/7 steps'.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is SellerProductModel) {
      product = (Get.arguments as SellerProductModel).obs;
    } else {
      product = const SellerProductModel(
        id: '1',
        name: 'Kente Fabric Roll (6 yards)',
        code: 'PRD-2024-00182',
        category: 'Textiles & Fabrics',
        submittedDate: 'Jun 15, 2026',
        status: SellerProductStatus.live,
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=600',
        material: '100% Handwoven Cotton',
        origin: 'Kumasi, Ghana',
        totalOrders: 14,
        totalRevenue: 175000,
        monthlyEarningsGrowth: '+31% this month',
        rating: 4.9,
        reviewsCount: 57,
        ratingDistribution: {5: 46, 4: 8, 3: 2, 2: 1, 1: 0},
      ).obs;
    }

    timelineSteps.assignAll(ReviewTimelineStepModel.getSampleSteps());
  }

  void navigateToAdminChat() {
    Get.toNamed(AppRoute.sellerAdminChat);
  }

  void navigateToEditSubmission() {
    Get.toNamed(AppRoute.sellerSubmitProduct);
  }
}
