import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/artist_profile_model.dart';

class ArtistProfileHeader extends StatelessWidget {
  final ArtistProfileModel profile;
  final VoidCallback? onAvatarTap;

  const ArtistProfileHeader({
    super.key,
    required this.profile,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar + Camera Badge
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: onAvatarTap,
                child: Container(
                  width: 88.w,
                  height: 88.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.onboardingbutton.withValues(alpha: 0.5),
                      width: 2.w,
                    ),
                  ),
                  child: ClipOval(
                    child: profile.avatarUrl.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: profile.avatarUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.primaryappbrownsecond,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.onboardingbutton,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.primaryappbrownsecond,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.primarytext,
                                size: 40,
                              ),
                            ),
                          )
                        : Image.file(
                            File(profile.avatarUrl),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: AppColors.primaryappbrownsecond,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.primarytext,
                                size: 40,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              // Camera Edit Badge Icon
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onAvatarTap,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 2.w,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 13.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        8.verticalSpace,

        // Verified Pill Badge
        if (profile.isVerified) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: const Color(0xFF163E1C),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF34C759).withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  color: const Color(0xFF34C759),
                  size: 12.sp,
                ),
                4.horizontalSpace,
                Text(
                  'Verified',
                  style: AppTextStyle(context).boldTextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF34C759),
                  ),
                ),
              ],
            ),
          ),
          8.verticalSpace,
        ],

        // Name
        Text(
          profile.name,
          style: AppTextStyle(context).boldTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        4.verticalSpace,

        // Email
        Text(
          profile.email,
          style: AppTextStyle(context).regularTextStyle(
            fontSize: 13.sp,
            color: AppColors.primarytext,
          ),
        ),
        4.verticalSpace,

        // Phone & City Location
        Text(
          '${profile.phone} • ${profile.city}, ${profile.country}',
          style: AppTextStyle(context).regularTextStyle(
            fontSize: 12.sp,
            color: AppColors.primarytext.withValues(alpha: 0.8),
          ),
        ),
        16.verticalSpace,

        // 3-Column Stats Row Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFF22140A),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.08),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Products Count
                Expanded(
                  child: _buildStatColumn(
                    context: context,
                    icon: Icons.shopping_bag_outlined,
                    value: profile.productsCount,
                    label: 'Products',
                  ),
                ),
                VerticalDivider(
                  color: AppColors.white.withValues(alpha: 0.08),
                  thickness: 1,
                  indent: 6,
                  endIndent: 6,
                ),
                // Sold Count
                Expanded(
                  child: _buildStatColumn(
                    context: context,
                    icon: Icons.monetization_on_outlined,
                    value: profile.soldCount,
                    label: 'Sold',
                  ),
                ),
                VerticalDivider(
                  color: AppColors.white.withValues(alpha: 0.08),
                  thickness: 1,
                  indent: 6,
                  endIndent: 6,
                ),
                // Ratings
                Expanded(
                  child: _buildStatColumn(
                    context: context,
                    icon: Icons.star_border,
                    value: profile.ratings,
                    label: 'Ratings',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xFFD49B53),
          size: 20.sp,
        ),
        6.verticalSpace,
        Text(
          value,
          style: AppTextStyle(context).boldTextStyle(
            fontSize: 15.sp,
            color: Colors.white,
          ),
        ),
        2.verticalSpace,
        Text(
          label,
          style: AppTextStyle(context).regularTextStyle(
            fontSize: 11.sp,
            color: AppColors.primarytext,
          ),
        ),
      ],
    );
  }
}
