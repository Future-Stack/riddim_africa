import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class ProductSpecDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ProductSpecDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedValue = items.isNotEmpty ? items[selectedIndex] : 'None';
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 16),
        ),
        const SizedBox(width: 8),
        PopupMenuButton<int>(
          onSelected: onSelected,
          itemBuilder: (context) => items
              .asMap()
              .entries
              .map(
                (entry) => PopupMenuItem<int>(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: AppTextStyle(
                      context,
                    ).mediumTextStyle(color: AppColors.white, fontSize: 14),
                  ),
                ),
              )
              .toList(),
          color: AppColors.primaryappbrownsecond,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryappbrownsecond,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedValue,
                  style: AppTextStyle(
                    context,
                  ).mediumTextStyle(color: AppColors.white, fontSize: 14),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
