import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final String categoryText;
  final String price;
  final bool isHot;
  final VoidCallback? onTap;

  // Global styling configurations
  final int? rank;
  final bool showFavoriteButton;
  final bool showRatingRow;
  final bool showAddButton;
  final String? actionText;
  final String? artistName;
  final String? artistAvatarUrl;
  final bool isVerifiedArtist;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.categoryText,
    required this.price,
    this.isHot = false,
    this.onTap,
    this.rank,
    this.showFavoriteButton = true,
    this.showRatingRow = true,
    this.showAddButton = true,
    this.actionText,
    this.artistName,
    this.artistAvatarUrl,
    this.isVerifiedArtist = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.primaryappbrownsecond.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Badges/overlays
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.h),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.primaryappbrown,
                          width: double.infinity,
                          child: const Icon(
                            Iconsax.image,
                            color: AppColors.primarytext,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Rank Circle Badge
                  if (rank != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF356E7A),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '#$rank',
                            style: AppTextStyle(context).boldTextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                  // HOT Badge
                  else if (isHot)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: AppColors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'HOT',
                              style: AppTextStyle(context).boldTextStyle(
                                color: AppColors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Favorite Button
                  if (showFavoriteButton)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.heart,
                          color: AppColors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  // Artist Avatar Overlay (overlapping image bottom-left)
                  if (artistAvatarUrl != null)
                    Positioned(
                      bottom: -15,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryappbrown,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 18.r,
                              backgroundImage: NetworkImage(artistAvatarUrl!),
                            ),
                            if (isVerifiedArtist)
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 8,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  // Artist Name Overlay
                  if (artistName != null)
                    Positioned(
                      bottom: -10,
                      left: 54.w,
                      child: Text(
                        artistName!,
                        style: AppTextStyle(
                          context,
                        ).boldTextStyle(color: AppColors.white, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),

            // Details Section
            Padding(
              padding: EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: 12.0,
                top: artistAvatarUrl != null ? 20.0 : 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(color: AppColors.white, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (showRatingRow) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.star1,
                          color: AppColors.onboardingbutton,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.onboardingbutton,
                            fontSize: 12,
                          ),
                        ),
                        if (categoryText.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '( $categoryText )',
                              style: AppTextStyle(context).mediumTextStyle(
                                color: AppColors.secondary,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          price,
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.onboardingbutton,
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (actionText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.purple,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            actionText!,
                            style: AppTextStyle(context).boldTextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                            ),
                          ),
                        )
                      else if (showAddButton)
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: AppColors.purple,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.add,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
