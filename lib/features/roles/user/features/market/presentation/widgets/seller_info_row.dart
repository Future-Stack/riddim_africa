import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class SellerInfoRow extends StatelessWidget {
  final String sellerName;
  final String avatarUrl;
  final bool isVerified;
  final double rating;
  final int salesCount;
  final VoidCallback? onTap;

  const SellerInfoRow({
    super.key,
    required this.sellerName,
    this.avatarUrl = '',
    this.isVerified = false,
    this.rating = 0.0,
    this.salesCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrownsecond,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Row(
          children: [
            // Seller Avatar
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primaryappbrown,
              backgroundImage: avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl.isEmpty
                  ? const Icon(
                      Iconsax.user,
                      color: AppColors.primarytext,
                      size: 20,
                    )
                  : null,
            ),
            const SizedBox(width: 12),

            // Seller Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        sellerName,
                        style: AppTextStyle(context).semiBoldTextStyle(
                          color: AppColors.white,
                          fontSize: AppTextStyle.lg,
                        ),
                      ),
                      if (isVerified) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.verified,
                          color: AppColors.success,
                          size: 18,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Verified Seller • $rating ★ • $salesCount sales',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
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
