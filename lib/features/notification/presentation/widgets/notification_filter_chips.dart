import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/notification_controller.dart';

class NotificationFilterChips extends StatelessWidget {
  final NotificationController controller;

  const NotificationFilterChips({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'key': 'all', 'label': 'All'},
      {'key': 'orders', 'label': 'Orders'},
      {'key': 'radio', 'label': 'Radio'},
      {'key': 'artists', 'label': 'Artists'},
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Obx(() {
            final isSelected = controller.selectedCategory.value == cat['key'];
            return GestureDetector(
              onTap: () => controller.setCategory(cat['key']!),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.purple : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: AppColors.bordercolor,
                          width: 1.2,
                        ),
                ),
                child: Text(
                  cat['label']!,
                  style: AppTextStyle().mediumTextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
