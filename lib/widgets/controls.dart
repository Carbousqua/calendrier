import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/month_data.dart';
import '../theme/app_colors.dart';

class MonthTitle extends StatelessWidget {
  final MonthData currentMonth;
  final int currentIndex;

  const MonthTitle({
    super.key,
    required this.currentMonth,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.event_note_rounded, size: 18, color: AppColors.goldLight),
          const SizedBox(width: 8),
          Text(
            currentMonth.name.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.2,
              color: AppColors.offWhite,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
            ),
            child: Text(
              '${currentIndex + 1} / 12',
              style: const TextStyle(
                fontSize: 11.5,
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

class Controls extends StatelessWidget {
  final bool compact;
  final bool isPlaying;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToggleAutoPlay;

  const Controls({
    super.key,
    required this.compact,
    required this.isPlaying,
    required this.onPrevious,
    required this.onNext,
    required this.onToggleAutoPlay,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            tooltip: 'Mois précédent',
            onTap: onPrevious,
            size: 54,
          ),
          const SizedBox(width: 20),
          CircleButton(
            icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            tooltip: isPlaying ? 'Arrêter' : 'Défilement auto',
            onTap: onToggleAutoPlay,
            size: 64,
            filled: isPlaying,
          ),
          const SizedBox(width: 20),
          CircleButton(
            icon: Icons.arrow_forward_ios_rounded,
            tooltip: 'Mois suivant',
            onTap: onNext,
            size: 54,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NavButton(
          label: 'Précédent',
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onPrevious,
        ),
        const SizedBox(width: 14),
        AutoPlayButton(
          isPlaying: isPlaying,
          onTap: onToggleAutoPlay,
        ),
        const SizedBox(width: 14),
        NavButton(
          label: 'Suivant',
          icon: Icons.arrow_forward_ios_rounded,
          onTap: onNext,
          iconAfter: true,
        ),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final double size;
  final bool filled;

  const CircleButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.size = 52,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: filled ? AppColors.goldGradient : null,
              color: filled ? null : AppColors.surfaceAlt.withValues(alpha: 0.7),
              border: Border.all(
                color: filled ? AppColors.goldLight : AppColors.glassBorder,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: filled
                      ? AppColors.gold.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.3),
                  blurRadius: filled ? 16 : 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: size * 0.44,
              color: filled ? AppColors.bgDark : AppColors.goldLight,
            ),
          ),
        ),
      ),
    );
  }
}

class AutoPlayButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onTap;

  const AutoPlayButton({super.key, required this.isPlaying, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
          decoration: BoxDecoration(
            gradient: isPlaying ? AppColors.goldGradient : null,
            color: isPlaying ? null : AppColors.surfaceAlt.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isPlaying ? AppColors.goldLight : AppColors.glassBorder,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isPlaying
                    ? AppColors.gold.withValues(alpha: 0.35)
                    : Colors.black.withValues(alpha: 0.25),
                blurRadius: isPlaying ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: isPlaying ? AppColors.bgDark : AppColors.goldLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isPlaying ? 'Arrêter' : 'Défilement auto',
                style: TextStyle(
                  color: isPlaying ? AppColors.bgDark : AppColors.offWhite,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool iconAfter;

  const NavButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.iconAfter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.glassBorder, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!iconAfter) ...[
                Icon(icon, size: 14, color: AppColors.goldLight),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.offWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              if (iconAfter) ...[
                const SizedBox(width: 8),
                Icon(icon, size: 14, color: AppColors.goldLight),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
