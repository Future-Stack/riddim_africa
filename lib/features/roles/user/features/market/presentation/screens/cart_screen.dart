import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary_section.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(title: 'My Cart', showBackButton: false),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CartListShimmer(count: 3);
        }

        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.shopping_cart,
                  size: 64,
                  color: AppColors.primarytext,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your cart is empty',
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: AppColors.white, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore items and add them to your cart!',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item Count Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  '${controller.totalItems} ${controller.totalItems == 1 ? 'item' : 'items'}',
                  style: AppTextStyle(
                    context,
                  ).mediumTextStyle(color: AppColors.primarytext, fontSize: 16),
                ),
              ),

              // Scrollable List of Cart Items
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  itemCount: controller.cartItems.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];
                    return CartItemCard(
                      imageUrl: item.imageUrl,
                      title: item.title,
                      sellerName: item.sellerName,
                      selectedColor: item.selectedColor,
                      selectedSize: item.selectedSize,
                      price: item.price,
                      quantity: item.quantity,
                      onIncrement: () => controller.incrementQuantity(index),
                      onDecrement: () => controller.decrementQuantity(index),
                      onRemove: () => controller.removeItem(index),
                    );
                  },
                ),
              ),

              // Bottom Section: Summary & Checkout Button
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: AppColors.primaryappbrown,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.primaryappbrownsecond,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cart Summary Row values
                    CartSummarySection(
                      subtotal: controller.subtotalText,
                      shippingFee: controller.shippingFeeText,
                      total: controller.totalText,
                    ),
                    const SizedBox(height: 16),

                    // Proceed to Checkout button
                    ProElevatedButton(
                      onPressed: () => Get.toNamed(AppRoute.marketCheckout),
                      text: "Proceed to Checkout",
                      showGlow: true,
                      backgroundColor: AppColors.secondary,
                      trailingIcon: Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
