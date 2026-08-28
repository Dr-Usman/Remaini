import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../controllers/event_list_controller.dart';
import '../widgets/common/empty_state_view.dart';
import '../widgets/home/event_card.dart';
import '../widgets/home/home_header.dart';
import '../widgets/home/search_filter_bar.dart';

/// Main Home Screen displaying countdown cards, search, filters, and quick creation.
class HomeView extends GetView<EventListController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Branding & Spotlight Header
            HomeHeader(
              onAddEvent: controller.openAddEvent,
            ),

            // Search, Categories & Sorting
            const SearchFilterBar(),
            const SizedBox(height: 12),

            // Event List or Empty State
            Expanded(
              child: Obx(() {
                final events = controller.filteredEvents;

                if (events.isEmpty) {
                  final hasAnyEvents = controller.allEvents.isNotEmpty;

                  if (hasAnyEvents) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              size: 48,
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No matching countdowns',
                              style: AppTypography.titleMedium(context),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Try adjusting your search query or category filter.',
                              textAlign: TextAlign.center,
                              style: AppTypography.bodySmall(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return EmptyStateView(onAction: controller.openAddEvent);
                }

                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async {
                    AppHaptics.light();
                    controller.loadEvents();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return EventCard(
                            event: event,
                            onTap: () => controller.openEventDetail(event),
                            onConfirmDelete: () =>
                                controller.confirmDeleteEvent(context, event),
                            onDelete: () => controller.deleteEvent(event),
                            onTogglePin: () => controller.togglePin(event),
                          )
                          .animate()
                          .fadeIn(
                            duration: 350.ms,
                            delay: (index * 40).ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            duration: 350.ms,
                            delay: (index * 40).ms,
                            curve: Curves.easeOut,
                          );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AppHaptics.light();
          controller.openAddEvent();
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        highlightElevation: 10,
        shape: const StadiumBorder(),
        icon: const Icon(CupertinoIcons.add, color: Colors.white, size: 20),
        label: Text(
          'New Countdown',
          style: AppTypography.titleSmall(
            context,
            color: Colors.white,
          ).copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.2),
        ),
      ),
    );
  }
}
