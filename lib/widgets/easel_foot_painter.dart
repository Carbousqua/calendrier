import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EaselFootPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF262A36), Color(0xFF151720), Color(0xFF0D0F14)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..moveTo(size.width * 0.04, 0)
      ..lineTo(size.width * 0.96, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    final edgePaint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.5)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.04, 0),
      Offset(size.width * 0.96, 0),
      edgePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
