import 'package:flutter/material.dart';
import '../models/month_data.dart';
import '../theme/app_colors.dart';

class MonthSelector extends StatelessWidget {
  final bool compact;
  final int currentIndex;
  final ScrollController chipsController;
  final ValueChanged<int> onGoTo;

  const MonthSelector({
    super.key,
    required this.compact,
    required this.currentIndex,
    required this.chipsController,
    required this.onGoTo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 46 : 40,
      child: ListView.builder(
        controller: chipsController,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemExtent: 66,
        itemCount: calendarMonths.length,
        itemBuilder: (context, i) {
          final isSelected = i == currentIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onGoTo(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(colors: [AppColors.goldLight, AppColors.gold])
                      : null,
                  color: isSelected ? null : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.goldLight
                        : Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Text(
                  calendarMonths[i].shortName,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 0.5,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.black87 : Colors.white70,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
