import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';

class MapRouteCard extends StatelessWidget {
  const MapRouteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF111E29),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          // Map Graphic representation
          Expanded(
            child: Stack(
              children: [
                // Subtle map grid background
                Positioned.fill(
                  child: GridPaper(
                    color: Colors.white.withValues(alpha: 0.02),
                    divisions: 1,
                    subdivisions: 1,
                  ),
                ),
                // Route Line
                Center(
                  child: CustomPaint(
                    size: const Size(double.infinity, 100),
                    painter: DottedLinePainter(),
                  ),
                ),
                // Left Office Pin
                Positioned(
                  left: 32,
                  top: 80,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A2315),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'OFFICE',
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.onboardingtext,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Distance Indicator Badge in Center
                Positioned(
                  left: 140,
                  top: 60,
                  child: Text(
                    '1.9 km',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.onboardingbutton,
                      fontSize: 12,
                    ),
                  ),
                ),
                // Right YOU Pin
                Positioned(
                  right: 32,
                  top: 90,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.onboardingbutton,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'YOU',
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.onboardingbutton,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Dispatch location footer bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF0F1A24),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2E241F),
                  ),
                  child: const Icon(
                    Iconsax.truck,
                    color: AppColors.onboardingtext,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Dispatching from: ',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Roots Yard, Kampala',
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: AppColors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4A750)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 4;
    double startX = 36;
    final double endX = size.width - 36;
    final double y = size.height / 2;

    while (startX < endX) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
