import 'package:flutter_test/flutter_test.dart';
import 'package:remaini/core/utils/countdown_calculator.dart';
import 'package:remaini/data/models/countdown_event.dart';
import 'package:remaini/data/models/time_remaining.dart';

void main() {
  group('CountdownCalculator Tests', () {
    test('Calculates future countdown breakdown correctly', () {
      final base = DateTime(2026, 1, 1, 12, 0, 0);
      final target = DateTime(2026, 1, 15, 15, 30, 45);

      final event = CountdownEvent(
        title: 'Test Event',
        targetDateTime: target,
        createdAt: base,
      );

      final result = CountdownCalculator.calculate(event, customNow: base);

      expect(result.isPast, false);
      expect(result.totalDays, 14);
      expect(result.days, 0); // 14 days = 2 weeks 0 days
      expect(result.weeks, 2);
      expect(result.hours, 3);
      expect(result.minutes, 30);
      expect(result.seconds, 45);
      expect(result.urgency, UrgencyLevel.moderate);
    });

    test('Identifies today / critical urgency when less than 24 hours', () {
      final now = DateTime(2026, 5, 10, 10, 0, 0);
      final target = DateTime(2026, 5, 10, 18, 0, 0);

      final event = CountdownEvent(
        title: 'Presentation',
        targetDateTime: target,
        createdAt: now.subtract(const Duration(days: 2)),
      );

      final result = CountdownCalculator.calculate(event, customNow: now);

      expect(result.isPast, false);
      expect(result.urgency, UrgencyLevel.today);
      expect(result.hours, 8);
      expect(result.totalHours, 8);
    });

    test('Identifies expired events and sets urgency to expired', () {
      final now = DateTime(2026, 6, 1, 12, 0, 0);
      final target = DateTime(2026, 5, 1, 12, 0, 0);

      final event = CountdownEvent(
        title: 'Past Anniversary',
        targetDateTime: target,
        createdAt: target.subtract(const Duration(days: 365)),
      );

      final result = CountdownCalculator.calculate(event, customNow: now);

      expect(result.isPast, true);
      expect(result.urgency, UrgencyLevel.expired);
      expect(result.progress, 1.0);
      expect(result.shortFormattedString, contains('Passed'));
    });

    test('Computes progress ratio accurately', () {
      final created = DateTime(2026, 1, 1, 0, 0, 0);
      final target = DateTime(2026, 1, 11, 0, 0, 0); // 10 days total
      final now = DateTime(2026, 1, 6, 0, 0, 0); // 5 days elapsed (50%)

      final event = CountdownEvent(
        title: 'Halfway Event',
        targetDateTime: target,
        createdAt: created,
      );

      final result = CountdownCalculator.calculate(event, customNow: now);

      expect(result.progress, closeTo(0.5, 0.01));
    });
  });
}
