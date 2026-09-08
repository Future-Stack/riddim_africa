import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/radio_controller.dart';

class RadioPlayerView extends StatelessWidget {
  const RadioPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RadioController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Header Section ──────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NOW PLAYING',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Online Radio',
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(color: AppColors.white, fontSize: 20),
                  ),
                ],
              ),
              // Live status indicator (glowing)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.bordercolor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _PulsatingDot(),
                    SizedBox(width: 4.w),
                    Text(
                      'LIVE',
                      style: AppTextStyle(
                        context,
                      ).boldTextStyle(color: AppColors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Horizontal Divider below header
        const Divider(
          color: AppColors.primaryappbrownsecond,
          height: 1,
          thickness: 1,
        ),
        SizedBox(height: 16.h),

        // Centered Logo
        Image.asset(ImagePath.onlogo2, height: 90.h),
        SizedBox(height: 12.h),

        // ─── Station Details ──────────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.bordercolor, width: 1.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            'LIVE',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 9),
          ),
        ),
        SizedBox(height: 10.h),

        Obx(() {
          final state = controller.radioState.value;
          final title = state?.title ?? 'Wanjohi — Midnight Blues';
          final subtitle = state?.subtitle ?? 'The Late Night Show with DJ Afro';
          final listeners = state?.listenerCount ?? 136;

          return Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.white, fontSize: 20),
              ),
              SizedBox(height: 6.h),
              Text(
                subtitle,
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.mic,
                    color: AppColors.onboardingbutton,
                    size: 14,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '$listeners Listeners',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.onboardingbutton,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primarytext,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
        SizedBox(height: 16.h),

        // ─── Progress Bar (Live Timer) ────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(
            () => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LIVE',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      controller.formatDuration(
                        controller.playDurationSeconds.value,
                      ),
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                // Gradient progress line
                Container(
                  height: 3.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.5.r),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.bordercolor,
                        AppColors.onboardingbutton,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // ─── Playback Controls ────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous, size: 30),
              color: AppColors.white,
              onPressed: () {
                controller.resetPlaybackTimer();
              },
            ),
            SizedBox(width: 24.w),
            // Play/Pause button with neon glow
            Obx(
              () => GestureDetector(
                onTap: controller.togglePlay,
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: AppColors.bordercolor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bordercolor.withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: controller.isPlaying.value ? 5 : 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 32,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 24.w),
            IconButton(
              icon: const Icon(Icons.skip_next, size: 30),
              color: AppColors.white,
              onPressed: () {
                controller.resetPlaybackTimer();
              },
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // ─── Volume Section ───────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(
            () => Row(
              children: [
                IconButton(
                  icon: Icon(
                    controller.isMuted.value || controller.volume.value == 0
                        ? Icons.volume_off
                        : Icons.volume_up,
                    color: AppColors.primarytext,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: controller.toggleMute,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3.h,
                      activeTrackColor: AppColors.onboardingbutton,
                      inactiveTrackColor: AppColors.primaryappbrownsecond,
                      thumbColor: AppColors.onboardingbutton,
                      overlayColor: AppColors.onboardingbutton.withValues(
                        alpha: 0.2,
                      ),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 5.r,
                      ),
                    ),
                    child: Slider(
                      value: controller.volume.value,
                      min: 0.0,
                      max: 1.0,
                      onChanged: controller.updateVolume,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${(controller.volume.value * 100).toInt()}%',
                  style: AppTextStyle(
                    context,
                  ).mediumTextStyle(color: AppColors.primarytext, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

// Pulsating live indicator dot
class _PulsatingDot extends StatefulWidget {
  const _PulsatingDot();

  @override
  State<_PulsatingDot> createState() => _PulsatingDotState();
}

class _PulsatingDotState extends State<_PulsatingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController,
      child: Container(
        width: 8.w,
        height: 8.w,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// Egypt Ankh drawing painter
class AnkhPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE6B650)
      ..style = PaintingStyle.fill;

    // Oval loop at top
    final loopPath = Path()
      ..addOval(Rect.fromLTWH(size.width / 2 - 12, 0, 24, 30));
    canvas.drawPath(loopPath, paint);

    // Inner cutout to make it a loop ring
    final innerPaint = Paint()
      ..color = const Color(0xFF377A7D)
      ..style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTWH(size.width / 2 - 6, 6, 12, 18), innerPaint);

    // Crossbar
    final crossRect = Rect.fromLTWH(size.width / 2 - 20, 30, 40, 6);
    canvas.drawRect(crossRect, paint);

    // Stem
    final stemRect = Rect.fromLTWH(size.width / 2 - 4, 36, 8, 24);
    canvas.drawRect(stemRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
