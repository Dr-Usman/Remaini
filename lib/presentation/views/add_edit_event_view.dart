import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../../data/models/event_category.dart';
import '../controllers/add_edit_event_controller.dart';
import '../widgets/common/custom_text_field.dart';
import '../widgets/common/glass_container.dart';
import '../widgets/common/gradient_button.dart';

/// Screen for creating and editing countdown events with quick presets.
class AddEditEventView extends GetView<AddEditEventController> {
  const AddEditEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.isEditing ? 'Edit Countdown' : 'New Countdown',
          style: AppTypography.titleLarge(
            context,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            // Event Title
            CustomTextField(
              controller: controller.titleController,
              label: 'EVENT TITLE',
              hint: 'e.g. Summer Roadtrip, Product Launch',
              prefixIcon: CupertinoIcons.sparkles,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title for your event';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Date Selection Header & Quick Presets
            Row(
              children: [
                Text(
                  'TARGET DATE',
                  style: AppTypography.titleSmall(context).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  'Quick Presets',
                  style: AppTypography.bodySmall(
                    context,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Quick Date Presets Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _PresetChip(
                    label: 'Tomorrow',
                    onTap: controller.applyPresetTomorrow,
                  ),
                  _PresetChip(
                    label: 'Weekend',
                    onTap: controller.applyPresetThisWeekend,
                  ),
                  _PresetChip(
                    label: '+1 Week',
                    onTap: controller.applyPresetNextWeek,
                  ),
                  _PresetChip(
                    label: '+1 Month',
                    onTap: controller.applyPresetNextMonth,
                  ),
                  _PresetChip(
                    label: 'New Year',
                    onTap: controller.applyPresetNewYear,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Interactive Date Card Picker
            Obx(() {
              final date = controller.selectedDate.value;
              final formatted = DateFormat('EEEE, MMMM d, y').format(date);

              return GlassContainer(
                onTap: () async {
                  AppHaptics.light();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: isDark
                              ? const ColorScheme.dark(
                                  primary: AppColors.primary,
                                  onPrimary: Colors.white,
                                  surface: AppColors.darkSurfaceElevated,
                                  onSurface: Colors.white,
                                )
                              : const ColorScheme.light(
                                  primary: AppColors.primary,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: Colors.black87,
                                ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    controller.setDate(picked);
                  }
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                borderRadius: 16,
                backgroundColor: isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurfaceElevated,
                borderColor: isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        CupertinoIcons.calendar,
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Date',
                            style: AppTypography.bodySmall(
                              context,
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formatted,
                            style: AppTypography.titleSmall(context)
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 16,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),

            // Time Selection Header & Presets
            Row(
              children: [
                Text(
                  'TARGET TIME',
                  style: AppTypography.titleSmall(context).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  'Time Presets',
                  style: AppTypography.bodySmall(
                    context,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Quick Time Presets Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _PresetChip(
                    label: '9:00 AM',
                    onTap: () => controller.applyTimePreset(9, 0),
                  ),
                  _PresetChip(
                    label: '12:00 PM',
                    onTap: () => controller.applyTimePreset(12, 0),
                  ),
                  _PresetChip(
                    label: '6:00 PM',
                    onTap: () => controller.applyTimePreset(18, 0),
                  ),
                  _PresetChip(
                    label: 'Midnight',
                    onTap: () => controller.applyTimePreset(0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Interactive Time Card Picker
            Obx(() {
              final time = controller.selectedTime.value;
              final formattedTime = time.format(context);

              return GlassContainer(
                onTap: () async {
                  AppHaptics.light();
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: time,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: isDark
                              ? const ColorScheme.dark(
                                  primary: AppColors.primary,
                                  onPrimary: Colors.white,
                                  surface: AppColors.darkSurfaceElevated,
                                  onSurface: Colors.white,
                                )
                              : const ColorScheme.light(
                                  primary: AppColors.primary,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: Colors.black87,
                                ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    controller.setTime(picked);
                  }
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                borderRadius: 16,
                backgroundColor: isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurfaceElevated,
                borderColor: isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accentCyan.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        CupertinoIcons.clock,
                        color: AppColors.accentCyan,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Time',
                            style: AppTypography.bodySmall(
                              context,
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formattedTime,
                            style: AppTypography.titleSmall(context)
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 16,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),

            // Category Selector
            Text(
              'CATEGORY',
              style: AppTypography.titleSmall(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                final selectedCat = controller.selectedCategory.value;

                return Row(
                  children: EventCategory.predefined.map((cat) {
                    final isSelected = cat.name == selectedCat;

                    return GestureDetector(
                      onTap: () => controller.setCategory(cat.name),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? cat.defaultColor.withValues(alpha: 0.2)
                              : (isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurfaceElevated),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? cat.defaultColor
                                : (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder),
                            width: isSelected ? 1.6 : 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              cat.icon,
                              size: 16,
                              color: isSelected
                                  ? cat.defaultColor
                                  : AppColors.darkTextTertiary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              cat.name,
                              style:
                                  AppTypography.bodySmall(
                                    context,
                                    color: isSelected
                                        ? (isDark
                                              ? Colors.white
                                              : AppColors.lightTextPrimary)
                                        : (isDark
                                              ? AppColors.darkTextSecondary
                                              : AppColors.lightTextSecondary),
                                  ).copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Accent Color Customization
            Text(
              'ACCENT COLOR',
              style: AppTypography.titleSmall(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final selectedColor = controller.selectedColorHex.value;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: AppColors.eventAccentColors.map((color) {
                  final isSelected = color.toARGB32() == selectedColor;

                  return GestureDetector(
                    onTap: () => controller.setColor(color),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              CupertinoIcons.checkmark,
                              size: 18,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 24),

            // Notes / Description
            CustomTextField(
              controller: controller.notesController,
              label: 'NOTES / MEMO (OPTIONAL)',
              hint: 'Add reminders, flight numbers, or details...',
              prefixIcon: CupertinoIcons.text_quote,
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Pin Event Switch
            GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 16,
              backgroundColor: isDark
                  ? AppColors.darkSurface
                  : AppColors.lightSurfaceElevated,
              borderColor: isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.pin_fill,
                    size: 20,
                    color: AppColors.primaryLight,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pin to Top',
                          style: AppTypography.titleSmall(context)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Keep this event pinned at the top of your list',
                          style: AppTypography.bodySmall(context),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.isPinned.value,
                      activeTrackColor: AppColors.primary,
                      onChanged: (val) => controller.togglePin(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: GradientButton(
            text: controller.isEditing ? 'Save Changes' : 'Create Countdown',
            icon: controller.isEditing
                ? CupertinoIcons.checkmark_alt
                : CupertinoIcons.add,
            onPressed: controller.saveEvent,
          ),
        ),
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PresetChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurfaceElevated
              : AppColors.lightSurfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.bodySmall(
            context,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ).copyWith(fontWeight: FontWeight.w600, fontSize: 11),
        ),
      ),
    );
  }
}
