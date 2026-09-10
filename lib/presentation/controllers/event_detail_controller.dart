import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/countdown_calculator.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../../data/models/countdown_event.dart';
import '../../../data/models/time_remaining.dart';
import '../routes/app_routes.dart';
import 'event_list_controller.dart';

/// Controller managing dynamic 1-second ticker updates, celebrations, and detail screen interactions.
class EventDetailController extends GetxController {
  late final Rx<CountdownEvent> currentEvent;
  late final Rx<TimeRemaining> timeRemaining;
  final RxBool isGranularView = false.obs;
  final RxBool showCelebrationBanner = false.obs;

  late final ConfettiController confettiController;
  Timer? _timer;
  Timer? _bannerDismissTimer;

  @override
  void onInit() {
    super.onInit();
    final CountdownEvent event = Get.arguments as CountdownEvent;
    currentEvent = event.obs;
    timeRemaining = CountdownCalculator.calculate(event).obs;

    confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Start 1-second dynamic countdown ticker
    _startTicker();

    // Trigger celebration if event is reached for the first time
    if (timeRemaining.value.isPast && !currentEvent.value.isCelebrated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerCelebration();
      });
    }
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final updated = CountdownCalculator.calculate(currentEvent.value);
      timeRemaining.value = updated;

      // If just crossed zero, fire celebration
      if (updated.isPast && !currentEvent.value.isCelebrated) {
        _triggerCelebration();
      }
    });
  }

  void _triggerCelebration() {
    AppHaptics.heavy();
    confettiController.play();
    showCelebrationBanner.value = true;

    final updatedEvent = currentEvent.value.copyWith(isCelebrated: true);
    currentEvent.value = updatedEvent;
    Get.find<EventListController>().updateEvent(updatedEvent);

    // Auto-dismiss banner after 6 seconds
    _bannerDismissTimer?.cancel();
    _bannerDismissTimer = Timer(const Duration(seconds: 6), () {
      showCelebrationBanner.value = false;
    });
  }

  void dismissCelebrationBanner() {
    AppHaptics.light();
    _bannerDismissTimer?.cancel();
    showCelebrationBanner.value = false;
  }

  void replayCelebration() {
    _triggerCelebration();
  }

  void toggleViewMode() {
    AppHaptics.selection();
    isGranularView.value = !isGranularView.value;
  }

  void togglePin() {
    final willBePinned = !currentEvent.value.isPinned;
    final updated = currentEvent.value.copyWith(isPinned: willBePinned);
    currentEvent.value = updated;
    Get.find<EventListController>().updateEvent(updated);
    AppHaptics.selection();

    Get.rawSnackbar(
      messageText: Row(
        children: [
          Icon(
            willBePinned
                ? CupertinoIcons.pin_fill
                : CupertinoIcons.pin_slash_fill,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              willBePinned
                  ? 'Pinned "${updated.title}" to top'
                  : 'Unpinned "${updated.title}"',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.darkSurfaceElevated.withValues(alpha: 0.95),
      borderRadius: 14,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Future<void> shareEvent() async {
    AppHaptics.light();
    final event = currentEvent.value;
    final time = timeRemaining.value;
    final formattedDate = AppDateFormatter.formatDateTime(event.targetDateTime);

    final shareText =
        '''
⏳ Countdown to ${event.title}!

📅 Target Date: $formattedDate
⏱️ Remaining Time: ${time.fullBreakdownString}
${event.notes != null && event.notes!.isNotEmpty ? '\n📝 Notes: ${event.notes}\n' : ''}
Tracked with Remaini ✨
''';

    await SharePlus.instance.share(
      ShareParams(text: shareText, subject: 'Countdown to ${event.title}'),
    );
  }

  void openEditEvent() async {
    final result = await Get.toNamed(
      AppRoutes.addEditEvent,
      arguments: currentEvent.value,
    );

    if (result is CountdownEvent) {
      currentEvent.value = result;
      timeRemaining.value = CountdownCalculator.calculate(result);
    }
  }

  void confirmDelete(BuildContext context) {
    AppHaptics.medium();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      Dialog(
        backgroundColor: isDark
            ? AppColors.darkSurfaceElevated
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.urgencyNear.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.trash_fill,
                  color: AppColors.urgencyNear,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Delete Countdown?',
                style: AppTypography.titleLarge(context),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to delete "${currentEvent.value.title}"? This cannot be undone.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium(context),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        'Cancel',
                        style: AppTypography.titleSmall(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.urgencyNear,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Get.back(); // close dialog
                        Get.find<EventListController>().deleteEvent(
                          currentEvent.value,
                        );
                        Get.back(); // return to home
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    _bannerDismissTimer?.cancel();
    confettiController.dispose();
    super.onClose();
  }
}
