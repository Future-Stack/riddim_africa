import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riddimafrica/core/core.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.hintText = 'Search products, artists...',
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.autofocus = false,
    this.onSubmitted,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h, // fixed height keeps everything centered predictably
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
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        autofocus: autofocus,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textAlignVertical:
            TextAlignVertical.center, // <-- centers text vertically
        style: AppTextStyle(
          context,
        ).mediumTextStyle(color: AppColors.primary, fontSize: 16),
        decoration: InputDecoration(
          isCollapsed: true, // <-- removes default internal padding quirks
          hintText: hintText,
          hintStyle: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 12.sp),
          prefixIcon: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: SvgPicture.asset(
              IconPath.search,
              width: 15.h,
              height: 15.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primarytext,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 44.h,
            minHeight: 15.h,
          ),
          suffixIcon: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: SvgPicture.asset(
              IconPath.microphone,
              width: 15.h,
              height: 15.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primarytext,
                BlendMode.srcIn,
              ),
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 44.h,
            minHeight: 15.h,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
