import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class ArtistCookieNoticeScreen extends StatelessWidget {
  const ArtistCookieNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': '1. What this covers',
        'content':
            'This notice explains how Riddim Africa uses cookies and similar technologies (such as local storage and software development kits) on our website and app. It should be read together with our Privacy Policy.',
      },
      {
        'title': '2. What cookies and similar technologies are',
        'content':
            'Cookies are small files stored on your device. Similar technologies perform comparable functions. Together they help the service work, remember your preferences, keep you signed in, and help us understand how the platform is used.',
      },
      {
        'title': '3. Types we use',
        'content':
            '• Essential — required for the platform to function (e.g. signing in, security, completing a purchase). These cannot be switched off.\n• Preferences — remember choices such as language or settings.\n• Analytics / performance — help us understand usage and improve the service (e.g. product analytics and error monitoring tools).',
      },
      {
        'title': '4. Third-party tools',
        'content':
            'We use trusted third-party analytics and security tools that may set their own cookies or identifiers to provide their services to us. These providers process data on our behalf.',
      },
      {
        'title': '5. No advertising sale',
        'content':
            'We do not use cookies to sell your data to advertisers or to let advertisers target you within Riddim Africa.',
      },
      {
        'title': '6. Managing your choices',
        'content':
            'You can manage or clear cookies through your browser or device settings, and adjust available in-app preferences. Blocking essential cookies may affect how the platform works. Where required by law, we will ask for your consent to nonessential cookies.',
      },
      {
        'title': '7. Changes and contact',
        'content':
            'We may update this notice and will post the updated version. Questions: admin@riddimafrica.com.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Cookie Notice',
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
