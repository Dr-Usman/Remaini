import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../../data/models/countdown_event.dart';
import '../routes/app_routes.dart';

/// Controller managing the home screen event feed, filtering, sorting, and pinning.
class EventListController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final RxList<CountdownEvent> allEvents = <CountdownEvent>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = AppConstants.categoryAll.obs;
  final RxString selectedSort = AppConstants.sortNearest.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  void loadEvents() {
    isLoading.value = true;
    allEvents.assignAll(_storageService.getAllEvents());
    _loadSavedSettings();
    isLoading.value = false;
  }

  void _loadSavedSettings() {
    selectedSort.value = _storageService.getSetting<String>(
      AppConstants.keySortOption,
      defaultValue: AppConstants.sortNearest,
    );
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    AppHaptics.selection();
  }

  void setSortOption(String sort) {
    selectedSort.value = sort;
    _storageService.saveSetting(AppConstants.keySortOption, sort);
    AppHaptics.selection();
  }

  /// Filtered and sorted list based on search, category filter, and sort preference.
  List<CountdownEvent> get filteredEvents {
    final now = DateTime.now();
    List<CountdownEvent> list = allEvents.where((event) {
      final matchesSearch =
          searchQuery.value.isEmpty ||
          event.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          (event.notes != null &&
              event.notes!.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ));

      final matchesCategory =
          selectedCategory.value == AppConstants.categoryAll ||
          event.category.toLowerCase() == selectedCategory.value.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();

    // Sort list
    list.sort((a, b) {
      // Pinned items always appear first
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;

      switch (selectedSort.value) {
        case AppConstants.sortFurthest:
          return b.targetDateTime.compareTo(a.targetDateTime);

        case AppConstants.sortTitleAz:
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());

        case AppConstants.sortDateCreated:
          return b.createdAt.compareTo(a.createdAt);

        case AppConstants.sortNearest:
        default:
          // Upcoming future events first sorted by nearest, followed by past events
          final aIsFuture = a.targetDateTime.isAfter(now);
          final bIsFuture = b.targetDateTime.isAfter(now);

          if (aIsFuture && !bIsFuture) return -1;
          if (!aIsFuture && bIsFuture) return 1;

          return a.targetDateTime.compareTo(b.targetDateTime);
      }
    });

    return list;
  }

  /// Nearest active upcoming event for highlight spotlight.
  CountdownEvent? get nearestEvent {
    final now = DateTime.now();
    final upcoming = allEvents
        .where((e) => e.targetDateTime.isAfter(now))
        .toList();
    if (upcoming.isEmpty) return null;

    upcoming.sort((a, b) => a.targetDateTime.compareTo(b.targetDateTime));
    return upcoming.first;
  }

  Future<void> addEvent(CountdownEvent event) async {
    await _storageService.saveEvent(event);
    allEvents.add(event);
  }

  Future<void> updateEvent(CountdownEvent event) async {
    await _storageService.saveEvent(event);
    final index = allEvents.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      allEvents[index] = event;
    }
  }

  Future<void> togglePin(CountdownEvent event) async {
    final willBePinned = !event.isPinned;
    final updated = event.copyWith(isPinned: willBePinned);
    await updateEvent(updated);
    AppHaptics.selection();

    // Show feedback toast
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
                  ? 'Pinned "${event.title}" to top'
                  : 'Unpinned "${event.title}"',
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

  Future<bool?> confirmDeleteEvent(
    BuildContext context,
    CountdownEvent event,
  ) async {
    AppHaptics.medium();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return await Get.dialog<bool>(
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
                'Are you sure you want to delete "${event.title}"?',
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
                      onPressed: () => Get.back(result: false),
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
                      onPressed: () => Get.back(result: true),
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

  Future<void> deleteEvent(CountdownEvent event) async {
    final deletedIndex = allEvents.indexWhere((e) => e.id == event.id);
    await _storageService.deleteEvent(event.id);
    allEvents.removeWhere((e) => e.id == event.id);

    // Show Undo snackbar
    Get.showSnackbar(
      GetSnackBar(
        message: 'Deleted "${event.title}"',
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.darkSurfaceElevated,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        mainButton: TextButton(
          onPressed: () async {
            await _storageService.saveEvent(event);
            if (deletedIndex != -1 && deletedIndex <= allEvents.length) {
              allEvents.insert(deletedIndex, event);
            } else {
              allEvents.add(event);
            }
            if (Get.isSnackbarOpen) Get.back();
          },
          child: const Text(
            'UNDO',
            style: TextStyle(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  void openEventDetail(CountdownEvent event) {
    Get.toNamed(AppRoutes.eventDetail, arguments: event);
  }

  void openAddEvent() {
    Get.toNamed(AppRoutes.addEditEvent);
  }

  void openEditEvent(CountdownEvent event) {
    Get.toNamed(AppRoutes.addEditEvent, arguments: event);
  }
}
