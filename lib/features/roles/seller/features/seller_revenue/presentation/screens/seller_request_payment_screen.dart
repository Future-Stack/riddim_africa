import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_revenue_model.dart';
import '../controllers/seller_request_payment_controller.dart';

class SellerRequestPaymentScreen extends StatelessWidget {
  final SellerTransactionModel? transaction;

  const SellerRequestPaymentScreen({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SellerRequestPaymentController());

    if (transaction != null) {
      c.orderIdController.text = transaction!.id.replaceAll('#', '').trim();
    }

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
          'Request Payment',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Section title
                    Text(
                      'Send a request to Admin',
                      style: AppTextStyle(context).boldTextStyle(
                        color: const Color(0xFFE6B650),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Order ID Field
                    Text(
                      'Order ID',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2430),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: c.orderIdController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'PRD ID: 5454',
                          hintStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Payment Method Dropdown
                    Text(
                      'Payment Method',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2430),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: c.selectedPaymentMethod.value,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF1B2430),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primarytext,
                              size: 20,
                            ),
                            style: TextStyle(
                              color: c.selectedPaymentMethod.value ==
                                      'Enter Payment Method'
                                  ? Colors.white54
                                  : Colors.white,
                              fontSize: 13,
                            ),
                            items: c.paymentMethods.map((method) {
                              return DropdownMenuItem(
                                value: method,
                                child: Text(method),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                c.selectedPaymentMethod.value = val;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Mobile Money Number
                    Text(
                      'Mobile Money Number',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2430),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: c.phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Enter Mobile Money Number',
                          hintStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Message (Optional)
                    Text(
                      'Message (Optional)',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2430),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: c.messageController,
                        maxLines: 4,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Write your message to admin',
                          hintStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Disclaimer text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.primarytext,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Payments are typically settled within 2-3 business days after successful delivery.',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext.withValues(alpha: 0.7),
                              fontSize: 11,
                              lineHeight: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Send Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => c.submitRequest(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Send',
                    style: AppTextStyle(context).boldTextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
