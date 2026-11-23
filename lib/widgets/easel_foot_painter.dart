import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EaselFootPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Deep Midnight Royal Wood / Metallic Easel Shelf Base
    final bodyShader = const LinearGradient(
      colors: [
        Color(0xFF1E2638),
        Color(0xFF121724),
        Color(0xFF0A0D15),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(rect);

    final paint = Paint()..shader = bodyShader;

    final path = Path()
      ..moveTo(size.width * 0.03, 0)
      ..lineTo(size.width * 0.97, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // Bevel Edge Highlight in Champagne Gold
    final goldBevelPaint = Paint()
      ..shader = AppColors.goldGradient.createShader(rect)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.03, 0),
      Offset(size.width * 0.97, 0),
      goldBevelPaint,
    );

    // Bottom Ambient Gold Lip Accent
    final bottomGlowPaint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.3)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height - 0.5),
      Offset(size.width, size.height - 0.5),
      bottomGlowPaint,
    );

    // Metallic Foot Peg Support Pins (Left & Right)
    final pinPaint = Paint()
      ..shader = AppColors.goldShineGradient.createShader(
        Rect.fromLTWH(0, 0, 10, size.height),
      );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.12, -2, 10, size.height + 4),
        const Radius.circular(2),
      ),
      pinPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.88 - 10, -2, 10, size.height + 4),
        const Radius.circular(2),
      ),
      pinPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
