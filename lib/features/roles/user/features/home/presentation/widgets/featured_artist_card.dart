import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_entity.dart';

class FeaturedArtistCard extends StatelessWidget {
  final ArtistEntity artist;
  final VoidCallback? onTap;

  const FeaturedArtistCard({super.key, required this.artist, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular Avatar with border
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.primarytext, width: 1.5),
                image: DecorationImage(
                  image: NetworkImage(artist.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Artist Name
            Text(
              artist.name,
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Genre
            Text(
              artist.genre,
              style: AppTextStyle(
                context,
              ).regularTextStyle(color: AppColors.primarytext, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Followers
            Text(
              artist.followers,
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.onboardingbutton, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
