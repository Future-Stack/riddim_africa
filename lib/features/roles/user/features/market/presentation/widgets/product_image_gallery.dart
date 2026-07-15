import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';

class ProductImageGallery extends StatelessWidget {
  final String mainImageUrl;
  final List<String> galleryImages;
  final int selectedIndex;
  final ValueChanged<int>? onImageSelected;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;
  final bool isFavorite;

  const ProductImageGallery({
    super.key,
    required this.mainImageUrl,
    this.galleryImages = const [],
    this.selectedIndex = 0,
    this.onImageSelected,
    this.onBackPressed,
    this.onFavoritePressed,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayImage = galleryImages.isNotEmpty && selectedIndex < galleryImages.length
        ? galleryImages[selectedIndex]
        : mainImageUrl;

    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          // Main Image
          Positioned.fill(
            child: Image.network(
              displayImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.primaryappbrown,
                child: const Center(
                  child: Icon(
                    Iconsax.image,
                    color: AppColors.primarytext,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: onBackPressed,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
            ),
          ),

          // Favorite Button
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: onFavoritePressed,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFavorite ? Iconsax.heart5 : Iconsax.heart,
                  color: isFavorite ? AppColors.secondary : AppColors.white,
                  size: 22,
                ),
              ),
            ),
          ),

          // Gallery Thumbnails
          if (galleryImages.isNotEmpty)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  galleryImages.length,
                  (index) => GestureDetector(
                    onTap: () => onImageSelected?.call(index),
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: selectedIndex == index
                              ? AppColors.white
                              : AppColors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          galleryImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.primaryappbrown,
                            child: const Icon(
                              Iconsax.image,
                              color: AppColors.primarytext,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
