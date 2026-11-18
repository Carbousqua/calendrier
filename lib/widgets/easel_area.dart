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
          return Center(child: PageFrame(w: w, h: h, rotated: true, pageController: pageController, onPageChanged: onPageChanged));
        }

        final maxWidth = constraints.maxWidth * (compact ? 0.96 : 0.90);
        final maxHeight = (constraints.maxHeight - (compact ? 64 : 80)) / 0.68;
        final w = math.max(220.0, math.min(math.min(maxWidth, maxHeight), 780.0));
        final h = w * 0.68;

        if (compact) {
          return Center(
            child: ValueListenableBuilder<Offset>(
              valueListenable: tilt,
              builder: (_, t, _) => _EaselWithParallax(w: w, h: h, tilt: t, pageController: pageController, onPageChanged: onPageChanged),
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
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  builder: (_, animated, _) =>
                      _EaselWithParallax(w: w, h: h, tilt: animated, pageController: pageController, onPageChanged: onPageChanged),
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

    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.00085)
      ..rotateX(-0.07 - dy * 0.11)
      ..rotateY(dx * 0.14);

    return Transform(
      alignment: Alignment.center,
      transform: matrix,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: Offset(dx * 20, dy * 18),
            child: SizedBox(
              width: w * 0.90,
              height: 24,
              child: SpiralRings(ringsCount: w < 340 ? 12 : 16),
            ),
          ),
          Transform.translate(
            offset: Offset(dx * 12, dy * 14),
            child: PageFrame(
              w: w,
              h: h,
              rotated: false,
              pageController: pageController,
              onPageChanged: onPageChanged,
            ),
          ),
          Transform.translate(
            offset: Offset(dx * 5, dy * 7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomPaint(
                  size: Size(w * 0.94, 20),
                  painter: EaselFootPainter(),
                ),
                Container(
                  width: w * 0.82,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.55 + dy.abs() * 0.25),
                        blurRadius: 18 + dy.abs() * 14,
                        spreadRadius: 2,
                        offset: Offset(-dx * 10, 4 + dy * 6),
                      ),
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.06 + dx.abs() * 0.08),
                        blurRadius: 22,
                        offset: Offset(dx * 4, 2),
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
