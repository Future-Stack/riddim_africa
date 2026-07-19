import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String sellerName;
  final String selectedColor;
  final String selectedSize;
  final String price;
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.sellerName,
    this.selectedColor = '',
    this.selectedSize = '',
    required this.price,
    this.quantity = 1,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primaryappbrown,
                  child: const Icon(
                    Iconsax.image,
                    color: AppColors.primarytext,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle(context).semiBoldTextStyle(
                    color: AppColors.white,
                    fontSize: AppTextStyle.lg,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  sellerName,
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: AppTextStyle.sm,
                  ),
                ),
                if (selectedColor.isNotEmpty || selectedSize.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    _buildVariantText(),
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  price,
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: AppTextStyle.md,
                  ),
                ),
                const SizedBox(height: 10),

                // Quantity Controls & Delete
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onTap: onDecrement,
                      color: AppColors.primaryappbrownsecond,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        '$quantity',
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.white,
                          fontSize: AppTextStyle.lg,
                        ),
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onTap: onIncrement,
                      color: AppColors.purple,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Icon(
                          Iconsax.trash,
                          color: AppColors.error,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    VoidCallback? onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
    );
  }

  String _buildVariantText() {
    final parts = <String>[];
    if (selectedColor.isNotEmpty) parts.add('Color: $selectedColor');
    if (selectedSize.isNotEmpty) parts.add('Size: $selectedSize');
    return parts.join(', ');
  }
}
