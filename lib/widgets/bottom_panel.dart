import 'package:flutter/material.dart';
import '../models/month_data.dart';
import 'controls.dart';
import 'hint.dart';
import 'month_selector.dart';

class BottomPanel extends StatelessWidget {
  final bool compact;
  final bool rotated;
  final MonthData currentMonth;
  final int currentIndex;
  final bool isPlaying;
  final bool showHint;
  final ScrollController chipsController;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToggleAutoPlay;
  final ValueChanged<int> onGoTo;

  const BottomPanel({
    super.key,
    required this.compact,
    required this.rotated,
    required this.currentMonth,
    required this.currentIndex,
    required this.isPlaying,
    required this.showHint,
    required this.chipsController,
    required this.onPrevious,
    required this.onNext,
    required this.onToggleAutoPlay,
    required this.onGoTo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MonthTitle(currentMonth: currentMonth, currentIndex: currentIndex),
        SizedBox(height: compact ? 12 : 10),
        Controls(
          compact: compact,
          isPlaying: isPlaying,
          onPrevious: onPrevious,
          onNext: onNext,
          onToggleAutoPlay: onToggleAutoPlay,
        ),
        SizedBox(height: compact ? 12 : 10),
        MonthSelector(
          compact: compact,
          currentIndex: currentIndex,
          chipsController: chipsController,
          onGoTo: onGoTo,
        ),
        if (compact) Hint(rotated: rotated, show: showHint) else const SizedBox(height: 10),
      ],
    );
  }
}
