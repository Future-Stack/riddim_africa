import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class SellerPrivacyPolicyScreen extends StatelessWidget {
  const SellerPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': '1. Who we are',
        'content':
            'Riddim Africa Limited ("Riddim Africa", "we", "us", "our"), a company incorporated in Uganda (Registration No. 80034798813841), operates the Riddim Africa platform: a digital music, merchandise and entertainment service. We are the data controller responsible for your personal data under the Data Protection and Privacy Act, 2019 of Uganda. Contact: admin@riddimafrica.com. We are registered with the Personal Data Protection Office (PDPO) of Uganda as a data controller.',
      },
      {
        'title': '2. The data we collect',
        'content':
            'We collect the following categories of personal data: • Account data — your name, username, email address, phone number. • Identity verification (KYC) data — for Artists and Sellers, government identification (e.g. National ID, passport or driving license) and related details, to verify identity and prevent fraud. • Delivery data — your delivery location (map pin / GPS coordinates), landmark description, and contact phone number, captured to enable delivery. • Transaction data — orders, purchases, prices, and records of payments and settlements. • Payment data — Mobile Money numbers and payment confirmations. Card payments are processed by our licensed payment partner; we do not store full card numbers. • Usage and device data — app interactions, device type, and technical log data to operate and improve the service. • Communications — messages you send us (e.g. support requests).',
      },
      {
        'title': '3. How we use your data',
        'content':
            'We use personal data to: create and manage your account; process orders, payments and settlements; arrange and complete delivery; verify identity and prevent fraud; provide customer support; send service communications; operate, secure and improve the platform; and comply with legal obligations. Our legal bases include: your consent, performance of our contract with you, our legitimate interests in operating a safe platform, and compliance with law.',
      },
      {
        'title': '4. How we share your data',
        'content':
            'We share personal data only as needed to run the service: • Payment partners (e.g. MTN Mobile Money, Airtel Money) and our licensed card processor) to process payments and settlements. • Delivery — limited delivery data with our own dispatch/rider operations to fulfill orders. Sellers see a customer\'s name only; they do not receive customer contact details. • Distribution partners — for Artists who opt in, data necessary to distribute their music to digital stores via our distribution partner. • Service providers — hosting, analytics and security vendors who process data on our behalf under confidentiality obligations. • Legal — authorities where required by law or to protect rights and safety. We do not sell your personal data, and we do not allow advertisers to pay to target you within Riddim Africa.',
      },
      {
        'title': '5. Data storage, transfers and retention',
        'content':
            'Data is hosted on secure cloud infrastructure (primary region: AWS af-south-1). Where data is transferred outside Uganda, we take steps to ensure an adequate level of protection consistent with the Data Protection and Privacy Act, 2019. We retain personal data for as long as your account is active and as required to meet legal, accounting, tax and dispute resolution obligations.',
      },
      {
        'title': '6. Security',
        'content':
            'We use technical and organizational measures to protect your data, including encryption in transit (HTTPS/TLS), access controls, authentication, and monitoring. No system is perfectly secure, but we work continually to protect your information.',
      },
      {
        'title': '7. Your rights',
        'content':
            'Subject to Ugandan law, you may request access to, correction of, or deletion of your personal data; object to or restrict certain processing; and withdraw consent. To exercise these rights, contact admin@riddimafrica.com. You also have the right to lodge a complaint with the Personal Data Protection Office (PDPO).',
      },
      {
        'title': '8. Children',
        'content':
            'Riddim Africa is intended for users aged 18 and over (or as permitted with verified guardian consent). We do not knowingly collect data from children. If we learn we have done so, we will delete it. We take child safety seriously and prohibit any content or conduct that exploits or endangers minors.',
      },
      {
        'title': '9. Cookies and tracking',
        'content':
            'Our website and app use cookies and similar technologies as described in our separate Cookie Notice.',
      },
      {
        'title': '10. Changes and contact',
        'content':
            'We may update this policy and will post the updated version with a new effective date. For any privacy question or request, contact: admin@riddimafrica.com.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Privacy Policy',
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
