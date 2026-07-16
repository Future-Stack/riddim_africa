import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/notification_model.dart';

class NotificationDetailSheet extends StatelessWidget {
  final NotificationModel item;

  const NotificationDetailSheet({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.purple.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.purple.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        item.category.toUpperCase(),
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            item.subtitle,
            style: AppTextStyle(context).regularTextStyle(
              color: AppColors.primarytext,
              fontSize: 15,
              lineHeight: 22,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            item.timeAgo,
            style: AppTextStyle(context).regularTextStyle(
              color: AppColors.primarytext.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ProElevatedButton(
                  text: 'Close',
                  backgroundColor: AppColors.primaryappbrownsecond,
                  textColor: AppColors.white,
                  borderRadius: 16,
                  height: 50,
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
