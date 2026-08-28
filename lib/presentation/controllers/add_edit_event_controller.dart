import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../../data/models/countdown_event.dart';
import '../../../data/models/event_category.dart';
import 'event_list_controller.dart';

/// Controller handling event creation, date/time pickers, quick presets, and validation.
class AddEditEventController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController notesController;

  final Rx<DateTime> selectedDate = DateTime.now()
      .add(const Duration(days: 7))
      .obs;
  final Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 12, minute: 0).obs;
  final RxString selectedCategory = AppConstants.categoryPersonal.obs;
  final RxInt selectedColorHex = AppColors.primary.toARGB32().obs;
  final RxInt selectedIconCodePoint = CupertinoIcons.sparkles.codePoint.obs;
  final RxBool isPinned = false.obs;

  bool isEditing = false;
  CountdownEvent? editingEvent;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    notesController = TextEditingController();

    if (Get.arguments is CountdownEvent) {
      isEditing = true;
      editingEvent = Get.arguments as CountdownEvent;
      _populateFromExisting(editingEvent!);
    } else {
      // Default to tomorrow 12:00 PM
      final now = DateTime.now();
      selectedDate.value = DateTime(now.year, now.month, now.day + 1);
      selectedTime.value = const TimeOfDay(hour: 12, minute: 0);
    }
  }

  void _populateFromExisting(CountdownEvent event) {
    titleController.text = event.title;
    notesController.text = event.notes ?? '';
    selectedDate.value = DateTime(
      event.targetDateTime.year,
      event.targetDateTime.month,
      event.targetDateTime.day,
    );
    selectedTime.value = TimeOfDay(
      hour: event.targetDateTime.hour,
      minute: event.targetDateTime.minute,
    );
    selectedCategory.value = event.category;
    selectedColorHex.value = event.colorHex;
    selectedIconCodePoint.value = event.iconCodePoint;
    isPinned.value = event.isPinned;
  }

  DateTime get targetDateTime {
    final date = selectedDate.value;
    final time = selectedTime.value;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    AppHaptics.selection();
  }

  void setTime(TimeOfDay time) {
    selectedTime.value = time;
    AppHaptics.selection();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    final cat = EventCategory.findByName(category);
    selectedIconCodePoint.value = cat.icon.codePoint;
    selectedColorHex.value = cat.defaultColor.toARGB32();
    AppHaptics.selection();
  }

  void setColor(Color color) {
    selectedColorHex.value = color.toARGB32();
    AppHaptics.selection();
  }

  void togglePin() {
    isPinned.value = !isPinned.value;
    AppHaptics.selection();
  }

  // --- Quick Date Presets ---

  void applyPresetTomorrow() {
    final now = DateTime.now();
    selectedDate.value = DateTime(now.year, now.month, now.day + 1);
    AppHaptics.light();
  }

  void applyPresetThisWeekend() {
    final now = DateTime.now();
    int daysUntilSaturday = DateTime.saturday - now.weekday;
    if (daysUntilSaturday <= 0) daysUntilSaturday += 7;
    selectedDate.value = DateTime(
      now.year,
      now.month,
      now.day + daysUntilSaturday,
    );
    selectedTime.value = const TimeOfDay(hour: 12, minute: 0);
    AppHaptics.light();
  }

  void applyPresetNextWeek() {
    final now = DateTime.now();
    selectedDate.value = DateTime(now.year, now.month, now.day + 7);
    AppHaptics.light();
  }

  void applyPresetNextMonth() {
    final now = DateTime.now();
    selectedDate.value = DateTime(now.year, now.month + 1, now.day);
    AppHaptics.light();
  }

  void applyPresetNewYear() {
    final now = DateTime.now();
    selectedDate.value = DateTime(now.year + 1, 1, 1);
    selectedTime.value = const TimeOfDay(hour: 0, minute: 0);
    selectedCategory.value = AppConstants.categoryHoliday;
    AppHaptics.light();
  }

  // --- Quick Time Presets ---

  void applyTimePreset(int hour, int minute) {
    selectedTime.value = TimeOfDay(hour: hour, minute: minute);
    AppHaptics.light();
  }

  // --- Save / Submit ---

  Future<void> saveEvent() async {
    if (!formKey.currentState!.validate()) {
      AppHaptics.medium();
      return;
    }

    AppHaptics.heavy();
    final eventListController = Get.find<EventListController>();

    final finalTarget = targetDateTime;

    if (isEditing && editingEvent != null) {
      final updated = editingEvent!.copyWith(
        title: titleController.text.trim(),
        targetDateTime: finalTarget,
        category: selectedCategory.value,
        colorHex: selectedColorHex.value,
        iconCodePoint: selectedIconCodePoint.value,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        isPinned: isPinned.value,
      );
      await eventListController.updateEvent(updated);
      Get.back(result: updated);
    } else {
      final newEvent = CountdownEvent(
        title: titleController.text.trim(),
        targetDateTime: finalTarget,
        category: selectedCategory.value,
        colorHex: selectedColorHex.value,
        iconCodePoint: selectedIconCodePoint.value,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        isPinned: isPinned.value,
      );
      await eventListController.addEvent(newEvent);
      Get.back(result: newEvent);
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
