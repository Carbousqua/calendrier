import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Hint extends StatelessWidget {
  final bool rotated;
  final bool show;

  const Hint({super.key, required this.rotated, required this.show});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.glassBorder.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  rotated ? Icons.swap_vert_rounded : Icons.swap_horiz_rounded,
                  size: 16,
                  color: AppColors.goldLight,
                ),
                const SizedBox(width: 8),
                Text(
                  rotated
                      ? 'Glissez vers le haut ou le bas pour feuilleter'
                      : 'Glissez pour feuilleter · Inclinez l\'appareil',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.offWhite.withValues(alpha: 0.75),
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
