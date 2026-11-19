import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final bool showDivider;

  const GlobalAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.titleWidget,
    this.actions,
    this.onBackPressed,
    this.showBackButton = true,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget? appBarTitle;

    if (titleWidget != null) {
      appBarTitle = titleWidget;
    } else if (title != null) {
      appBarTitle = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title!,
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 18),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: AppTextStyle(
                context,
              ).regularTextStyle(color: AppColors.primarytext, fontSize: 12),
            ),
          ],
        ],
      );
    }

    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leadingWidth: 60,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: GestureDetector(
                onTap: onBackPressed ?? () => Get.back(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.appbardivider,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
            )
          : null,
      title: appBarTitle,
      centerTitle: false,
      actions: actions,
      bottom: showDivider
          ? PreferredSize(
              preferredSize: const Size.fromHeight(13),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Container(color: AppColors.appbardivider, height: 1),
                ],
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (showDivider ? 20 : 0));
}
