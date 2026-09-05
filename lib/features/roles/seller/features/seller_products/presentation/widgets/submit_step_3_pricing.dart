import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/submit_product_controller.dart';
import 'submit_success_dialog.dart';

class SubmitStep3Pricing extends GetView<SellerSubmitProductController> {
  const SubmitStep3Pricing({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pricing Section
          _buildSectionHeader(context, 'Pricing'),
          const SizedBox(height: 10),
          _buildLabel(context, 'Selling Price *'),
          const SizedBox(height: 6),
          _buildPriceField(context, controller.sellingPriceController),
          const SizedBox(height: 20),

          // Physical vs Digital Pricing details
          Obx(() {
            if (controller.isDigitalProduct) {
              return _buildDigitalPricingOptions(context);
            } else {
              return _buildPhysicalDeliveryOptions(context);
            }
          }),

          const SizedBox(height: 24),

          // SUBMISSION SUMMARY Card
          _buildSubmissionSummaryCard(context),
          const SizedBox(height: 30),

          // Submit for Review Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                SubmitSuccessDialog.show(
                  context,
                  productName: controller.productNameController.text.trim().isEmpty
                      ? 'Ashanti Kente Scarf'
                      : controller.productNameController.text.trim(),
                  onTrackStatus: () => controller.navigateToReviewTracking(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBB483D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: const Color(0xFFBB483D).withValues(alpha: 0.5),
              ),
              child: Text(
                'Submit for Review',
                style: AppTextStyle(context).boldTextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Back Button
          Center(
            child: TextButton(
              onPressed: () => controller.previousStep(),
              child: Text(
                'Back to Step 2',
                style: AppTextStyle(context).mediumTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPhysicalDeliveryOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Delivery'),
        const SizedBox(height: 10),

        // Processing Time
        _buildLabel(context, 'PROCESSING TIME'),
        const SizedBox(height: 6),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedProcessingTime.value,
                dropdownColor: const Color(0xFF2C1A0D),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primarytext),
                style: AppTextStyle(context).mediumTextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                ),
                items: controller.processingTimeOptions.map((opt) {
                  return DropdownMenuItem<String>(
                    value: opt,
                    child: Text(opt),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) controller.selectedProcessingTime.value = val;
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Weight (KG)
        _buildLabel(context, 'WEIGHT (KG)'),
        const SizedBox(height: 6),
        TextField(
          controller: controller.weightController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: 'e.g. 0.5',
            hintStyle: TextStyle(color: AppColors.primarytext.withValues(alpha: 0.5), fontSize: 14),
            filled: true,
            fillColor: AppColors.white.withValues(alpha: 0.04),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitalPricingOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Radio: One-Time Purchase vs Limited Edition
        Obx(
          () => Row(
            children: [
              _buildRadioOption(
                context,
                title: 'One-Time Purchase',
                selected: controller.digitalLicenseType.value == 'One-Time Purchase',
                onTap: () => controller.digitalLicenseType.value = 'One-Time Purchase',
              ),
              const SizedBox(width: 16),
              _buildRadioOption(
                context,
                title: 'Limited Edition',
                selected: controller.digitalLicenseType.value == 'Limited Edition',
                onTap: () => controller.digitalLicenseType.value = 'Limited Edition',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Stock Quantity
        _buildLabel(context, 'Stock Quantity *'),
        const SizedBox(height: 6),
        TextField(
          controller: controller.stockQuantityController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: '01',
            hintStyle: TextStyle(color: AppColors.primarytext.withValues(alpha: 0.5), fontSize: 14),
            filled: true,
            fillColor: AppColors.white.withValues(alpha: 0.04),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Proof of Ownership OR Authenticity declaration based on selection
        Obx(() {
          if (controller.digitalLicenseType.value == 'One-Time Purchase') {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel(context, 'Proof of Ownership'),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file, color: Color(0xFF00B4D8), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Upload your file in JPG / PDF',
                        style: AppTextStyle(context).mediumTextStyle(
                          color: AppColors.primarytext,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel(context, 'Authenticity declaration'),
                const SizedBox(height: 6),
                TextField(
                  controller: controller.authenticityController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Enter your declaration.....',
                    hintStyle: TextStyle(color: AppColors.primarytext.withValues(alpha: 0.5), fontSize: 13),
                    filled: true,
                    fillColor: AppColors.white.withValues(alpha: 0.04),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.secondary),
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ],
    );
  }

  Widget _buildRadioOption(
    BuildContext context, {
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? const Color(0xFF00B4D8) : AppColors.primarytext,
                width: 2,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00B4D8),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTextStyle(context).mediumTextStyle(
              color: selected ? Colors.white : AppColors.primarytext,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SUBMISSION SUMMARY',
            style: AppTextStyle(context).boldTextStyle(
              color: AppColors.white,
              fontSize: 12,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14),

          _buildSummaryRow(
            context,
            'Product',
            controller.productNameController.text.trim().isEmpty
                ? 'Ashanti Kente Scarf'
                : controller.productNameController.text.trim(),
          ),
          const SizedBox(height: 8),

          _buildSummaryRow(context, 'Category', controller.selectedCategory.value),
          const SizedBox(height: 8),

          _buildSummaryRow(
            context,
            'Photos',
            '${(controller.mainPhotoUrl.value.isNotEmpty ? 1 : 0) + controller.additionalPhotos.length} uploaded',
          ),
          const SizedBox(height: 8),

          if (controller.isDigitalProduct) ...[
            _buildSummaryRow(
              context,
              'Price',
              controller.sellingPriceController.text.trim().isEmpty
                  ? 'UGX 6,400'
                  : 'UGX ${controller.sellingPriceController.text.trim()}',
            ),
          ] else ...[
            const Divider(height: 20, color: Color(0x1AFFFFFF)),
            // Variant breakdown
            ...controller.colorVariants.map((v) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Color: ${v.colorName}',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: v.sizes.map((s) {
                        return Text(
                          'Size: ${s.size} | Qty: ${s.quantity} | UGX ${s.price.toStringAsFixed(0)}',
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext,
                            fontSize: 11,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
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
            color: AppColors.primarytext,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: AppTextStyle(context).mediumTextStyle(
            color: AppColors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyle(context).boldTextStyle(
        color: AppColors.white,
        fontSize: 14,
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyle(context).boldTextStyle(
        color: AppColors.primarytext,
        fontSize: 11,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildPriceField(BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixText: 'UGX  ',
        prefixStyle: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 14),
        hintText: '12,500',
        hintStyle: TextStyle(color: AppColors.primarytext.withValues(alpha: 0.5), fontSize: 14),
        filled: true,
        fillColor: AppColors.white.withValues(alpha: 0.04),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }
}
