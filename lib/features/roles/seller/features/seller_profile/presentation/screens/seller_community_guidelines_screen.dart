import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class SellerCommunityGuidelinesScreen extends StatelessWidget {
  const SellerCommunityGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': '1. Our community',
        'content':
            'Riddim Africa is a home for African music, artists, creators and fans. These Guidelines apply to everyone on the platform — Users, Artists and Sellers — and form part of our Terms of Service. Our goal is a space that is authentic, respectful and safe.',
      },
      {
        'title': '2. Respect others',
        'content':
            'Treat others with respect. The following are not allowed: • Hate speech, discrimination or harassment based on race, ethnicity, religion, gender, sexual orientation, disability or other protected characteristics. • Bullying, threats, intimidation, or incitement of violence. • Sharing others\' private information without consent.',
      },
      {
        'title': '3. Keep it lawful and safe',
        'content':
            'Do not post or sell anything illegal, dangerous or harmful, including: • Illegal goods, counterfeit products, or items you do not have the right to sell. • Fraud, scams, or attempts to deceive buyers or other users. • Content that promotes violence, self-harm, or illegal activity.',
      },
      {
        'title': '4. Protecting minors',
        'content':
            'We have zero tolerance for any content or behavior that sexualizes, endangers or exploits children. Such content will be removed, the account terminated, and the matter reported to the appropriate authorities. The platform is intended for adults (18+).',
      },
      {
        'title': '5. Authenticity',
        'content':
            'Riddim Africa is built on trust. List real products with honest descriptions and genuine images. Do not misrepresent items, impersonate artists, or sell counterfeit goods. Artists must only submit original work they have the right to distribute.',
      },
      {
        'title': '6. Respect intellectual property',
        'content':
            'Do not upload, sell or distribute music, images or merchandise that infringe someone else\'s copyright, trademark or likeness. Only submit content you own or are licensed to use.',
      },
      {
        'title': '7. No spam or manipulation',
        'content':
            'Do not spam, post misleading links, manipulate ratings or reviews, or use the platform to drive transactions off-platform to avoid its protections.',
      },
      {
        'title': '8. Reporting and enforcement',
        'content':
            'You can report content or behavior that breaks these Guidelines (via in-app reporting). Depending on severity, we may warn you, remove content, restrict features, or suspend or terminate accounts. Serious or illegal violations may be reported to authorities.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Community Guidelines',
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
