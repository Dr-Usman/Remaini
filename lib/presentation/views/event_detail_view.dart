import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/event_category.dart';
import '../../../data/models/time_remaining.dart';
import '../controllers/event_detail_controller.dart';
import '../widgets/common/glass_container.dart';
import '../widgets/common/gradient_button.dart';
import '../widgets/common/urgency_badge.dart';
import '../widgets/detail/celebration_overlay.dart';
import '../widgets/detail/circular_countdown_ring.dart';
import '../widgets/detail/granular_breakdown_view.dart';
import '../widgets/detail/time_unit_card.dart';

/// Core Detail Screen showcasing the live 1-second ticking countdown, circular ring, and full time breakdown.
class EventDetailView extends GetView<EventDetailController> {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Dynamic ambient background glow based on urgency
          Obx(() {
            final urgency = controller.timeRemaining.value.urgency;
            final glowColor = urgency.color;

            return Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: glowColor.withValues(alpha: isDark ? 0.12 : 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: glowColor.withValues(alpha: isDark ? 0.22 : 0.12),
                      blurRadius: 100,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            );
          }),

          SafeArea(
            child: Column(
              children: [
                // Top Custom App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(CupertinoIcons.chevron_back),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      // Pin Toggle
                      Obx(() {
                        final isPinned = controller.currentEvent.value.isPinned;
                        return IconButton(
                          icon: Icon(
                            isPinned
                                ? CupertinoIcons.pin_fill
                                : CupertinoIcons.pin,
                            color: isPinned ? AppColors.primaryLight : null,
                          ),
                          onPressed: controller.togglePin,
                        );
                      }),
                      // Share Button
                      IconButton(
                        icon: const Icon(CupertinoIcons.share),
                        onPressed: controller.shareEvent,
                      ),
                      // Edit Button
                      IconButton(
                        icon: const Icon(CupertinoIcons.pencil),
                        onPressed: controller.openEditEvent,
                      ),
                      // Delete Button
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.trash,
                          color: AppColors.urgencyNear,
                        ),
                        onPressed: () => controller.confirmDelete(context),
                      ),
                    ],
                  ),
                ),

                // Main Scrollable Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // Event Title & Category
                      Obx(() {
                        final event = controller.currentEvent.value;
                        final category = EventCategory.findByName(
                          event.category,
                        );
                        final customColor = Color(event.colorHex);
                        final time = controller.timeRemaining.value;

                        return Column(
                          children: [
                            // Category & Urgency Badges
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: customColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: customColor.withValues(
                                        alpha: 0.35,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        category.icon,
                                        size: 13,
                                        color: customColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        event.category,
                                        style:
                                            AppTypography.bodySmall(
                                              context,
                                              color: customColor,
                                            ).copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 11,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                UrgencyBadge(urgency: time.urgency),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Main Title
                            Text(
                              event.title,
                              textAlign: TextAlign.center,
                              style:
                                  AppTypography.titleLarge(
                                    context,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary,
                                  ).copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                            ),
                            const SizedBox(height: 6),

                            // Target Date & Time Formatted
                            Text(
                              AppDateFormatter.formatDateTime(
                                event.targetDateTime,
                              ),
                              style: AppTypography.bodyMedium(
                                context,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 24),

                      // Centered Circular Countdown Ring (Dynamic 1s updates)
                      Center(
                        child: Obx(() {
                          final time = controller.timeRemaining.value;
                          final event = controller.currentEvent.value;
                          final accentColor = Color(event.colorHex);

                          return CircularCountdownRing(
                            timeRemaining: time,
                            accentColor: accentColor,
                            size: 240,
                          );
                        }),
                      ),
                      const SizedBox(height: 28),

                      // View Mode Toggle (Units Breakdown vs Total Counts)
                      Row(
                        children: [
                          Text(
                            'LIVE BREAKDOWN',
                            style: AppTypography.unitLabel(context)
                                .copyWith(letterSpacing: 1.5),
                          ),
                          const Spacer(),
                          Obx(() {
                            final isGranular = controller.isGranularView.value;

                            return GestureDetector(
                              onTap: controller.toggleViewMode,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.darkSurfaceElevated
                                      : AppColors.lightSurfaceElevated,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.darkBorder
                                        : AppColors.lightBorder,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isGranular
                                          ? CupertinoIcons.rectangle_grid_2x2
                                          : CupertinoIcons.list_bullet,
                                      size: 13,
                                      color: AppColors.primaryLight,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      isGranular
                                          ? 'Switch to Units'
                                          : 'Switch to Totals',
                                      style: AppTypography.bodySmall(
                                        context,
                                        color: AppColors.primaryLight,
                                      ).copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Dynamic Live Breakdown Area
                      Obx(() {
                        final time = controller.timeRemaining.value;
                        final event = controller.currentEvent.value;
                        final accentColor = Color(event.colorHex);
                        final isGranular = controller.isGranularView.value;

                        if (isGranular) {
                          return GranularBreakdownView(
                            timeRemaining: time,
                            accentColor: accentColor,
                          );
                        }

                        // Full Decomposed Unit Grid
                        return Column(
                          children: [
                            // Top Row: Years & Months (if > 0 or 2-column)
                            if (time.years > 0 || time.months > 0) ...[
                              Row(
                                children: [
                                  if (time.years > 0)
                                    Expanded(
                                      child: TimeUnitCard(
                                        value: time.years,
                                        label: time.years == 1
                                            ? 'Year'
                                            : 'Years',
                                        accentColor: accentColor,
                                      ),
                                    ),
                                  if (time.years > 0 && time.months > 0)
                                    const SizedBox(width: 10),
                                  if (time.months > 0)
                                    Expanded(
                                      child: TimeUnitCard(
                                        value: time.months,
                                        label: time.months == 1
                                            ? 'Month'
                                            : 'Months',
                                        accentColor: accentColor,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],

                            // Middle Row: Weeks & Days
                            Row(
                              children: [
                                Expanded(
                                  child: TimeUnitCard(
                                    value: time.weeks,
                                    label: time.weeks == 1 ? 'Week' : 'Weeks',
                                    accentColor: accentColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TimeUnitCard(
                                    value: time.days,
                                    label: time.days == 1 ? 'Day' : 'Days',
                                    accentColor: accentColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Bottom Row: Hours, Minutes, Seconds (Ticking live!)
                            Row(
                              children: [
                                Expanded(
                                  child: TimeUnitCard(
                                    value: time.hours,
                                    label: 'Hours',
                                    accentColor: accentColor,
                                    isSecondary: true,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TimeUnitCard(
                                    value: time.minutes,
                                    label: 'Mins',
                                    accentColor: accentColor,
                                    isSecondary: true,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TimeUnitCard(
                                    value: time.seconds,
                                    label: 'Secs',
                                    accentColor: accentColor,
                                    isSecondary: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 24),

                      // Notes Card (if notes provided)
                      Obx(() {
                        final notes = controller.currentEvent.value.notes;
                        if (notes == null || notes.trim().isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return GlassContainer(
                          padding: const EdgeInsets.all(16),
                          borderRadius: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.text_quote,
                                    size: 16,
                                    color: AppColors.primaryLight,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'MEMO / NOTES',
                                    style: AppTypography.unitLabel(context),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notes,
                                style: AppTypography.bodyMedium(context),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 24),

                      // Share Countdown Button
                      GradientButton(
                        text: 'Share Countdown',
                        icon: CupertinoIcons.share,
                        onPressed: controller.shareEvent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Confetti & Celebration Overlay (Only shown on completion or when active)
          Obx(() {
            final showBanner = controller.showCelebrationBanner.value;
            if (!showBanner) return const SizedBox.shrink();

            return CelebrationOverlay(
              confettiController: controller.confettiController,
              eventTitle: controller.currentEvent.value.title,
              onDismiss: controller.dismissCelebrationBanner,
            );
          }),
        ],
      ),
    );
  }
}
