import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:riddimafrica/core/core.dart';
import '../../controllers/seller_reviews_controller.dart';
import '../../data/models/seller_review_model.dart';
import '../widgets/seller_rating_breakdown_bar.dart';

class SellerReviewRatingsScreen extends StatelessWidget {
  const SellerReviewRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<SellerReviewsController>()
        ? Get.find<SellerReviewsController>()
        : Get.put(SellerReviewsController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Review & Ratings',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Stats Cards (Avg Rating & Reviews Count)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22140A),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.star_outline_rounded,
                            color: const Color(0xFFD49B53),
                            size: 24.sp,
                          ),
                          8.verticalSpace,
                          Obx(
                            () => Text(
                              controller.avgRating.value.toStringAsFixed(1),
                              style: AppTextStyle(context).boldTextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            'Avg Rating',
                            style: AppTextStyle(context).regularTextStyle(
                              fontSize: 11.sp,
                              color: AppColors.primarytext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22140A),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: const Color(0xFF34C759),
                            size: 24.sp,
                          ),
                          8.verticalSpace,
                          Obx(
                            () => Text(
                              '${controller.totalReviews.value}',
                              style: AppTextStyle(context).boldTextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            'Reviews',
                            style: AppTextStyle(context).regularTextStyle(
                              fontSize: 11.sp,
                              color: AppColors.primarytext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              24.verticalSpace,

              // Rating Breakdown Section
              Text(
                'Rating Breakdown',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                ),
              ),
              12.verticalSpace,

              Obx(
                () => Column(
                  children: controller.breakdowns.map((b) {
                    return SellerRatingBreakdownBar(item: b);
                  }).toList(),
                ),
              ),
              24.verticalSpace,

              // Customer Reviews Section
              Text(
                'Customer Reviews',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                ),
              ),
              14.verticalSpace,

              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    final review = controller.reviews[index];
                    return _buildReviewCard(context, review);
                  },
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, SellerReviewModel review) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF22140A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info & Date Row
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 36.w,
                  height: 36.w,
                  child: CachedNetworkImage(
                    imageUrl: review.userAvatar,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.primaryappbrownsecond,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.onboardingbutton,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.primaryappbrownsecond,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primarytext,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                      ),
                    ),
                    2.verticalSpace,
                    // Stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < review.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: const Color(0xFFD49B53),
                          size: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                review.date,
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 11.sp,
                  color: AppColors.primarytext.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          10.verticalSpace,

          // Comment
          Text(
            review.comment,
            style: AppTextStyle(context).regularTextStyle(
              fontSize: 12.sp,
              color: AppColors.primarytext,
              lineHeight: 18,
            ),
          ),
        ],
      ),
    );
  }
}
