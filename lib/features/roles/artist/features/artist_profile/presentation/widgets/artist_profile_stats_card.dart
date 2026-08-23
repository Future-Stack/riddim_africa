import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/utils/constants/sizer.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';
import '../../domain/entities/artist_profile_entity.dart';

class ArtistProfileStatsCard extends StatelessWidget {
  final ArtistProfileEntity profile;

  const ArtistProfileStatsCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primarytext.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn(
            context,
            icon: Iconsax.bag_2,
            value: profile.productsCount,
            label: 'Products',
          ),
          _buildDivider(),
          _buildStatColumn(
            context,
            icon: Iconsax.dollar_circle,
            value: profile.soldCount,
            label: 'Sold',
          ),
          _buildDivider(),
          _buildStatColumn(
            context,
            icon: Iconsax.profile_2user,
            value: profile.followersCount,
            label: 'Followers',
          ),
          _buildDivider(),
          _buildStatColumn(
            context,
            icon: Iconsax.star,
            value: profile.rating,
            label: 'Ratings',
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22,
            color: const Color(0xFFE6B650), // Golden amber accent
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyle(context).boldTextStyle(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyle(context).regularTextStyle(
              color: AppColors.primarytext,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 38,
      width: 1,
      color: AppColors.primarytext.withValues(alpha: 0.2),
    );
  }
}
