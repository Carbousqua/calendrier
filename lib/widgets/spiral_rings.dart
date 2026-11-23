import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SpiralRings extends StatelessWidget {
  final int ringsCount;
  const SpiralRings({super.key, required this.ringsCount});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _SpiralRingsPainter(ringsCount: ringsCount),
    );
  }
}

class _SpiralRingsPainter extends CustomPainter {
  final int ringsCount;

  _SpiralRingsPainter({required this.ringsCount});

  @override
  void paint(Canvas canvas, Size size) {
    if (ringsCount <= 0) return;

    final spacing = size.width / (ringsCount + 1);
    final ringWidth = size.width < 340 ? 7.0 : 8.5;
    final ringHeight = size.height;

    for (int i = 1; i <= ringsCount; i++) {
      final cx = spacing * i;

      // Ring Drop Shadow onto page
      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);

      final shadowPath = Path()
        ..addRRect(RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(cx + 2.5, ringHeight * 0.5 + 2.0),
            width: ringWidth,
            height: ringHeight * 0.9,
          ),
          const Radius.circular(4),
        ));
      canvas.drawPath(shadowPath, shadowPaint);

      // Insertion Hole Shadow (Top & Bottom)
      final holePaint = Paint()..color = const Color(0xFF0A0D14);
      canvas.drawCircle(Offset(cx, 3), 3.5, holePaint);
      canvas.drawCircle(Offset(cx, ringHeight - 3), 3.5, holePaint);

      // Metallic Champagne Gold Ring Coil
      final ringRect = Rect.fromCenter(
        center: Offset(cx, ringHeight * 0.5),
        width: ringWidth,
        height: ringHeight * 0.95,
      );

      final ringGradient = const LinearGradient(
        colors: [
          AppColors.goldDeep,
          AppColors.goldShine,
          AppColors.goldLight,
          AppColors.gold,
          Color(0xFF6E5211),
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

      final ringPaint = Paint()
        ..shader = ringGradient.createShader(ringRect)
        ..style = PaintingStyle.fill;

      final ringRRect = RRect.fromRectAndRadius(ringRect, const Radius.circular(4));
      canvas.drawRRect(ringRRect, ringPaint);

      // Specular Reflection Line (Highlight)
      final highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.7)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(cx - ringWidth * 0.25, ringRect.top + 3),
        Offset(cx - ringWidth * 0.25, ringRect.bottom - 3),
        highlightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SpiralRingsPainter oldDelegate) =>
      oldDelegate.ringsCount != ringsCount;
}
