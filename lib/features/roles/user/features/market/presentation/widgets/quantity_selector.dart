import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quantity',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onDecrement,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primaryappbrownsecond,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.remove,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '$quantity',
              style: AppTextStyle(context).boldTextStyle(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: onIncrement,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
