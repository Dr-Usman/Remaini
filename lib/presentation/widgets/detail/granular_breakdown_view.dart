import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/time_remaining.dart';
import '../common/glass_container.dart';

/// Displays total cumulative counts (Total Days, Total Hours, Total Minutes, Total Seconds).
class GranularBreakdownView extends StatelessWidget {
  final TimeRemaining timeRemaining;
  final Color accentColor;

  const GranularBreakdownView({
    super.key,
    required this.timeRemaining,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final numberFormat = NumberFormat('#,###');

    final items = [
      _TotalUnitItem(
        title: 'Total Days',
        value: numberFormat.format(timeRemaining.totalDays),
        icon: CupertinoIcons.calendar,
        color: const Color(0xFF6366F1),
      ),
      _TotalUnitItem(
        title: 'Total Hours',
        value: numberFormat.format(timeRemaining.totalHours),
        icon: CupertinoIcons.clock_fill,
        color: const Color(0xFF06B6D4),
      ),
      _TotalUnitItem(
        title: 'Total Minutes',
        value: numberFormat.format(timeRemaining.totalMinutes),
        icon: CupertinoIcons.stopwatch_fill,
        color: const Color(0xFF10B981),
      ),
      _TotalUnitItem(
        title: 'Total Seconds',
        value: numberFormat.format(timeRemaining.totalSeconds),
        icon: CupertinoIcons.flame_fill,
        color: const Color(0xFFEF4444),
      ),
    ];

    return Column(
      children: items.map((item) {
        return GlassContainer(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          borderRadius: 16,
          backgroundColor: isDark
              ? AppColors.darkCard.withValues(alpha: 0.7)
              : AppColors.lightCard.withValues(alpha: 0.9),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: item.color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(item.icon, size: 18, color: item.color),
              ),
              const SizedBox(width: 14),
              Text(
                item.title,
                style: AppTypography.titleSmall(
                  context,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const Spacer(),
              // Animated ticking number
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  item.value,
                  key: ValueKey<String>(item.value),
                  style: AppTypography.titleLarge(
                    context,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ).copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.3),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _TotalUnitItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  _TotalUnitItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}
