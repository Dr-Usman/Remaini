import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/countdown_calculator.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../../data/models/time_remaining.dart';
import '../../controllers/event_list_controller.dart';
import '../../routes/app_routes.dart';
import '../common/glass_container.dart';

/// Top header containing app branding, settings navigation, and nearest event spotlight.
class HomeHeader extends StatelessWidget {
  final VoidCallback onAddEvent;

  const HomeHeader({super.key, required this.onAddEvent});

  @override
  Widget build(BuildContext context) {
    final listController = Get.find<EventListController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Title Row & Settings Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          CupertinoIcons.hourglass,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Remaini',
                        style: AppTypography.titleLarge(context).copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Count every moment that matters',
                    style: AppTypography.bodySmall(
                      context,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              // Settings Button
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  AppHaptics.light();
                  Get.toNamed(AppRoutes.settings);
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkSurfaceElevated
                        : AppColors.lightSurfaceElevated,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.gear_alt_fill,
                    size: 20,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Nearest Event Spotlight Card (if any events exist)
          Obx(() {
            final nearest = listController.nearestEvent;
            if (nearest == null) return const SizedBox.shrink();

            final timeRemaining = CountdownCalculator.calculate(nearest);
            final urgencyColor = timeRemaining.urgency.color;

            return GlassContainer(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(16),
              borderRadius: 20,
              backgroundColor: isDark
                  ? AppColors.darkSurfaceElevated.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.9),
              glowColor: urgencyColor.withValues(alpha: 0.15),
              glowRadius: 12,
              onTap: () => listController.openEventDetail(nearest),
              child: Row(
                children: [
                  // Urgency Indicator Pill
                  Container(
                    width: 4,
                    height: 48,
                    decoration: BoxDecoration(
                      color: urgencyColor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: urgencyColor.withValues(alpha: 0.5),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Title & Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'NEXT UP',
                              style: AppTypography.unitLabel(
                                context,
                                color: urgencyColor,
                              ).copyWith(fontSize: 10, letterSpacing: 1.5),
                            ),
                            const Spacer(),
                            Text(
                              timeRemaining.shortFormattedString,
                              style: AppTypography.titleSmall(
                                context,
                                color: urgencyColor,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          nearest.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.titleMedium(context).copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 16,
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
