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
    this.textColor,
    this.hintTextColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.prefixIconColor,
    this.suffixIconColor,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;

  // New optional customization params
  final Color? textColor;
  final Color? hintTextColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h, // fixed height keeps everything centered predictably
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth ?? 1.0)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.start,
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
        ).mediumTextStyle(color: textColor ?? AppColors.primary, fontSize: 16),
        decoration: InputDecoration(
          isCollapsed: true, // <-- removes default internal padding quirks
          hintText: hintText,
          hintStyle: AppTextStyle(context).mediumTextStyle(
            color: hintTextColor ?? AppColors.primarytext,
            fontSize: 12.sp,
          ),
          prefixIcon: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: SvgPicture.asset(
              IconPath.search,
              width: 18.h,
              height: 15.h,
              colorFilter: ColorFilter.mode(
                prefixIconColor ?? AppColors.primarytext,
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
              colorFilter: ColorFilter.mode(
                suffixIconColor ?? AppColors.appbardivider,
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
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}