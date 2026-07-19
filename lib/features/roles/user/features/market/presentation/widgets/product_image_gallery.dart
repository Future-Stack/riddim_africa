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
    final displayImage =
        galleryImages.isNotEmpty && selectedIndex < galleryImages.length
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(galleryImages.length, (index) {
                  final isSelected = selectedIndex == index;
                  final size = isSelected ? 54.0 : 40.0;

                  return GestureDetector(
                    onTap: () => onImageSelected?.call(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      width: size,
                      height: size,
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          isSelected ? 10.0 : 8.0,
                        ),

                        border: isSelected
                            ? Border.all(
                                color: const Color(0xFFE3A63E),
                                width: 2.0,
                              )
                            : null,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          isSelected ? 7.0 : 8.0,
                        ),
                        child: Image.network(
                          galleryImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: AppColors.primaryappbrown,
                                child: const Icon(
                                  Iconsax.image,
                                  color: AppColors.primarytext,
                                  size: 14,
                                ),
                              ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
