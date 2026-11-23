import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Backdrop extends StatelessWidget {
  const Backdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base Radial Midnight Backdrop
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.backdropGradient,
          ),
        ),

        // Ambient Gold Glow Orb (Top-Center)
        Positioned(
          top: -100,
          left: MediaQuery.sizeOf(context).width * 0.2,
          right: MediaQuery.sizeOf(context).width * 0.2,
          height: 300,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.gold.withValues(alpha: 0.12),
                    AppColors.royalBlueLight.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  radius: 0.8,
                ),
              ),
            ),
          ),
        ),

        // Subtle Ambient Royal Blue Glow (Bottom)
        Positioned(
          bottom: -150,
          left: 0,
          right: 0,
          height: 350,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.royalBlue.withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                  radius: 0.9,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
