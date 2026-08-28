import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../common/glass_container.dart';

/// Glassmorphic countdown unit card with live ticking number animations.
class TimeUnitCard extends StatelessWidget {
  final int value;
  final String label;
  final Color? accentColor;
  final bool isSecondary;

  const TimeUnitCard({
    super.key,
    required this.value,
    required this.label,
    this.accentColor,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formattedValue = value.toString().padLeft(2, '0');
    final color = accentColor ?? AppColors.primary;

    return GlassContainer(
      padding: EdgeInsets.symmetric(
        horizontal: isSecondary ? 10 : 14,
        vertical: isSecondary ? 12 : 16,
      ),
      borderRadius: 18,
      backgroundColor: isDark
          ? AppColors.darkCard.withValues(alpha: 0.7)
          : AppColors.lightCard.withValues(alpha: 0.9),
      borderColor: isDark
          ? (value > 0
                ? color.withValues(alpha: 0.25)
                : AppColors.darkBorderLight)
          : (value > 0
                ? color.withValues(alpha: 0.2)
                : AppColors.lightBorderLight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Live Ticking Number with Slide/Fade animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              final inAnimation = Tween<Offset>(
                begin: const Offset(0.0, -0.4),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: inAnimation, child: child),
              );
            },
            child: Text(
              formattedValue,
              key: ValueKey<int>(value),
              style:
                  (isSecondary
                          ? AppTypography.displaySmall(context)
                          : AppTypography.displayMedium(context))
                      .copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
            ),
          ),
          const SizedBox(height: 4),

          // Unit Label
          Text(
            label.toUpperCase(),
            style:
                AppTypography.unitLabel(
                  context,
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ).copyWith(
                  fontSize: isSecondary ? 9 : 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }
}
