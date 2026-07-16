import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel item;
  final VoidCallback onTap;
  final VoidCallback onViewTap;

  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon section
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.primaryappbrownsecond,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                item.iconPath,
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(
                  AppColors.bordercolor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Text Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (item.isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 14,
                      lineHeight: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.timeAgo,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext.withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                      GestureDetector(
                        onTap: onViewTap,
                        child: Text(
                          'View',
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.secondary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
