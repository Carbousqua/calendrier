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
    // Royal Blue & Gold Crest Logo with Ambient Aura Glow
    final logo = Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.goldGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.35),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.royalGradient,
        ),
        child: const Icon(
          Icons.calendar_month_rounded,
          size: 18,
          color: AppColors.goldLight,
        ),
      ),
    );

    if (compact) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
        child: Row(
          children: [
            // Gyro Toggle Button
            Tooltip(
              message: useGyro ? 'Désactiver gyroscope' : 'Activer gyroscope',
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onToggleGyro,
                  borderRadius: BorderRadius.circular(14),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: useGyro
                          ? AppColors.gold.withValues(alpha: 0.18)
                          : AppColors.surfaceAlt.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: useGyro
                            ? AppColors.gold
                            : AppColors.glassBorder,
                        width: 1.2,
                      ),
                      boxShadow: useGyro
                          ? [
                              BoxShadow(
                                color: AppColors.gold.withValues(alpha: 0.25),
                                blurRadius: 10,
                              )
                            ]
                          : [],
                    ),
                    child: Icon(
                      useGyro
                          ? Icons.screen_rotation_rounded
                          : Icons.screen_lock_rotation_rounded,
                      size: 20,
                      color: useGyro ? AppColors.goldLight : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                  const SizedBox(width: 10),
                  Flexible(
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.goldShineGradient.createShader(bounds),
                      child: const Text(
                        'DILI PRESTIGE',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (canRotate)
              Tooltip(
                message: rotated ? 'Vue normale' : 'Agrandir (pivoter)',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onToggleRotated,
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: rotated ? AppColors.goldGradient : null,
                        color: rotated ? null : AppColors.surfaceAlt.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: rotated ? AppColors.goldLight : AppColors.glassBorder,
                          width: 1.2,
                        ),
                        boxShadow: rotated
                            ? [
                                BoxShadow(
                                  color: AppColors.gold.withValues(alpha: 0.35),
                                  blurRadius: 12,
                                )
                              ]
                            : [],
                      ),
                      child: Icon(
                        rotated
                            ? Icons.fullscreen_exit_rounded
                            : Icons.screen_rotation_alt_rounded,
                        size: 20,
                        color: rotated ? Colors.black87 : AppColors.goldLight,
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(width: 44),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 8,
        children: [
          logo,
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.goldShineGradient.createShader(bounds),
            child: const Text(
              'DILI PRESTIGE',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 3.2,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.royalBlue.withValues(alpha: 0.4),
                  AppColors.surface.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.glassBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.royalBlue.withValues(alpha: 0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, size: 12, color: AppColors.goldLight),
                SizedBox(width: 6),
                Text(
                  'CALENDRIER DE BUREAU DE LUXE',
                  style: TextStyle(
                    fontSize: 10.5,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w800,
                    color: AppColors.goldLight,
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
