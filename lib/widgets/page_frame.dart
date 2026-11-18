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
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.65),
              blurRadius: 24,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.12),
              blurRadius: 20,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: Colors.white),
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
                      child: Image(
                        image: getMonthImage(month),
                        fit: BoxFit.contain,
                        gaplessPlayback: true,
                        filterQuality: FilterQuality.medium,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceAlt,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.broken_image, size: 42, color: Colors.white38),
                              const SizedBox(height: 8),
                              Text(month.name, style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
