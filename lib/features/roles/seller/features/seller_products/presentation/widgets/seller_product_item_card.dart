import 'dart:io';
import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_product_model.dart';

class SellerProductItemCard extends StatelessWidget {
  final SellerProductModel product;
  final VoidCallback onTap;

  const SellerProductItemCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.06),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildProductThumbnail(product.imageUrl),
            ),
            const SizedBox(width: 12),

            // Middle info: Title, Code • Category, Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.code} • ${product.category}',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Submitted ${product.submittedDate}',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext.withValues(alpha: 0.7),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right column: Status badge & Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStatusBadge(context),
                const SizedBox(height: 12),
                Text(
                  product.formattedPrice,
                  style: AppTextStyle(context).boldTextStyle(
                    color: const Color(0xFFFFB300),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color badgeColor;
    Color dotColor;
    String label;

    switch (product.status) {
      case SellerProductStatus.live:
        badgeColor = const Color(0xFF2E7D32).withValues(alpha: 0.2);
        dotColor = const Color(0xFF4CAF50);
        label = '• Live';
        break;
      case SellerProductStatus.pending:
        badgeColor = const Color(0xFFF57C00).withValues(alpha: 0.2);
        dotColor = const Color(0xFFFFB300);
        label = '• Pending';
        break;
      case SellerProductStatus.rejected:
        badgeColor = const Color(0xFFC62828).withValues(alpha: 0.2);
        dotColor = const Color(0xFFEF5350);
        label = '• Rejected';
        break;
      case SellerProductStatus.cancelled:
        badgeColor = const Color(0xFFC62828).withValues(alpha: 0.2);
        dotColor = const Color(0xFFEF5350);
        label = '• Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: AppTextStyle(context).boldTextStyle(
          color: dotColor,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildProductThumbnail(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        width: 68.w,
        height: 68.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else {
      final file = File(path);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: 68.w,
          height: 68.w,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        );
      } else {
        return Image.network(
          path,
          width: 68.w,
          height: 68.w,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        );
      }
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 68.w,
      height: 68.w,
      color: AppColors.white.withValues(alpha: 0.08),
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }
}
