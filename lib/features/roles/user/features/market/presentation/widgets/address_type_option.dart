import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class AddressTypeOption extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressTypeOption({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6B2657) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6B2657)
                : AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
        ),
        child: Text(
          type,
          style: AppTextStyle(context).mediumTextStyle(
            color: isSelected ? AppColors.white : AppColors.primarytext,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
