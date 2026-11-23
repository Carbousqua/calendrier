import 'package:flutter/material.dart';

class AppColors {
  // Midnight Deep & Royal Blue Palette
  static const bgDark = Color(0xFF04060E);
  static const bgMid = Color(0xFF080D19);
  static const bgLight = Color(0xFF0E1629);

  static const royalBlue = Color(0xFF1E3A8A);
  static const royalBlueLight = Color(0xFF2563EB);
  static const royalBlueGlow = Color(0x403B82F6);

  // Refined Champagne Gold Palette
  static const gold = Color(0xFFE5C158);
  static const goldLight = Color(0xFFF7E7B6);
  static const goldDeep = Color(0xFFB88E24);
  static const goldShine = Color(0xFFFFF6DC);

  // Glassmorphism & Surfaces
  static const surface = Color(0xFF0F1524);
  static const surfaceAlt = Color(0xFF162035);
  static const glassSurface = Color(0x1F162035);
  static const glassSurfaceActive = Color(0x401E3A8A);
  static const glassBorder = Color(0x33E5C158);
  static const glassBorderActive = Color(0x99E5C158);

  // Typography
  static const offWhite = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFF94A3B8);
  static const textMuted = Color(0xFF64748B);

  // Luxury Gradients
  static const goldGradient = LinearGradient(
    colors: [goldLight, gold, goldDeep],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const goldShineGradient = LinearGradient(
    colors: [goldShine, goldLight, gold, goldDeep],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const royalGradient = LinearGradient(
    colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const backdropGradient = RadialGradient(
    colors: [Color(0xFF131D33), Color(0xFF080D18), Color(0xFF04060E)],
    center: Alignment(0, -0.25),
    radius: 1.4,
  );
}
