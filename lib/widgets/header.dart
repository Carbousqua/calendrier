import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Header extends StatelessWidget {
  final bool compact;
  final bool canRotate;
  final bool rotated;
  final bool useGyro;
  final VoidCallback onToggleGyro;
  final VoidCallback onToggleRotated;

  const Header({
    super.key,
    required this.compact,
    required this.canRotate,
    required this.rotated,
    required this.useGyro,
    required this.onToggleGyro,
    required this.onToggleRotated,
  });

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.goldLight, AppColors.goldDeep],
        ),
      ),
      child: const Icon(Icons.calendar_month, size: 18, color: Colors.black87),
    );

    if (compact) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
        child: Row(
          children: [
            Tooltip(
              message: useGyro ? 'Désactiver gyroscope' : 'Activer gyroscope',
              child: IconButton(
                onPressed: onToggleGyro,
                style: IconButton.styleFrom(
                  backgroundColor: useGyro
                      ? AppColors.gold.withValues(alpha: 0.25)
                      : AppColors.surface,
                  fixedSize: const Size(44, 44),
                  side: BorderSide(color: AppColors.gold.withValues(alpha: 0.45)),
                ),
                icon: Icon(
                  useGyro
                      ? Icons.screen_rotation_rounded
                      : Icons.screen_lock_rotation_rounded,
                  size: 22,
                  color: AppColors.goldLight,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                  const SizedBox(width: 10),
                  const Flexible(
                    child: Text(
                      'DILI PRESTIGE',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: AppColors.goldLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (canRotate)
              Tooltip(
                message: rotated ? 'Vue normale' : 'Agrandir (pivoter)',
                child: IconButton(
                  onPressed: onToggleRotated,
                  style: IconButton.styleFrom(
                    backgroundColor: rotated ? AppColors.gold : AppColors.surface,
                    fixedSize: const Size(44, 44),
                    side: BorderSide(color: AppColors.gold.withValues(alpha: 0.45)),
                  ),
                  icon: Icon(
                    rotated
                        ? Icons.fullscreen_exit_rounded
                        : Icons.screen_rotation_alt_rounded,
                    size: 22,
                    color: rotated ? Colors.black87 : AppColors.goldLight,
                  ),
                ),
              )
            else
              const SizedBox(width: 48),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 6,
        children: [
          logo,
          const Text(
            'DILI PRESTIGE',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.2,
              color: AppColors.goldLight,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
            ),
            child: const Text(
              'CALENDRIER DE BUREAU',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w700,
                color: AppColors.goldLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
