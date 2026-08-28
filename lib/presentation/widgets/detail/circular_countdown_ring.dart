import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/time_remaining.dart';

/// Neon glowing circular countdown progress ring with centered hero display.
class CircularCountdownRing extends StatefulWidget {
  final TimeRemaining timeRemaining;
  final Color accentColor;
  final double size;

  const CircularCountdownRing({
    super.key,
    required this.timeRemaining,
    required this.accentColor,
    this.size = 230,
  });

  @override
  State<CircularCountdownRing> createState() => _CircularCountdownRingState();
}

class _CircularCountdownRingState extends State<CircularCountdownRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final time = widget.timeRemaining;
    final color = widget.accentColor;

    // Pick the most impactful hero unit to display in center
    String heroValue;
    String heroUnit;

    if (time.isPast) {
      heroValue = '00';
      heroUnit = 'EVENT REACHED';
    } else if (time.years > 0) {
      heroValue = time.years.toString().padLeft(2, '0');
      heroUnit = time.years == 1 ? 'YEAR REMAINING' : 'YEARS REMAINING';
    } else if (time.months > 0) {
      heroValue = time.months.toString().padLeft(2, '0');
      heroUnit = time.months == 1 ? 'MONTH REMAINING' : 'MONTHS REMAINING';
    } else if (time.totalDays > 0) {
      heroValue = time.totalDays.toString().padLeft(2, '0');
      heroUnit = time.totalDays == 1 ? 'DAY REMAINING' : 'DAYS REMAINING';
    } else if (time.hours > 0) {
      heroValue = time.hours.toString().padLeft(2, '0');
      heroUnit = time.hours == 1 ? 'HOUR REMAINING' : 'HOURS REMAINING';
    } else if (time.minutes > 0) {
      heroValue = time.minutes.toString().padLeft(2, '0');
      heroUnit = time.minutes == 1 ? 'MINUTE REMAINING' : 'MINUTES REMAINING';
    } else {
      heroValue = time.seconds.toString().padLeft(2, '0');
      heroUnit = 'SECONDS REMAINING';
    }

    final double progress = time.isPast ? 1.0 : time.progress;
    final percentString = '${(progress * 100).toInt()}% elapsed';

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ambient pulse glow
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: widget.size * 0.78,
                height: widget.size * 0.78,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(
                    alpha: 0.05 + (_pulseController.value * 0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(
                        alpha: 0.15 + (_pulseController.value * 0.1),
                      ),
                      blurRadius: 36,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              );
            },
          ),

          // Custom Painted Circular Ring
          CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _CountdownRingPainter(
              progress: progress,
              color: color,
              isDark: isDark,
            ),
          ),

          // Hero Center Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hero Number with smooth animated transition
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: Text(
                  heroValue,
                  key: ValueKey(heroValue),
                  style:
                      AppTypography.displayGiant(
                        context,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ).copyWith(
                        height: 1.0,
                        letterSpacing: -2,
                        fontSize: widget.size * 0.28,
                      ),
                ),
              ),
              const SizedBox(height: 6),
              // Hero Unit Label
              Text(
                heroUnit,
                style: AppTypography.unitLabel(
                  context,
                  color: color,
                ).copyWith(fontSize: 10, letterSpacing: 1.6),
              ),
              const SizedBox(height: 8),
              // Elapsed Progress Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceElevated.withValues(alpha: 0.8)
                      : AppColors.lightSurfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 1,
                  ),
                ),
                child: Text(
                  percentString,
                  style: AppTypography.bodySmall(
                    context,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ).copyWith(fontWeight: FontWeight.w600, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool isDark;

  _CountdownRingPainter({
    required this.progress,
    required this.color,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;
    const strokeWidth = 10.0;

    // Track Paint
    final trackPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.07)
          : Colors.black.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress Arc Paint with Gradient
    final sweepAngle = 2 * math.pi * progress.clamp(0.0, 1.0);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: (3 * math.pi) / 2,
      colors: [color.withValues(alpha: 0.6), color],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Glow Shadow
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, glowPaint);

    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _CountdownRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.isDark != isDark;
  }
}
