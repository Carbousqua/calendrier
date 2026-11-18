import 'package:flutter/material.dart';
import '../models/month_data.dart';
import 'controls.dart';

class SlimBar extends StatelessWidget {
  final MonthData currentMonth;
  final int currentIndex;
  final bool isPlaying;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToggleAutoPlay;

  const SlimBar({
    super.key,
    required this.currentMonth,
    required this.currentIndex,
    required this.isPlaying,
    required this.onPrevious,
    required this.onNext,
    required this.onToggleAutoPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: Row(
        children: [
          CircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            tooltip: 'Mois précédent',
            onTap: onPrevious,
            size: 44,
          ),
          Expanded(
            child: Center(
              child: MonthTitle(
                currentMonth: currentMonth,
                currentIndex: currentIndex,
              ),
            ),
          ),
          CircleButton(
            icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            tooltip: isPlaying ? 'Arrêter' : 'Défilement auto',
            onTap: onToggleAutoPlay,
            size: 44,
            filled: isPlaying,
          ),
          const SizedBox(width: 10),
          CircleButton(
            icon: Icons.arrow_forward_ios_rounded,
            tooltip: 'Mois suivant',
            onTap: onNext,
            size: 44,
          ),
        ],
      ),
    );
  }
}
