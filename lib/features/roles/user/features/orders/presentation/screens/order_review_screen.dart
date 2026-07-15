import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/order_entity.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  int _selectedRating = 4; // Default to 4 stars as shown in Image 5
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrderEntity? order = Get.arguments as OrderEntity?;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryappbrownsecond,
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
        title: order != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ${order.orderNumber}',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(order.orderDate),
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: AppTextStyle.xs,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        centerTitle: false,
      ),
      body: order == null
          ? const Center(child: Text('Order not found'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Summary Card (same as OrderDetailScreen)
                  _buildProductCard(context, order),
                  const SizedBox(height: 20),

                  // Ratings header & stars
                  Text(
                    'Ratings',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRatingStars(),
                  const SizedBox(height: 20),

                  // Add Comments Section
                  Text(
                    'Add Comments',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title Label
                  Text(
                    'Title',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title Text Field
                  TextField(
                    controller: _titleController,
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.md,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Absolutely fire',
                      hintStyle: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext.withValues(alpha: 0.5),
                        fontSize: AppTextStyle.md,
                      ),
                      filled: true,
                      fillColor: AppColors.primaryappbrown,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColors.primaryappbrownsecond,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColors.onboardingbutton,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Label
                  Text(
                    'Description',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description Text Field with stack for Upload Icon
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      TextField(
                        controller: _descriptionController,
                        maxLines: 6,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.white,
                          fontSize: AppTextStyle.md,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Great product, exactly as described. Will buy again!',
                          hintStyle: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext.withValues(alpha: 0.5),
                            fontSize: AppTextStyle.md,
                          ),
                          filled: true,
                          fillColor: AppColors.primaryappbrown,
                          contentPadding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: 48, // Leave room for upload button
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.primaryappbrownsecond,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.onboardingbutton,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primaryappbrownsecond,
                          child: IconButton(
                            icon: const Icon(
                              Iconsax.document_upload,
                              size: 16,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              Get.snackbar(
                                'Upload',
                                'Photo/video upload feature is mock.',
                              );
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Bottom Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ProElevatedButton(
                          text: 'Back',
                          backgroundColor: const Color(0xFFCCA13E), // Gold
                          textColor: AppColors.white,
                          borderRadius: 16,
                          onPressed: () => Get.back(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ProElevatedButton(
                          text: 'Submit',
                          backgroundColor: const Color(0xFFA13C33), // Red
                          textColor: AppColors.white,
                          borderRadius: 16,
                          onPressed: () {
                            Get.snackbar(
                              'Success',
                              'Review submitted successfully. Thank you!',
                            );
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isSelected = starIndex <= _selectedRating;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = starIndex;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              isSelected ? Icons.star : Icons.star_border,
              color: const Color(0xFFCCA13E), // Gold color matching Image 5
              size: 40,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProductCard(BuildContext context, OrderEntity order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryappbrownsecond, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                order.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.primaryappbrownsecond,
                  child: const Icon(
                    Iconsax.image,
                    color: AppColors.primarytext,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.white,
                          fontSize: AppTextStyle.md,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Qty: ${order.quantity}',
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: AppTextStyle.sm,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (order.selectedColor != null ||
                          order.selectedSize != null)
                        Text(
                          'Color: ${order.selectedColor ?? 'N/A'}    Size: ${order.selectedSize ?? 'N/A'}',
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext,
                            fontSize: AppTextStyle.sm,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  order.price,
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: AppTextStyle.md,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
