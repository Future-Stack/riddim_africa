import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final String categoryText;
  final String price;
  final bool isHot;
  final VoidCallback? onTap;

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
            // Image and Badges
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
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
                  // HOT Badge
                  if (isHot)
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
                ],
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          price,
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.onboardingbutton,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: AppColors.bordercolor, // Teal color
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
