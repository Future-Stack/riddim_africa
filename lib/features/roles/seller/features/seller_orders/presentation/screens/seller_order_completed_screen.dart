import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/controllers/seller_bottom_nav_controller.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../data/models/seller_order_model.dart';

class SellerOrderCompletedScreen extends StatelessWidget {
  final SellerOrderModel order;

  const SellerOrderCompletedScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.appbardivider,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          'Order',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Glowing green checkmark
              Center(
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14301B),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF388E3C).withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      IconPath.badgeCheck,
                      width: 54,
                      height: 54,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Header & Subtitle
              Text(
                'Order Completed!',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: const Color(0xFF4CAF50), fontSize: 22),
              ),
              const SizedBox(height: 8),
              Text(
                'Order #${order.id} has been delivered and confirmed. Your revenue has been released to your balance.',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 13,
                  lineHeight: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Revenue Released Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B261A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF388E3C).withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Revenue Released',
                          style: AppTextStyle(
                            context,
                          ).boldTextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          order.revenueAmount,
                          style: AppTextStyle(context).boldTextStyle(
                            color: const Color(0xFFF5A623),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(height: 1, color: Color(0x1AFFFFFF)),
                    const SizedBox(height: 14),

                    _buildSummaryRow(
                      context,
                      'Payment Method',
                      order.paymentMethod,
                    ),
                    const SizedBox(height: 10),
                    _buildSummaryRow(context, 'Order', '#${order.id}'),
                    const SizedBox(height: 10),
                    _buildSummaryRow(context, 'Product', order.productTitle),
                    const SizedBox(height: 10),
                    _buildSummaryRow(context, 'Buyer', order.customerName),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // View Revenue Button
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if (Get.isRegistered<SellerBottomNavController>()) {
                        Get.back();
                        Get.find<SellerBottomNavController>().changeIndex(3);
                      } else {
                        Get.toNamed(AppRoute.sellerRevenue);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'View Revenue',
                      style: AppTextStyle(
                        context,
                      ).boldTextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle(context).regularTextStyle(
            color: AppColors.primarytext.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
