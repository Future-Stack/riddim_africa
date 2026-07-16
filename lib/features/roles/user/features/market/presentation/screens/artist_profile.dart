import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/widgets/product_card.dart';
import '../controllers/artist_profile_controller.dart';

class ArtistProfileScreen extends GetView<ArtistProfileController> {
  const ArtistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Dark brown background
      body: Obx(() {
        final products = controller.productsList;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Banner Stack
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: AppColors.primaryappbrown,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Image.asset(
                          ImagePath.logo,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Floating Back Button
                  Positioned(
                    top: 40,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 2. Artist Details Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar with Gold/Yellow Border
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.onboardingbutton,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primaryappbrown,
                            backgroundImage:
                                controller.avatarUrl.value.isNotEmpty
                                ? NetworkImage(controller.avatarUrl.value)
                                : null,
                            child: controller.avatarUrl.value.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    color: AppColors.primarytext,
                                    size: 30,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Info column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    controller.name.value,
                                    style: AppTextStyle(context).boldTextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  if (controller.isVerified.value) ...[
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.verified,
                                      color: AppColors.bordercolor,
                                      size: 16,
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.name.value == 'Bobi Wine'
                                    ? 'Afropop / Reggae  •  Kampala, Uganda'
                                    : 'Musical Artist  •  Uganda',
                                style: AppTextStyle(context).regularTextStyle(
                                  color: AppColors.primarytext,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Stats wrapped in a Wrap to support all screen widths
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  _buildStatItem(
                                    context,
                                    Icons.people_outline,
                                    '2.4M',
                                    'Followers',
                                  ),
                                  _buildStatItem(
                                    context,
                                    Icons.shopping_bag_outlined,
                                    '${products.length}',
                                    'Products',
                                  ),
                                  _buildStatItem(
                                    context,
                                    Icons.star_border,
                                    '${controller.rating.value}',
                                    'Rating',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // 3. Tab bar selectors
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.primaryappbrown,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(child: _buildTabButton(context, 0, 'Merchandise')),
                    Expanded(child: _buildTabButton(context, 1, 'About')),
                  ],
                ),
              ),

              // 4. Tab View Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: controller.selectedTab.value == 0
                    ? _buildMerchandiseView()
                    : _buildAboutView(context),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.onboardingbutton, size: 14),
        const SizedBox(width: 3),
        Text(
          value,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 11),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: AppTextStyle(
            context,
          ).regularTextStyle(color: AppColors.primarytext, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildTabButton(BuildContext context, int index, String title) {
    final isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.selectTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.secondary : AppColors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle(context).semiBoldTextStyle(
              color: isSelected ? AppColors.secondary : AppColors.primarytext,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMerchandiseView() {
    if (controller.isLoading.value) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: CircularProgressIndicator(color: AppColors.onboardingbutton),
        ),
      );
    }

    final products = controller.productsList;
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            'No merchandise available',
            style: TextStyle(color: AppColors.primarytext),
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68, // slightly adjusted for layout fit
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          imageUrl: product.imageUrl,
          title: product.title,
          subtitle: '', // empty hides subtitle
          rating: product.rating,
          categoryText: '', // empty hides category text
          price: product.price,
          onTap: () {
            // Navigate to product details
            Get.toNamed('/marketProductDetail', arguments: product.id);
          },
        );
      },
    );
  }

  Widget _buildAboutView(BuildContext context) {
    final name = controller.name.value;
    final bio = name == 'Bobi Wine'
        ? "Bobi Wine (Robert Kyagulanyi Ssentamu) is a celebrated Ugandan musician, activist, and politician. Known worldwide as the 'Ghetto President,' his reggae, dancehall, and afrobeat tunes contain socially conscious lyrics advocating for the youth, democratic reform, and societal progress. Over his career, he has produced major chart-topping hits that resonate with millions of listeners across the continent."
        : "$name is a prominent Ugandan musical artist. Combining elements of traditional rhythms with modern beats, they produce tracks celebrating cultural heritage and daily life. Their work represents the rising wave of talented creators sharing authentic African narratives through art.";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Biography',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        const SizedBox(height: 12),
        Text(
          bio,
          style: AppTextStyle(context).regularTextStyle(
            color: AppColors.primarytext,
            fontSize: 14,
            lineHeight: 22,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Artist Information',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        const SizedBox(height: 12),
        _buildInfoRow(context, 'Location', 'Kampala, Uganda'),
        const Divider(color: AppColors.primaryappbrown),
        _buildInfoRow(context, 'Genres', 'Afropop / Reggae / Dancehall'),
        const Divider(color: AppColors.primaryappbrown),
        _buildInfoRow(context, 'Active Since', '2000'),
        const Divider(color: AppColors.primaryappbrown),
        _buildInfoRow(context, 'Verified Studio', 'Fire Base Crew'),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: AppTextStyle(
              context,
            ).mediumTextStyle(color: AppColors.primarytext, fontSize: 14),
          ),
          Text(
            value,
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
