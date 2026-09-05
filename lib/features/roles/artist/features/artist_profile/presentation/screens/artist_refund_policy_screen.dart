import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class ArtistRefundPolicyScreen extends StatelessWidget {
  const ArtistRefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': '1. Overview',
        'content':
            'This policy explains when and how you can return an item or receive a refund for marketplace purchases on Riddim Africa. It forms part of our Terms of Service. It applies to physical merchandise purchased through the platform.',
      },
      {
        'title': '2. Our delivery and inspection model',
        'content':
            'Orders are dispatched from the nearest Riddim Africa office through our delivery network. Because the seller\'s payment is settled on confirmed delivery, you are encouraged to check your item on delivery. This model is designed to protect buyers and support our verified-authentic guarantee.',
      },
      {
        'title': '3. When you can return an item',
        'content':
            'You may request a return or refund if the item is: • Not as described in the listing; • Damaged, defective or faulty; • The wrong item, size or variant; or • Counterfeit or not genuine. Please report the issue at the time of delivery with supporting photos or details.',
      },
      {
        'title': '4. Items that may not be returnable',
        'content':
            'Certain items may not be eligible for return for hygiene, safety or customization reasons (for example, personalized or made-to-order items), unless they are faulty or not as described.',
      },
      {
        'title': '5. How to request a return or refund',
        'content':
            'Contact us (via the app / support@riddim.africa) with your order number and details of the issue. Our team will review the request and may ask for photos or the return of the item. We aim to resolve requests within 7 business days.',
      },
      {
        'title': '6. Refunds',
        'content':
            'Approved refunds are issued to your original payment method (e.g. the Mobile Money account used). Refund timing depends on the payment provider but we will process approved refunds promptly. Where a return is required, refunds may be completed after the item is received and checked.',
      },
      {
        'title': '7. Authenticity guarantee',
        'content':
            'Riddim Africa inspects and verifies marketplace items before they are dispatched. If you receive an item that is counterfeit or materially not as verified, you are entitled to a full refund under this policy.',
      },
      {
        'title': '8. Artist responsibilities',
        'content':
            'Artists are responsible for the accuracy and quality of their items and must cooperate with the returns process. Repeated issues may lead to enforcement action under our Terms and Community Guidelines.',
      },
      {
        'title': '9. Disputes',
        'content':
            'If you are not satisfied with the outcome, you may escalate the matter to Riddim Africa for further review. This policy does not affect any rights you may have under Ugandan consumer-protection law.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Refund Policy',
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final sec = sections[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sec['title']!,
                    style: AppTextStyle(context).boldTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFD49B53),
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    sec['content']!,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 12.sp,
                      color: AppColors.primarytext,
                      lineHeight: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
