import 'package:intl/intl.dart';

/// Formatter utilities for clean, human-friendly date and time displays.
class AppDateFormatter {
  AppDateFormatter._();

  static final DateFormat _fullDateFormat = DateFormat('EEEE, MMMM d, y');
  static final DateFormat _mediumDateFormat = DateFormat('MMM d, y');
  static final DateFormat _timeFormat = DateFormat('h:mm a');
  static final DateFormat _dateTimeFormat = DateFormat('MMM d, y • h:mm a');

  static String formatFullDate(DateTime dateTime) {
    return _fullDateFormat.format(dateTime);
  }

  static String formatShortDate(DateTime dateTime) {
    return _mediumDateFormat.format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return _timeFormat.format(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormat.format(dateTime);
  }

  static String formatFriendlyTarget(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final differenceDays = targetDate.difference(today).inDays;

    final String timeStr = _timeFormat.format(dateTime);

    if (differenceDays == 0) {
      return 'Today at $timeStr';
    } else if (differenceDays == 1) {
      return 'Tomorrow at $timeStr';
    } else if (differenceDays == -1) {
      return 'Yesterday at $timeStr';
    } else if (differenceDays > 1 && differenceDays <= 6) {
      final dayName = DateFormat('EEEE').format(dateTime);
      return '$dayName at $timeStr';
    } else {
      return '${_mediumDateFormat.format(dateTime)} at $timeStr';
    }
  }
}
