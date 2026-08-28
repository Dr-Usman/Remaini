import 'package:flutter/services.dart';

/// Tactile feedback helpers for buttons, toggles, and milestone interactions.
class AppHaptics {
  AppHaptics._();

  static void light() {
    HapticFeedback.lightImpact();
  }

  static void medium() {
    HapticFeedback.mediumImpact();
  }

  static void heavy() {
    HapticFeedback.heavyImpact();
  }

  static void selection() {
    HapticFeedback.selectionClick();
  }
}
