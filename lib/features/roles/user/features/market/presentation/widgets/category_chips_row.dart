import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class CategoryChipsRow extends StatelessWidget {
  final String selectedMainCategory;
  final String selectedSubCategory;
  final ValueChanged<String>? onMainCategorySelected;
  final ValueChanged<String>? onSubCategorySelected;

  const CategoryChipsRow({
    super.key,
    required this.selectedMainCategory,
    required this.selectedSubCategory,
    this.onMainCategorySelected,
    this.onSubCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Row: Main Categories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _buildIconChip(
                context: context,
                label: 'Featured',
                icon: Iconsax.magic_star,
                isActive: selectedMainCategory == 'Featured',
                activeColor: const Color(0xFF6B3A64), // Purple
                onTap: () => onMainCategorySelected?.call('Featured'),
              ),
              const SizedBox(width: 12),
              _buildIconChip(
                context: context,
                label: 'Trending',
                icon: Icons.local_fire_department_outlined,
                isActive: selectedMainCategory == 'Trending',
                onTap: () => onMainCategorySelected?.call('Trending'),
              ),
              const SizedBox(width: 12),
              _buildIconChip(
                context: context,
                label: 'New Arrivals',
                icon: Iconsax.clock,
                isActive: selectedMainCategory == 'New Arrivals',
                onTap: () => onMainCategorySelected?.call('New Arrivals'),
              ),
              const SizedBox(width: 12),
              _buildIconChip(
                context: context,
                label: 'Artist Merch',
                icon: Iconsax.star,
                isActive: selectedMainCategory == 'Artist Merch',
                onTap: () => onMainCategorySelected?.call('Artist Merch'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Divider (subtle dark divider)
        Divider(
          color: AppColors.primaryappbrownsecond.withValues(alpha: 0.5),
          thickness: 1,
          height: 1,
        ),
        const SizedBox(height: 16),
        // Second Row: Sub Categories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _buildTextChip(
                context: context,
                label: 'All',
                isActive: selectedSubCategory == 'All',
                activeColor: AppColors.bordercolor, // Teal
                onTap: () => onSubCategorySelected?.call('All'),
              ),
              const SizedBox(width: 12),
              _buildTextChip(
                context: context,
                label: 'Clothing',
                isActive: selectedSubCategory == 'Clothing',
                onTap: () => onSubCategorySelected?.call('Clothing'),
              ),
              const SizedBox(width: 12),
              _buildTextChip(
                context: context,
                label: 'Digital Product',
                isActive: selectedSubCategory == 'Digital Product',
                onTap: () => onSubCategorySelected?.call('Digital Product'),
              ),
              const SizedBox(width: 12),
              _buildTextChip(
                context: context,
                label: 'Art',
                isActive: selectedSubCategory == 'Art',
                onTap: () => onSubCategorySelected?.call('Art'),
              ),
              const SizedBox(width: 12),
              _buildTextChip(
                context: context,
                label: 'Crafts',
                isActive: selectedSubCategory == 'Crafts',
                onTap: () => onSubCategorySelected?.call('Crafts'),
              ),
              const SizedBox(width: 12),
              _buildTextChip(
                context: context,
                label: 'Music Merch',
                isActive: selectedSubCategory == 'Music Merch',
                onTap: () => onSubCategorySelected?.call('Music Merch'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconChip({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isActive,
    Color activeColor = AppColors.bordercolor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: isActive ? activeColor : AppColors.bordercolor,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: isActive
                  ? AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    )
                  : AppTextStyle(context).mediumTextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextChip({
    required BuildContext context,
    required String label,
    required bool isActive,
    Color activeColor = AppColors.bordercolor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: isActive ? activeColor : AppColors.bordercolor,
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: isActive
              ? AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                )
              : AppTextStyle(context).mediumTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 14,
                ),
        ),
      ),
    );
  }
}
