import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Urgency classification for dynamic visual feedback.
enum UrgencyLevel {
  far, // > 30 days
  moderate, // 7 - 30 days
  near, // < 7 days
  today, // < 24 hours
  expired, // 0 or passed
}

extension UrgencyLevelX on UrgencyLevel {
  String get label {
    switch (this) {
      case UrgencyLevel.far:
        return 'Far Away';
      case UrgencyLevel.moderate:
        return 'Approaching';
      case UrgencyLevel.near:
        return 'Soon';
      case UrgencyLevel.today:
        return 'Today';
      case UrgencyLevel.expired:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case UrgencyLevel.far:
        return AppColors.urgencyFar;
      case UrgencyLevel.moderate:
        return AppColors.urgencyModerate;
      case UrgencyLevel.near:
        return AppColors.urgencyNear;
      case UrgencyLevel.today:
        return AppColors.urgencyToday;
      case UrgencyLevel.expired:
        return AppColors.urgencyExpired;
    }
  }

  Color get bgColor {
    switch (this) {
      case UrgencyLevel.far:
        return AppColors.urgencyFarBg;
      case UrgencyLevel.moderate:
        return AppColors.urgencyModerateBg;
      case UrgencyLevel.near:
        return AppColors.urgencyNearBg;
      case UrgencyLevel.today:
        return AppColors.urgencyTodayBg;
      case UrgencyLevel.expired:
        return AppColors.urgencyExpiredBg;
    }
  }

  Color get glowColor {
    switch (this) {
      case UrgencyLevel.far:
        return AppColors.urgencyFarGlow;
      case UrgencyLevel.moderate:
        return AppColors.urgencyModerateGlow;
      case UrgencyLevel.near:
        return AppColors.urgencyNearGlow;
      case UrgencyLevel.today:
        return AppColors.urgencyTodayGlow;
      case UrgencyLevel.expired:
        return AppColors.urgencyExpiredGlow;
    }
  }
}

/// Represents the calculated time breakdown for an event.
class TimeRemaining {
  final int years;
  final int months;
  final int weeks;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  final int totalDays;
  final int totalHours;
  final int totalMinutes;
  final int totalSeconds;

  final double progress; // 0.0 (just started) to 1.0 (reached target)
  final bool isPast;
  final UrgencyLevel urgency;
  final String shortFormattedString;

  const TimeRemaining({
    required this.years,
    required this.months,
    required this.weeks,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.totalDays,
    required this.totalHours,
    required this.totalMinutes,
    required this.totalSeconds,
    required this.progress,
    required this.isPast,
    required this.urgency,
    required this.shortFormattedString,
  });

  /// Formatted breakdown string for sharing or detailed display.
  String get fullBreakdownString {
    if (isPast) {
      return 'Event reached ($totalDays days ago)';
    }

    final List<String> parts = [];
    if (years > 0) parts.add('$years ${years == 1 ? 'year' : 'years'}');
    if (months > 0) parts.add('$months ${months == 1 ? 'month' : 'months'}');
    if (weeks > 0) parts.add('$weeks ${weeks == 1 ? 'week' : 'weeks'}');
    if (days > 0) parts.add('$days ${days == 1 ? 'day' : 'days'}');
    if (hours > 0) parts.add('$hours ${hours == 1 ? 'hr' : 'hrs'}');
    if (minutes > 0) parts.add('$minutes ${minutes == 1 ? 'min' : 'mins'}');
    parts.add('$seconds ${seconds == 1 ? 'sec' : 'secs'}');

    return parts.join(', ');
  }

  /// Initial placeholder empty object
  factory TimeRemaining.empty() {
    return const TimeRemaining(
      years: 0,
      months: 0,
      weeks: 0,
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0,
      totalDays: 0,
      totalHours: 0,
      totalMinutes: 0,
      totalSeconds: 0,
      progress: 0.0,
      isPast: false,
      urgency: UrgencyLevel.far,
      shortFormattedString: '0s left',
    );
  }
}
