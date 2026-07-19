import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/order_entity.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderEntity? order = Get.arguments as OrderEntity?;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(title: 'Order Confirmed'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Spacer(),
              // Checkmark Card (Image 4 representation)
              Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFF232D37),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.primarytext,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(IconPath.checkcircle, height: 50.h),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Delivery Confirmed!',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.xxl,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Thanks For your Confirmation...',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: AppTextStyle.md,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Bottom Actions
              Row(
                children: [
                  Expanded(
                    child: ProElevatedButton(
                      text: 'Back',
                      backgroundColor: const Color(0xFFCCA13E), // Gold
                      textColor: AppColors.white,
                      borderRadius: 16,
                      onPressed: () {
                        // Go back to Order Detail or Orders List
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ProElevatedButton(
                      text: 'Add Review',
                      backgroundColor: const Color(0xFFA13C33), // Red
                      textColor: AppColors.white,
                      borderRadius: 16,
                      onPressed: () {
                        Get.offNamed('/orderReview', arguments: order);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
