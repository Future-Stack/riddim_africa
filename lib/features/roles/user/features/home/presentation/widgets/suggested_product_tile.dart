import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/product_entity.dart';

class SuggestedProductTile extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const SuggestedProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryappbrownsecond,
          ),
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: AppColors.primaryappbrownsecond,
                  child: const Icon(
                    Icons.image,
                    color: AppColors.primarytext,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppTextStyle(context).semiBoldTextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.price,
                    style: AppTextStyle(context).semiBoldTextStyle(
                      color: AppColors.onboardingbutton,
                      fontSize: 14,
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
