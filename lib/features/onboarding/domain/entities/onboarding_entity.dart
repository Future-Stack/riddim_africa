import 'package:flutter/material.dart';



class OnboardingEntity {
  final String bgImagePath;
  final String? centerLogoPath;
  final bool showTopRightLogo;
  final bool showDots;
  final String title;
  final String subtitle;
  final List<Widget> buttons;

  const OnboardingEntity({
    required this.bgImagePath,
    this.centerLogoPath,
    this.showTopRightLogo = false,
    this.showDots = true,
    required this.title,
    required this.subtitle,
    required this.buttons,
  });
}
