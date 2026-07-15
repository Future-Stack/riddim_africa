import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.hintText = 'Search products, artists...',
    this.onChanged,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        style: AppTextStyle(
          context,
        ).mediumTextStyle(color: AppColors.primary, fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(
              IconPath.search, // path to your svg
              width: 20.h,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                AppColors
                    .primarytext, // tint the icon if it's a single-color svg
                BlendMode.srcIn,
              ),
            ),
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Iconsax.microphone_2,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }
}
