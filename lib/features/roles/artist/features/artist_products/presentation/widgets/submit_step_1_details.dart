import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/product_variant_model.dart';
import '../controllers/submit_product_controller.dart';
import 'add_size_modal.dart';
import 'add_color_modal.dart';

class SubmitStep1Details extends GetView<ArtistSubmitProductController> {
  const SubmitStep1Details({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          _buildLabel(context, 'PRODUCT NAME *'),
          const SizedBox(height: 6),
          _buildTextField(
            context,
            controller: controller.productNameController,
            hintText: 'e.g. Tour Edition Cap or Aesthetic Bird Image',
          ),
          const SizedBox(height: 16),

          // Category Dropdown
          _buildLabel(context, 'CATEGORY *'),
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
                  value: controller.selectedCategory.value,
                  dropdownColor: const Color(0xFF2C1A0D),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primarytext),
                  style: AppTextStyle(context).mediumTextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                  items: controller.categories.map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat,
                      child: Text(cat),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.setCategory(val);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Conditional Digital vs Physical Fields
          Obx(() {
            if (controller.isDigitalProduct) {
              return _buildDigitalFields(context);
            } else {
              return _buildPhysicalFields(context);
            }
          }),

          const SizedBox(height: 24),

          // Next Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => controller.nextStep(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F2C57),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Next',
                    style: AppTextStyle(context).boldTextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDigitalFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dimension
        _buildLabel(context, 'DIMENSION *'),
        const SizedBox(height: 6),
        _buildTextField(
          context,
          controller: controller.dimensionController,
          hintText: 'e.g. 772 Px or 3840 x 2160',
        ),
        const SizedBox(height: 16),

        // Short Description
        _buildLabel(context, 'SHORT DESCRIPTION *'),
        const SizedBox(height: 6),
        _buildTextField(
          context,
          controller: controller.shortDescriptionController,
          hintText: 'Enter short description of the digital asset...',
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildPhysicalFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Short Description
        _buildLabel(context, 'SHORT DESCRIPTION *'),
        const SizedBox(height: 6),
        _buildTextField(
          context,
          controller: controller.shortDescriptionController,
          hintText: 'Handwoven Ashanti Kente scarf in vibrant gold and green patterns...',
          maxLines: 4,
        ),
        const SizedBox(height: 16),

        // Material & Origin / Made In (Side-by-side)
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(context, 'MATERIAL'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    context,
                    controller: controller.materialController,
                    hintText: 'e.g. 100% Silk',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(context, 'ORIGIN / MADE IN'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    context,
                    controller: controller.originController,
                    hintText: 'e.g. Kumasi, Ghana',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Colour Variants Matrix Table
        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controller.colorVariants.asMap().entries.map((entry) {
                final int colorIndex = entry.key;
                final variant = entry.value;

                return _buildColorVariantBlock(context, colorIndex, variant);
              }),
              const SizedBox(height: 12),

              // + Add Color Variant Button
              Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    AddColorModal.show(
                      context,
                      onAdd: (newVariant) => controller.addColorVariant(newVariant),
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline, size: 16, color: Color(0xFFFF7043)),
                  label: Text(
                    'Add color variant',
                    style: AppTextStyle(context).boldTextStyle(
                      color: const Color(0xFFFF7043),
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6F2C57)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildColorVariantBlock(
    BuildContext context,
    int colorIndex,
    ColorVariantModel variant,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        children: [
          // Header Row: COLOUR [Badge] + Add Size Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'COLOUR  ',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            variant.colorName,
                            style: const TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    AddSizeModal.show(
                      context,
                      colorName: variant.colorName,
                      onAdd: (newSize) => controller.addSizeToVariant(colorIndex, newSize),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB300).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFFFB300).withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, size: 12, color: Color(0xFFFFB300)),
                        const SizedBox(width: 4),
                        Text(
                          'Add Size',
                          style: AppTextStyle(context).boldTextStyle(
                            color: const Color(0xFFFFB300),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0x1AFFFFFF)),

          // Table Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildTableHeader(context, 'SIZE')),
                Expanded(flex: 2, child: _buildTableHeader(context, 'QUANTITY')),
                Expanded(flex: 2, child: _buildTableHeader(context, 'PRICE')),
                Expanded(flex: 1, child: _buildTableHeader(context, 'ACTION', align: TextAlign.right)),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0x1AFFFFFF)),

          // Size items rows
          ...variant.sizes.asMap().entries.map<Widget>((entry) {
            final sizeItem = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      sizeItem.size,
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${sizeItem.quantity}',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'UGX ${sizeItem.price.toStringAsFixed(0)}',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => controller.removeSizeFromVariant(colorIndex, entry.key),
                        child: const Icon(Icons.delete_outline, size: 16, color: AppColors.primarytext),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context, String title, {TextAlign align = TextAlign.left}) {
    return Text(
      title,
      textAlign: align,
      style: AppTextStyle(context).boldTextStyle(
        color: AppColors.primarytext.withValues(alpha: 0.7),
        fontSize: 10,
        letterSpacing: 0.8,
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

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.primarytext.withValues(alpha: 0.5),
          fontSize: 13,
        ),
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
