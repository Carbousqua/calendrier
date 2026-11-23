import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'easel_foot_painter.dart';
import 'page_frame.dart';
import 'spiral_rings.dart';

class EaselArea extends StatelessWidget {
  final bool compact;
  final bool rotated;
  final ValueNotifier<Offset> tilt;
  final bool mouseActive;
  final void Function(bool active, Offset offset) onMouseHover;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final int currentIndex;

  const EaselArea({
    super.key,
    required this.compact,
    required this.rotated,
    required this.tilt,
    required this.mouseActive,
    required this.onMouseHover,
    required this.pageController,
    required this.onPageChanged,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (rotated) {
          final availW = constraints.maxWidth * 0.97;
          final availH = constraints.maxHeight * 0.99;
          final w = math.max(220.0, math.min(availH, availW / 0.68));
          final h = w * 0.68;
          return Center(
            child: PageFrame(
              w: w,
              h: h,
              rotated: true,
              pageController: pageController,
              onPageChanged: onPageChanged,
            ),
          );
        }

        final maxWidth = constraints.maxWidth * (compact ? 0.96 : 0.88);
        final maxHeight = (constraints.maxHeight - (compact ? 64 : 80)) / 0.68;
        final w = math.max(220.0, math.min(math.min(maxWidth, maxHeight), 780.0));
        final h = w * 0.68;

        if (compact) {
          return Center(
            child: ValueListenableBuilder<Offset>(
              valueListenable: tilt,
              builder: (_, t, _) => _EaselWithParallax(
                w: w,
                h: h,
                tilt: t,
                pageController: pageController,
                onPageChanged: onPageChanged,
              ),
            ),
          );
        }

        return MouseRegion(
          onHover: (e) {
            final nx = (e.localPosition.dx / constraints.maxWidth) * 2 - 1;
            final ny = (e.localPosition.dy / constraints.maxHeight) * 2 - 1;
            onMouseHover(true, Offset(nx.clamp(-1.0, 1.0), ny.clamp(-1.0, 1.0)));
          },
          onExit: (_) => onMouseHover(false, Offset.zero),
          child: Center(
            child: ValueListenableBuilder<Offset>(
              valueListenable: tilt,
              builder: (_, t, _) {
                return TweenAnimationBuilder<Offset>(
                  tween: Tween(end: t),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  builder: (_, animated, _) => _EaselWithParallax(
                    w: w,
                    h: h,
                    tilt: animated,
                    pageController: pageController,
                    onPageChanged: onPageChanged,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _EaselWithParallax extends StatelessWidget {
  final double w;
  final double h;
  final Offset tilt;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const _EaselWithParallax({
    required this.w,
    required this.h,
    required this.tilt,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final dx = tilt.dx;
    final dy = tilt.dy;

    // 2.5D Perspective Transformation Matrix
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.00085)
      ..rotateX(-0.06 - dy * 0.12)
      ..rotateY(dx * 0.15);

    return Transform(
      alignment: Alignment.center,
      transform: matrix,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Metallic Spiral Rings with Parallax Offset
          Transform.translate(
            offset: Offset(dx * 22, dy * 20),
            child: SizedBox(
              width: w * 0.90,
              height: 26,
              child: SpiralRings(ringsCount: w < 340 ? 12 : 16),
            ),
          ),

          // Main Calendar Page Frame with Mid Parallax Offset
          Transform.translate(
            offset: Offset(dx * 14, dy * 15),
            child: PageFrame(
              w: w,
              h: h,
              rotated: false,
              pageController: pageController,
              onPageChanged: onPageChanged,
            ),
          ),

          // 2.5D Easel Stand Base & Layered Metallic Gold Shadows
          Transform.translate(
            offset: Offset(dx * 6, dy * 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomPaint(
                  size: Size(w * 0.94, 22),
                  painter: EaselFootPainter(),
                ),
                Container(
                  width: w * 0.84,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      // Deep Floor Contact Shadow
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6 + dy.abs() * 0.2),
                        blurRadius: 20 + dy.abs() * 12,
                        spreadRadius: 2,
                        offset: Offset(-dx * 12, 5 + dy * 6),
                      ),
                      // Soft Ambient Gold Glow
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.12 + dx.abs() * 0.08),
                        blurRadius: 24,
                        offset: Offset(dx * 4, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
