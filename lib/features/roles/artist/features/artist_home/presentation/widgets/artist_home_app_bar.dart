import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'package:riddimafrica/features/notification/presentation/controllers/notification_controller.dart';

class ArtistHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ArtistHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            // Profile Image
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primarytext, width: 1.5),
                image: const DecorationImage(
                  image: NetworkImage('https://picsum.photos/150'), // Placeholder
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Greeting Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Elishin Nakato',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.onboardingtext,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Notification Bell
            GestureDetector(
              onTap: () => Get.toNamed(AppRoute.notifications),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      IconPath.notification, 
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primarytext,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary, // Assuming error or custom red for badge
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '3', // Mock badge count matching UI
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
