import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/product_variant_model.dart';

class AddColorModal extends StatefulWidget {
  final Function(ColorVariantModel) onAdd;

  const AddColorModal({
    super.key,
    required this.onAdd,
  });

  static Future<void> show(
    BuildContext context, {
    required Function(ColorVariantModel) onAdd,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AddColorModal(onAdd: onAdd),
    );
  }

  @override
  State<AddColorModal> createState() => _AddColorModalState();
}

class _AddColorModalState extends State<AddColorModal> {
  final TextEditingController colorNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String selectedSize = 'XL';
  Color selectedColor = const Color(0xFFBB483D);
  final List<String> availableSizes = ['S', 'M', 'L', 'XL', 'XXL', '3XL', 'Free Size'];

  final List<Map<String, dynamic>> presetColors = [
    {'name': 'Red', 'color': const Color(0xFFE53935)},
    {'name': 'Purple', 'color': const Color(0xFF8E24AA)},
    {'name': 'Gold', 'color': const Color(0xFFFFB300)},
    {'name': 'Green', 'color': const Color(0xFF43A047)},
    {'name': 'Blue', 'color': const Color(0xFF1E88E5)},
    {'name': 'Black', 'color': const Color(0xFF212121)},
  ];

  @override
  void dispose() {
    colorNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2C1A0D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Colour Variant',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Colour Picker Presets
              Text(
                'Select Colour',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: presetColors.map((item) {
                  final bool isSelected = colorNameController.text == item['name'];
                  final Color c = item['color'] as Color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        colorNameController.text = item['name'] as String;
                        selectedColor = c;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? c.withValues(alpha: 0.25)
                            : AppColors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? c : AppColors.white.withValues(alpha: 0.1),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item['name'] as String,
                            style: AppTextStyle(context).mediumTextStyle(
                              color: isSelected ? AppColors.white : AppColors.primarytext,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Custom Colour name input
              TextField(
                controller: colorNameController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Or enter colour name (e.g. Gold, Green)',
                  hintStyle: TextStyle(color: AppColors.primarytext.withValues(alpha: 0.6), fontSize: 13),
                  filled: true,
                  fillColor: AppColors.white.withValues(alpha: 0.05),
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
              const SizedBox(height: 14),

              // Size Dropdown
              Text(
                'Size',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSize,
                    dropdownColor: const Color(0xFF2C1A0D),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primarytext),
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                    items: availableSizes.map((size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedSize = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Quantity
              Text(
                'Quantity',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Enter quantity',
                  hintStyle: TextStyle(color: AppColors.primarytext.withValues(alpha: 0.6), fontSize: 14),
                  filled: true,
                  fillColor: AppColors.white.withValues(alpha: 0.05),
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
              const SizedBox(height: 14),

              // Price
              Text(
                'Price',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  prefixText: 'UGX  ',
                  prefixStyle: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 13),
                  hintText: 'Enter price',
                  hintStyle: TextStyle(color: AppColors.primarytext.withValues(alpha: 0.6), fontSize: 14),
                  filled: true,
                  fillColor: AppColors.white.withValues(alpha: 0.05),
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
              const SizedBox(height: 20),

              // Add Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final colorName = colorNameController.text.trim().isEmpty
                        ? 'Custom Color'
                        : colorNameController.text.trim();
                    final qty = int.tryParse(quantityController.text) ?? 1;
                    final price = double.tryParse(priceController.text) ?? 0.0;

                    widget.onAdd(
                      ColorVariantModel(
                        colorName: colorName,
                        hexColor: '#${selectedColor.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}',
                        sizes: [
                          ProductVariantItem(
                            size: selectedSize,
                            quantity: qty,
                            price: price,
                          ),
                        ],
                      ),
                    );
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Add',
                    style: AppTextStyle(context).boldTextStyle(
                      color: Colors.white,
                      fontSize: 15,
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
}
