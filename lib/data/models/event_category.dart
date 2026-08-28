import 'package:flutter/cupertino.dart';

/// Predefined categories with icons, accent colors, and identifiers.
class EventCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color defaultColor;

  const EventCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.defaultColor,
  });

  static const List<EventCategory> predefined = [
    EventCategory(
      id: 'personal',
      name: 'Personal',
      icon: CupertinoIcons.person_fill,
      defaultColor: Color(0xFF6366F1),
    ),
    EventCategory(
      id: 'work',
      name: 'Work',
      icon: CupertinoIcons.briefcase_fill,
      defaultColor: Color(0xFF3B82F6),
    ),
    EventCategory(
      id: 'birthday',
      name: 'Birthday',
      icon: CupertinoIcons.gift_fill,
      defaultColor: Color(0xFFEC4899),
    ),
    EventCategory(
      id: 'holiday',
      name: 'Holiday',
      icon: CupertinoIcons.sparkles,
      defaultColor: Color(0xFFF59E0B),
    ),
    EventCategory(
      id: 'travel',
      name: 'Travel',
      icon: CupertinoIcons.airplane,
      defaultColor: Color(0xFF06B6D4),
    ),
    EventCategory(
      id: 'milestone',
      name: 'Milestone',
      icon: CupertinoIcons.flag_fill,
      defaultColor: Color(0xFF10B981),
    ),
    EventCategory(
      id: 'anniversary',
      name: 'Anniversary',
      icon: CupertinoIcons.heart_fill,
      defaultColor: Color(0xFFEF4444),
    ),
    EventCategory(
      id: 'custom',
      name: 'Custom',
      icon: CupertinoIcons.star_fill,
      defaultColor: Color(0xFF8B5CF6),
    ),
  ];

  static EventCategory findByName(String name) {
    return predefined.firstWhere(
      (c) => c.name.toLowerCase() == name.toLowerCase(),
      orElse: () => predefined.last,
    );
  }

  static IconData getIconByName(String name) {
    return findByName(name).icon;
  }
}
