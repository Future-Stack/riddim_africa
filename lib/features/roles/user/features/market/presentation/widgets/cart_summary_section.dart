import 'package:flutter/material.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class CartSummarySection extends StatelessWidget {
  final String subtotal;
  final String shippingFee;
  final String total;

  const CartSummarySection({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.primaryappbrownsecond, thickness: 1),
        const SizedBox(height: 12),

        // Subtotal
        _buildRow(
          context: context,
          label: 'Subtotal',
          value: subtotal,
          isTotal: false,
        ),
        const SizedBox(height: 8),

        // Shipping Fee
        _buildRow(
          context: context,
          label: 'Shipping Fee',
          value: shippingFee,
          isTotal: false,
        ),
        const SizedBox(height: 12),
        const Divider(color: AppColors.primaryappbrownsecond, thickness: 1),
        const SizedBox(height: 12),

        // Total
        _buildRow(
          context: context,
          label: 'Total',
          value: total,
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildRow({
    required BuildContext context,
    required String label,
    required String value,
    required bool isTotal,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.lg,
                )
              : AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: AppTextStyle.md,
                ),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyle(context).boldTextStyle(
                  color: AppColors.onboardingbutton,
                  fontSize: AppTextStyle.xl,
                )
              : AppTextStyle(context).semiBoldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.md,
                ),
        ),
      ],
    );
  }
}
