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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.event, size: 16, color: AppColors.goldLight),
          const SizedBox(width: 8),
          Text(
            currentMonth.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${currentIndex + 1} / 12',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.goldLight.withValues(alpha: 0.8),
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
          CircleButton(icon: Icons.arrow_back_ios_new_rounded, tooltip: 'Mois précédent', onTap: onPrevious, size: 54),
          const SizedBox(width: 18),
          CircleButton(
            icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            tooltip: isPlaying ? 'Arrêter' : 'Défilement auto',
            onTap: onToggleAutoPlay,
            size: 64,
            filled: isPlaying,
          ),
          const SizedBox(width: 18),
          CircleButton(icon: Icons.arrow_forward_ios_rounded, tooltip: 'Mois suivant', onTap: onNext, size: 54),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NavButton(label: 'Précédent', icon: Icons.arrow_back_ios_new_rounded, onTap: onPrevious),
        const SizedBox(width: 12),
        AutoPlayButton(isPlaying: isPlaying, onTap: onToggleAutoPlay),
        const SizedBox(width: 12),
        NavButton(label: 'Suivant', icon: Icons.arrow_forward_ios_rounded, onTap: onNext, iconAfter: true),
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
              gradient: filled
                  ? const LinearGradient(colors: [AppColors.goldLight, AppColors.gold])
                  : null,
              color: filled ? null : AppColors.surfaceAlt,
              border: Border.all(
                color: filled ? AppColors.goldLight : Colors.white.withValues(alpha: 0.14),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: filled ? 0.35 : 0.0),
                  blurRadius: 14,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: size * 0.44,
              color: filled ? Colors.black87 : AppColors.goldLight,
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
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: isPlaying
                ? const LinearGradient(colors: [AppColors.goldLight, AppColors.gold])
                : null,
            color: isPlaying ? null : AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.gold.withValues(alpha: isPlaying ? 1.0 : 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: isPlaying ? 0.35 : 0.0),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: isPlaying ? Colors.black87 : AppColors.goldLight,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                isPlaying ? 'Arrêter' : 'Défilement auto',
                style: TextStyle(
                  color: isPlaying ? Colors.black87 : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 0.4,
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
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!iconAfter) ...[
                Icon(icon, size: 14, color: AppColors.goldLight),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              if (iconAfter) ...[
                const SizedBox(width: 6),
                Icon(icon, size: 14, color: AppColors.goldLight),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
