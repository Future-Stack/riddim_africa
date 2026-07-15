import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class RelatedProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback? onTap;

  const RelatedProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(24.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image - only top corners rounded (card handles the clip)
            AspectRatio(
              aspectRatio: 2,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primaryappbrown,
                  child: const Center(
                    child: Icon(
                      Iconsax.image,
                      color: AppColors.primarytext,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),

            // Text block with padding, like the screenshot
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle(context).semiBoldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.md,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.onboardingbutton,
                      fontSize: AppTextStyle.sm,
                    ),
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