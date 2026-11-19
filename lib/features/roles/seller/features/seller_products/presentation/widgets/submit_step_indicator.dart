import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class SubmitStepIndicator extends StatelessWidget {
  final int currentStep; // 1, 2, or 3

  const SubmitStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const steps = ['Product Details', 'Sample Images', 'Pricing & Stock'];

    return Column(
      children: [
        // Step Names
        Row(
          children: List.generate(steps.length, (index) {
            final stepIndex = index + 1;
            final isCurrent = currentStep == stepIndex;
            final isCompleted = currentStep > stepIndex;

            return Expanded(
              child: Text(
                steps[index],
                textAlign: TextAlign.center,
                style: AppTextStyle(context).mediumTextStyle(
                  color: isCurrent || isCompleted
                      ? AppColors.white
                      : AppColors.primarytext.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),

        // Progress Bar lines
        Row(
          children: List.generate(steps.length, (index) {
            final stepIndex = index + 1;
            final isActive = currentStep >= stepIndex;

            return Expanded(
              child: Container(
                height: 3,
                margin: EdgeInsets.only(
                  right: index < steps.length - 1 ? 6 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: isActive
                      ? const Color(0xFF00B4D8)
                      : AppColors.white.withValues(alpha: 0.12),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
