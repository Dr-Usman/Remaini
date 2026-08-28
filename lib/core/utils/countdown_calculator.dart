import '../../data/models/countdown_event.dart';
import '../../data/models/time_remaining.dart';

/// Accurate date arithmetic engine for Remaini countdown calculations.
class CountdownCalculator {
  CountdownCalculator._();

  /// Calculates the exact decomposed remaining time, total units, progress, and urgency.
  static TimeRemaining calculate(CountdownEvent event, {DateTime? customNow}) {
    final DateTime now = customNow ?? DateTime.now();
    final DateTime target = event.targetDateTime;
    final DateTime created = event.createdAt;

    final bool isPast = now.isAfter(target);
    final Duration difference = isPast
        ? now.difference(target)
        : target.difference(now);

    final int totalSeconds = difference.inSeconds;
    final int totalMinutes = difference.inMinutes;
    final int totalHours = difference.inHours;
    final int totalDays = difference.inDays;

    // Progress computation
    final Duration totalLifespan = target.difference(created);
    double progress = 0.0;
    if (totalLifespan.inMilliseconds > 0) {
      final Duration elapsed = now.difference(created);
      progress = (elapsed.inMilliseconds / totalLifespan.inMilliseconds).clamp(
        0.0,
        1.0,
      );
    } else {
      progress = isPast ? 1.0 : 0.0;
    }

    // Urgency determination
    final UrgencyLevel urgency;
    if (isPast) {
      urgency = UrgencyLevel.expired;
    } else if (totalHours < 24) {
      urgency = UrgencyLevel.today;
    } else if (totalDays < 7) {
      urgency = UrgencyLevel.near;
    } else if (totalDays <= 30) {
      urgency = UrgencyLevel.moderate;
    } else {
      urgency = UrgencyLevel.far;
    }

    // Decomposed calendar calculation
    int years = 0;
    int months = 0;
    int weeks = 0;
    int days = 0;
    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    if (!isPast) {
      DateTime temp = now;

      // Calculate whole years
      while (_addYears(temp, 1).isBefore(target) ||
          _addYears(temp, 1).isAtSameMomentAs(target)) {
        temp = _addYears(temp, 1);
        years++;
      }

      // Calculate whole months
      while (_addMonths(temp, 1).isBefore(target) ||
          _addMonths(temp, 1).isAtSameMomentAs(target)) {
        temp = _addMonths(temp, 1);
        months++;
      }

      // Remaining duration between temp and target
      final Duration remainingAfterMonths = target.difference(temp);
      final int remainingDays = remainingAfterMonths.inDays;
      weeks = remainingDays ~/ 7;
      days = remainingDays % 7;

      hours = (remainingAfterMonths.inHours) % 24;
      minutes = (remainingAfterMonths.inMinutes) % 60;
      seconds = (remainingAfterMonths.inSeconds) % 60;
    }

    // Short formatted string
    final String shortString = _generateShortString(
      isPast: isPast,
      totalDays: totalDays,
      totalHours: totalHours,
      totalMinutes: totalMinutes,
      totalSeconds: totalSeconds,
      years: years,
      months: months,
      days: days,
    );

    return TimeRemaining(
      years: years,
      months: months,
      weeks: weeks,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      totalDays: totalDays,
      totalHours: totalHours,
      totalMinutes: totalMinutes,
      totalSeconds: totalSeconds,
      progress: progress,
      isPast: isPast,
      urgency: urgency,
      shortFormattedString: shortString,
    );
  }

  static DateTime _addYears(DateTime dt, int count) {
    int newYear = dt.year + count;
    int maxDay = _daysInMonth(newYear, dt.month);
    int newDay = dt.day > maxDay ? maxDay : dt.day;
    return DateTime(
      newYear,
      dt.month,
      newDay,
      dt.hour,
      dt.minute,
      dt.second,
      dt.millisecond,
    );
  }

  static DateTime _addMonths(DateTime dt, int count) {
    int newYear = dt.year + ((dt.month + count - 1) ~/ 12);
    int newMonth = ((dt.month + count - 1) % 12) + 1;
    int maxDay = _daysInMonth(newYear, newMonth);
    int newDay = dt.day > maxDay ? maxDay : dt.day;
    return DateTime(
      newYear,
      newMonth,
      newDay,
      dt.hour,
      dt.minute,
      dt.second,
      dt.millisecond,
    );
  }

  static int _daysInMonth(int year, int month) {
    if (month == 2) {
      final bool isLeap =
          (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return isLeap ? 29 : 28;
    }
    const days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return days[month - 1];
  }

  static String _generateShortString({
    required bool isPast,
    required int totalDays,
    required int totalHours,
    required int totalMinutes,
    required int totalSeconds,
    required int years,
    required int months,
    required int days,
  }) {
    if (isPast) {
      if (totalDays > 0) return 'Passed ${totalDays}d ago';
      if (totalHours > 0) return 'Passed ${totalHours}h ago';
      return 'Happened just now';
    }

    if (years > 0) {
      return months > 0
          ? '$years y $months m left'
          : '$years ${years == 1 ? 'year' : 'years'} left';
    }
    if (months > 0) {
      return days > 0
          ? '$months m $days d left'
          : '$months ${months == 1 ? 'month' : 'months'} left';
    }
    if (totalDays > 1) {
      return '$totalDays days left';
    }
    if (totalDays == 1) {
      return '1 day left';
    }
    if (totalHours > 0) {
      final int mins = totalMinutes % 60;
      return '$totalHours h $mins m left';
    }
    if (totalMinutes > 0) {
      final int secs = totalSeconds % 60;
      return '$totalMinutes m $secs s left';
    }
    return '${totalSeconds}s left';
  }
}
