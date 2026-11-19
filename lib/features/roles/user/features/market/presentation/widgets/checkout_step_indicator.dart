import 'package:flutter/material.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class CheckoutStepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> stepLabels;

  const CheckoutStepIndicator({
    super.key,
    required this.currentStep,
    required this.stepLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(stepLabels.length, (index) {
        final isActive = index <= currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  // Connector Line (before)
                  if (index > 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isActive
                            ? AppColors.bordercolor
                            : AppColors.primaryappbrownsecond,
                      ),
                    ),

                  // Step Circle
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCurrent
                          ? AppColors.bordercolor
                          : isActive
                              ? AppColors.bordercolor.withValues(alpha: 0.6)
                              : AppColors.primaryappbrownsecond,
                      border: Border.all(
                        color: isActive
                            ? AppColors.bordercolor
                            : AppColors.primaryappbrownsecond,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: AppTextStyle(context).boldTextStyle(
                          color: isActive
                              ? AppColors.white
                              : AppColors.primarytext,
                          fontSize: AppTextStyle.sm,
                        ),
                      ),
                    ),
                  ),

                  // Connector Line (after)
                  if (index < stepLabels.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index < currentStep
                            ? AppColors.bordercolor
                            : AppColors.primaryappbrownsecond,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),

              // Step Label
              Text(
                stepLabels[index],
                style: AppTextStyle(context).mediumTextStyle(
                  color: isActive
                      ? AppColors.white
                      : AppColors.primarytext,
                  fontSize: AppTextStyle.xs,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
