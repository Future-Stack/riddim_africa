import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class PaymentOptionCard extends StatelessWidget {
  final String methodName;
  final Color logoColor;
  final String imagepath;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionCard({
    super.key,
    required this.methodName,
    required this.logoColor,
    required this.imagepath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF6B2657) : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Row(
          children: [
            // Custom round icon representing provider
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: logoColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(imagepath),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              methodName,
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white, fontSize: 16),
            ),
            const Spacer(),
            // Outer Radio circle
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6B2657)
                      : AppColors.primarytext,
                  width: isSelected ? 1 : 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6B2657),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
