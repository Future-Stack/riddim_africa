import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/settings_controller.dart';
import '../../domain/entities/faq_entity.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'FAQs',
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoadingFaqs.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.onboardingbutton),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon + Header Title row
                Row(
                  children: [
                    const Icon(
                      Iconsax.message_question,
                      color: AppColors.onboardingbutton,
                      size: 22,
                    ),
                    const Gap.h(8),
                    Text(
                      'Frequently Asked Questions',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Gap(20),

                // FAQ items
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.faqs.length,
                  itemBuilder: (context, index) {
                    return FaqAccordionItem(faq: controller.faqs[index]);
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class FaqAccordionItem extends StatefulWidget {
  final FaqEntity faq;
  const FaqAccordionItem({super.key, required this.faq});

  @override
  State<FaqAccordionItem> createState() => _FaqAccordionItemState();
}

class _FaqAccordionItemState extends State<FaqAccordionItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryappbrownsecond.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.faq.question,
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_down : Icons.chevron_right,
                    color: _isExpanded ? AppColors.secondary : AppColors.primarytext,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(
              color: AppColors.primaryappbrownsecond,
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.faq.answer,
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.onboardingtext,
                  fontSize: 14,
                  lineHeight: 22,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
