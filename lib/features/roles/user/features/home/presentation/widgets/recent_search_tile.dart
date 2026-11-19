import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';

class RecentSearchTile extends StatelessWidget {
  final String query;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const RecentSearchTile({
    super.key,
    required this.query,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Icon(
              Iconsax.clock,
              color: AppColors.primarytext,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                query,
                style: AppTextStyle(context).mediumTextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(
                Icons.close,
                color: AppColors.primarytext,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
