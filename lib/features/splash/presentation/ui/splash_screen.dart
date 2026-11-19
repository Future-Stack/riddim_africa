import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.bordercolor,
          image: DecorationImage(
            image: AssetImage(ImagePath.backgrund),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 40,
              child: Lottie.asset(
                'assets/jsons/Sound On.json',
                width: 40.h,
                height: 40.h,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
