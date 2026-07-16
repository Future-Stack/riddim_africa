import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';

class OrdersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? orderNumber;
  final DateTime? orderDate;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const OrdersAppBar({
    super.key,
    this.title,
    this.orderNumber,
    this.orderDate,
    this.titleWidget,
    this.actions,
    this.onBackPressed,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget? appBarTitle;

    if (titleWidget != null) {
      appBarTitle = titleWidget;
    } else if (orderNumber != null) {
      appBarTitle = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order $orderNumber',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: AppTextStyle.md),
          ),
          if (orderDate != null) ...[
            const SizedBox(height: 2),
            Text(
              _formatDate(orderDate!),
              style: AppTextStyle(context).regularTextStyle(
                color: AppColors.primarytext,
                fontSize: AppTextStyle.xs,
              ),
            ),
          ],
        ],
      );
    } else if (title != null) {
      appBarTitle = Text(
        title!,
        style: AppTextStyle(
          context,
        ).boldTextStyle(color: AppColors.white, fontSize: AppTextStyle.lg),
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
                    color: AppColors.primaryappbrownsecond,
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
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
