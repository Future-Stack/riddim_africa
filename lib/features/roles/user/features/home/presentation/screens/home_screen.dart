import 'package:flutter/material.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';
import 'package:riddimafrica/core/common/widgets/home_app_bar.dart';
import 'package:riddimafrica/core/common/widgets/custom_search_bar.dart';
import 'package:riddimafrica/core/common/widgets/product_card.dart';
import '../widgets/category_chips_row.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../controllers/user_home_controller.dart';

class UserHomeScreen extends GetView<UserHomeController> {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primary, // Dark brown background
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Search Bar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomSearchBar(
                readOnly: true,
                onTap: () => Get.toNamed(AppRoute.globalSearch),
              ),
            ),
            const SizedBox(height: 24),
            
            // Category Chips Row
            Obx(() => CategoryChipsRow(
              selectedMainCategory: controller.selectedMainCategory.value,
              selectedSubCategory: controller.selectedSubCategory.value,
              onMainCategorySelected: controller.selectMainCategory,
              onSubCategorySelected: controller.selectSubCategory,
            )),
            const SizedBox(height: 24),
            
            // Products Found Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => Text(
                '${controller.productsList.length} products found',
                style: AppTextStyle(context).mediumTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 16,
                ),
              )),
            ),
            const SizedBox(height: 16),
            
            // Grid of Products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.productsList.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.65, // Adjust for card height
                ),
                itemCount: controller.productsList.length,
                itemBuilder: (context, index) {
                  final product = controller.productsList[index];
                  return ProductCard(
                    imageUrl: product.imageUrl,
                    title: product.title,
                    subtitle: product.subtitle,
                    rating: product.rating,
                    categoryText: product.categoryText,
                    price: product.price,
                    isHot: product.isHot,
                    onTap: () {
                      Get.toNamed('/marketProductDetail', arguments: product.id);
                    },
                  );
                },
              );
              }),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
