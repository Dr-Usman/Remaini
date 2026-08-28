import 'package:flutter_test/flutter_test.dart';
import 'package:remaini/data/models/countdown_event.dart';
import 'package:remaini/data/models/event_category.dart';

void main() {
  group('Data Models Tests', () {
    test('CountdownEvent serialization and deserialization', () {
      final now = DateTime.now();
      final target = now.add(const Duration(days: 30));

      final original = CountdownEvent(
        title: 'Trip to Paris',
        targetDateTime: target,
        createdAt: now,
        category: 'Travel',
        notes: 'Passport ready',
        isPinned: true,
      );

      final map = original.toMap();
      final recreated = CountdownEvent.fromMap(map);

      expect(recreated.id, original.id);
      expect(recreated.title, original.title);
      expect(recreated.category, original.category);
      expect(recreated.notes, original.notes);
      expect(recreated.isPinned, original.isPinned);
    });

    test('EventCategory lookup finds valid category or default fallback', () {
      final birthday = EventCategory.findByName('Birthday');
      expect(birthday.name, 'Birthday');

      final unknown = EventCategory.findByName('UnknownCategory123');
      expect(unknown.name, 'Custom');
    });
  });
}
