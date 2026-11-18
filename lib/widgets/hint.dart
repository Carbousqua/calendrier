import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Hint extends StatelessWidget {
  final bool rotated;
  final bool show;

  const Hint({super.key, required this.rotated, required this.show});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                rotated ? Icons.swap_vert_rounded : Icons.swap_horiz_rounded,
                size: 18,
                color: AppColors.goldLight.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 6),
              Text(
                rotated
                    ? 'Glissez vers le haut ou le bas pour feuilleter'
                    : 'Glissez pour feuilleter · Inclinez le téléphone',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
