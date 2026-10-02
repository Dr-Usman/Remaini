import 'package:flutter/cupertino.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../constants/app_constants.dart';
import '../../data/models/countdown_event.dart';

/// Storage service managing local persistence with Hive CE.
class StorageService {
  late Box _eventsBox;
  late Box _settingsBox;

  Future<StorageService> init({String? customPath}) async {
    if (customPath != null) {
      Hive.init(customPath);
    } else {
      await Hive.initFlutter();
    }
    _eventsBox = await Hive.openBox(AppConstants.eventsBoxName);
    _settingsBox = await Hive.openBox(AppConstants.settingsBoxName);
    return this;
  }

  // --- Events CRUD ---

  List<CountdownEvent> getAllEvents() {
    final List<CountdownEvent> list = [];
    for (final key in _eventsBox.keys) {
      final data = _eventsBox.get(key);
      if (data is Map) {
        try {
          list.add(CountdownEvent.fromMap(data));
        } catch (_) {
          // ignore corrupted single entry
        }
      }
    }
    return list;
  }

  CountdownEvent? getEvent(String id) {
    final data = _eventsBox.get(id);
    if (data is Map) {
      return CountdownEvent.fromMap(data);
    }
    return null;
  }

  Future<void> saveEvent(CountdownEvent event) async {
    await _eventsBox.put(event.id, event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _eventsBox.delete(id);
  }

  Future<void> clearAllEvents() async {
    await _eventsBox.clear();
  }

  // --- Settings ---

  T getSetting<T>(String key, {required T defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue) as T;
  }

  Future<void> saveSetting<T>(String key, T value) async {
    await _settingsBox.put(key, value);
  }

  Future<void> removeSetting(String key) async {
    await _settingsBox.delete(key);
  }

  // --- Initial Sample Seed Data ---

  Future<void> seedInitialDataIfFirstLaunch() async {
    final bool hasSeeded = getSetting<bool>(
      AppConstants.keyHasSeededInitialData,
      defaultValue: false,
    );

    if (!hasSeeded && _eventsBox.isEmpty) {
      final now = DateTime.now();

      final sampleEvents = [
        CountdownEvent(
          title: "New Year's Celebration 🎉",
          targetDateTime: DateTime(now.year + 1, 1, 1, 0, 0, 0),
          createdAt: now.subtract(const Duration(days: 30)),
          category: 'Holiday',
          colorHex: const Color(0xFFF59E0B).toARGB32(),
          iconCodePoint: CupertinoIcons.sparkles.codePoint,
          notes: 'Welcome the upcoming new year with goals and fireworks!',
          isPinned: true,
        ),
        CountdownEvent(
          title: 'Tokyo Dream Vacation ✈️',
          targetDateTime: now.add(
            const Duration(days: 42, hours: 8, minutes: 30),
          ),
          createdAt: now.subtract(const Duration(days: 15)),
          category: 'Travel',
          colorHex: const Color(0xFF06B6D4).toARGB32(),
          iconCodePoint: CupertinoIcons.airplane.codePoint,
          notes: 'Flight departure from Gate 4B at 8:30 AM',
          isPinned: true,
        ),
        CountdownEvent(
          title: 'Quarterly Project Launch 🚀',
          targetDateTime: now.add(
            const Duration(days: 5, hours: 14, minutes: 0),
          ),
          createdAt: now.subtract(const Duration(days: 10)),
          category: 'Work',
          colorHex: const Color(0xFF6366F1).toARGB32(),
          iconCodePoint: CupertinoIcons.briefcase_fill.codePoint,
          notes: 'Production release demo and keynote presentation',
          isPinned: false,
        ),
        CountdownEvent(
          title: "Emma's Birthday 🎂",
          targetDateTime: now.add(
            const Duration(days: 18, hours: 19, minutes: 0),
          ),
          createdAt: now.subtract(const Duration(days: 5)),
          category: 'Birthday',
          colorHex: const Color(0xFFEC4899).toARGB32(),
          iconCodePoint: CupertinoIcons.gift_fill.codePoint,
          notes: 'Dinner reservations at Skyline Bistro',
          isPinned: false,
        ),
      ];

      for (final event in sampleEvents) {
        await saveEvent(event);
      }

      await saveSetting(AppConstants.keyHasSeededInitialData, true);
    }
  }
}
