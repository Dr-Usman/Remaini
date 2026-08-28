import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_colors.dart';

/// Primary data model representing a user countdown event.
class CountdownEvent {
  final String id;
  final String title;
  final DateTime targetDateTime;
  final DateTime createdAt;
  final String category;
  final int colorHex;
  final int iconCodePoint;
  final String? notes;
  final bool isPinned;
  final bool isCelebrated;

  CountdownEvent({
    String? id,
    required this.title,
    required this.targetDateTime,
    DateTime? createdAt,
    this.category = 'Personal',
    int? colorHex,
    int? iconCodePoint,
    this.notes,
    this.isPinned = false,
    this.isCelebrated = false,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       colorHex = colorHex ?? AppColors.primary.toARGB32(),
       iconCodePoint = iconCodePoint ?? CupertinoIcons.sparkles.codePoint;

  CountdownEvent copyWith({
    String? id,
    String? title,
    DateTime? targetDateTime,
    DateTime? createdAt,
    String? category,
    int? colorHex,
    int? iconCodePoint,
    String? notes,
    bool? isPinned,
    bool? isCelebrated,
  }) {
    return CountdownEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      targetDateTime: targetDateTime ?? this.targetDateTime,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      colorHex: colorHex ?? this.colorHex,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      notes: notes ?? this.notes,
      isPinned: isPinned ?? this.isPinned,
      isCelebrated: isCelebrated ?? this.isCelebrated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'targetDateTime': targetDateTime.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'category': category,
      'colorHex': colorHex,
      'iconCodePoint': iconCodePoint,
      'notes': notes,
      'isPinned': isPinned,
      'isCelebrated': isCelebrated,
    };
  }

  factory CountdownEvent.fromMap(Map<dynamic, dynamic> map) {
    return CountdownEvent(
      id: map['id'] as String,
      title: map['title'] as String? ?? 'Untitled Event',
      targetDateTime: DateTime.parse(map['targetDateTime'] as String),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : DateTime.now(),
      category: map['category'] as String? ?? 'Personal',
      colorHex: map['colorHex'] as int? ?? AppColors.primary.toARGB32(),
      iconCodePoint:
          map['iconCodePoint'] as int? ?? CupertinoIcons.sparkles.codePoint,
      notes: map['notes'] as String?,
      isPinned: map['isPinned'] as bool? ?? false,
      isCelebrated: map['isCelebrated'] as bool? ?? false,
    );
  }
}
