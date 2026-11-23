import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import '../models/month_data.dart';
import '../theme/app_colors.dart';

class PageFrame extends StatelessWidget {
  final double w;
  final double h;
  final bool rotated;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const PageFrame({
    super.key,
    required this.w,
    required this.h,
    required this.rotated,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: rotated ? 1 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: w,
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            // Deep Ambient Midnight Shadow
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.75),
              blurRadius: 28,
              spreadRadius: 3,
              offset: const Offset(0, 14),
            ),
            // Champagne Gold Stage Glow
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.16),
              blurRadius: 24,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(2.0), // 2.5D Gold Bevel Border
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: AppColors.goldGradient,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: Color(0xFFFAFAFA)),
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad,
                      PointerDeviceKind.stylus,
                    },
                  ),
                  child: PageView.builder(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    allowImplicitScrolling: true,
                    itemCount: calendarMonths.length,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      final month = calendarMonths[index];
                      return Semantics(
                        label: 'Mois de ${month.name}',
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Image(
                            image: getMonthImage(month),
                            fit: BoxFit.contain,
                            gaplessPlayback: true,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.surfaceAlt,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.broken_image,
                                      size: 42, color: AppColors.goldDeep),
                                  const SizedBox(height: 8),
                                  Text(
                                    month.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'serif',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Inner Subtle Bevel Shadow Layer
                IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.08),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
