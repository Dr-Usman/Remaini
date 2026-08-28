import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/countdown_calculator.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../../data/models/countdown_event.dart';
import '../../../data/models/event_category.dart';
import '../../../data/models/time_remaining.dart';
import '../common/glass_container.dart';
import '../common/urgency_badge.dart';

/// Modern event card with urgency accents, live calculation, and swipe gestures.
class EventCard extends StatelessWidget {
  final CountdownEvent event;
  final VoidCallback onTap;
  final Future<bool?> Function() onConfirmDelete;
  final VoidCallback onDelete;
  final VoidCallback onTogglePin;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.onConfirmDelete,
    required this.onDelete,
    required this.onTogglePin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timeRemaining = CountdownCalculator.calculate(event);
    final urgencyColor = timeRemaining.urgency.color;
    final category = EventCategory.findByName(event.category);
    final customColor = Color(event.colorHex);

    return Dismissible(
      key: Key(event.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Delete with confirmation dialog
          final confirmed = await onConfirmDelete();
          if (confirmed == true) {
            onDelete();
            return true;
          }
          return false;
        } else if (direction == DismissDirection.startToEnd) {
          // Pin / Unpin
          AppHaptics.light();
          onTogglePin();
          return false;
        }
        return false;
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        child: Row(
          children: [
            Icon(
              event.isPinned
                  ? CupertinoIcons.pin_slash_fill
                  : CupertinoIcons.pin_fill,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              event.isPinned ? 'Unpin' : 'Pin',
              style: AppTypography.titleSmall(context, color: Colors.white),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.urgencyNear.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Delete',
              style: AppTypography.titleSmall(context, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Icon(
              CupertinoIcons.trash_fill,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
      child: GlassContainer(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        borderRadius: 20,
        glowColor: timeRemaining.urgency == UrgencyLevel.today || event.isPinned
            ? urgencyColor.withValues(alpha: 0.15)
            : null,
        glowRadius: 10,
        onTap: () {
          AppHaptics.light();
          onTap();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Category & Pin & Urgency
            Row(
              children: [
                // Category Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: customColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: customColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(category.icon, size: 13, color: customColor),
                      const SizedBox(width: 5),
                      Text(
                        event.category,
                        style: AppTypography.bodySmall(
                          context,
                          color: customColor,
                        ).copyWith(fontWeight: FontWeight.w700, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (event.isPinned) ...[
                  const Icon(
                    CupertinoIcons.pin_fill,
                    size: 14,
                    color: AppColors.primaryLight,
                  ),
                  const SizedBox(width: 8),
                ],
                UrgencyBadge(urgency: timeRemaining.urgency),
              ],
            ),
            const SizedBox(height: 14),

            // Event Title
            Text(
              event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.titleLarge(
                context,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ).copyWith(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),

            // Target Date Subtitle
            Row(
              children: [
                Icon(
                  CupertinoIcons.calendar,
                  size: 14,
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    AppDateFormatter.formatFriendlyTarget(event.targetDateTime),
                    style: AppTypography.bodyMedium(
                      context,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Bottom Progress & Countdown Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withValues(alpha: 0.7)
                    : AppColors.lightSurfaceElevated.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark
                      ? AppColors.darkBorderLight
                      : AppColors.lightBorderLight,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Circular Mini Progress
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      value: timeRemaining.isPast
                          ? 1.0
                          : timeRemaining.progress,
                      strokeWidth: 3,
                      backgroundColor: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.black.withValues(alpha: 0.06),
                      valueColor: AlwaysStoppedAnimation<Color>(urgencyColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Formatted Countdown
                  Expanded(
                    child: Text(
                      timeRemaining.shortFormattedString,
                      style:
                          AppTypography.titleMedium(
                            context,
                            color: urgencyColor,
                          ).copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 16,
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
