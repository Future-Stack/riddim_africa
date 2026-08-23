import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_followers_ratings_controller.dart';
import '../../data/models/artist_review_model.dart';
import '../widgets/artist_rating_breakdown_bar.dart';

class ArtistFollowersRatingsScreen extends StatelessWidget {
  const ArtistFollowersRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistFollowersRatingsController>()
        ? Get.find<ArtistFollowersRatingsController>()
        : Get.put(ArtistFollowersRatingsController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Followers & Ratings',
        showDivider: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Top 3 Stat Cards ───────────────────────────────────────
              Row(
                children: [
                  // 1. Followers
                  Expanded(
                    child: _buildTopStatCard(
                      context: context,
                      icon: Iconsax.profile_2user,
                      iconColor: const Color(0xFFC084FC), // light purple
                      value: controller.followersCount.value,
                      label: 'Followers',
                    ),
                  ),
                  10.horizontalSpace,

                  // 2. Avg Rating
                  Expanded(
                    child: _buildTopStatCard(
                      context: context,
                      icon: Icons.star_outline_rounded,
                      iconColor: const Color(0xFFD49B53), // amber
                      value: controller.avgRating.value.toStringAsFixed(1),
                      label: 'Avg Rating',
                    ),
                  ),
                  10.horizontalSpace,

                  // 3. Reviews
                  Expanded(
                    child: _buildTopStatCard(
                      context: context,
                      icon: Icons.chat_bubble_outline_rounded,
                      iconColor: const Color(0xFF3BD5B8), // cyan/teal
                      value: '${controller.totalReviews.value}',
                      label: 'Reviews',
                    ),
                  ),
                ],
              ),
              20.verticalSpace,

              // ─── Rating Breakdown Card ──────────────────────────────────
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating Breakdown',
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    14.verticalSpace,
                    Obx(
                      () => Column(
                        children: controller.breakdowns.map((b) {
                          return ArtistRatingBreakdownBar(item: b);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // ─── Customer Reviews Section ───────────────────────────────
              Text(
                'Customer Reviews',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 16.sp,
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

  Widget _buildTopStatCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 22.sp),
          8.verticalSpace,
          Text(
            value,
            style: AppTextStyle(context).boldTextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          4.verticalSpace,
          Text(
            label,
            style: AppTextStyle(context).regularTextStyle(
              fontSize: 11.sp,
              color: AppColors.primarytext,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, ArtistReviewModel review) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular avatar with bold initial
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: review.avatarColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    review.initial,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                    3.verticalSpace,
                    // 5 filled stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.star_rounded,
                            color: const Color(0xFFD49B53),
                            size: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Date
              Text(
                review.date,
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 11.sp,
                  color: AppColors.primarytext.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Text(
              review.comment,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 12.sp,
                color: AppColors.primarytext,
                lineHeight: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
