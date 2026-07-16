import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_entity.dart';

class SuggestedArtistTile extends StatelessWidget {
  final ArtistEntity artist;
  final VoidCallback onTap;

  const SuggestedArtistTile({
    super.key,
    required this.artist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                artist.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: AppColors.primaryappbrownsecond,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primarytext,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              artist.name,
              style: AppTextStyle(context).mediumTextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              artist.genre,
              style: AppTextStyle(context).regularTextStyle(
                color: AppColors.primarytext,
                fontSize: 12,
              ),
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
