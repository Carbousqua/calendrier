import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      height: compact ? 48 : 42,
      child: ListView.builder(
        controller: chipsController,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemExtent: 68,
        itemCount: calendarMonths.length,
        itemBuilder: (context, i) {
          final isSelected = i == currentIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.selectionClick();
                onGoTo(i);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.goldGradient : null,
                  color: isSelected ? null : AppColors.surfaceAlt.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.goldLight
                        : AppColors.glassBorder.withValues(alpha: 0.15),
                    width: isSelected ? 1.4 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? AppColors.gold.withValues(alpha: 0.35)
                          : Colors.black.withValues(alpha: 0.15),
                      blurRadius: isSelected ? 10 : 4,
                      offset: Offset(0, isSelected ? 3 : 1),
                    ),
                  ],
                ),
                child: Text(
                  calendarMonths[i].shortName,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 0.8,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                    color: isSelected ? AppColors.bgDark : AppColors.offWhite,
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
