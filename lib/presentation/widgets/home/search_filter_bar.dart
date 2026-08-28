import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../controllers/event_list_controller.dart';

/// Search field with clear suffix button, category horizontal filter chips, and sorting dropdown.
class SearchFilterBar extends StatefulWidget {
  const SearchFilterBar({super.key});

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  late final TextEditingController _searchController;
  final EventListController _listController = Get.find<EventListController>();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: _listController.searchQuery.value,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Search & Sort Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Search Input with Clear Button
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkSurfaceElevated
                        : AppColors.lightSurfaceElevated,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _listController.setSearchQuery,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    style: AppTypography.bodyMedium(
                      context,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ).copyWith(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Search countdowns...',
                      hintStyle: AppTypography.bodyMedium(
                        context,
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      ),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        size: 18,
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      ),
                      suffixIcon: Obx(() {
                        final hasQuery =
                            _listController.searchQuery.value.isNotEmpty;
                        if (!hasQuery) return const SizedBox.shrink();

                        return GestureDetector(
                          onTap: () {
                            AppHaptics.light();
                            _searchController.clear();
                            _listController.setSearchQuery('');
                          },
                          child: Icon(
                            CupertinoIcons.clear_circled_solid,
                            size: 18,
                            color: isDark
                                ? AppColors.darkTextTertiary
                                : AppColors.lightTextTertiary,
                          ),
                        );
                      }),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Sort Popup Button
              Obx(() {
                final currentSort = _listController.selectedSort.value;
                return PopupMenuButton<String>(
                  initialValue: currentSort,
                  tooltip: 'Sort count downs',
                  onSelected: (val) {
                    AppHaptics.selection();
                    _listController.setSortOption(val);
                  },
                  itemBuilder: (context) => AppConstants.sortOptions.map((opt) {
                    final isSelected = opt == currentSort;
                    return PopupMenuItem<String>(
                      value: opt,
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? CupertinoIcons.checkmark_alt_circle_fill
                                : CupertinoIcons.circle,
                            size: 18,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.darkTextTertiary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            opt,
                            style:
                                AppTypography.bodyMedium(
                                  context,
                                  color: isSelected ? AppColors.primary : null,
                                ).copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkSurfaceElevated
                          : AppColors.lightSurfaceElevated,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.sort_down,
                      size: 20,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Category Filter Chips
        SizedBox(
          height: 44,
          child: Obx(() {
            final selectedCategory = _listController.selectedCategory.value;
            final allCategories = [
              AppConstants.categoryAll,
              ...AppConstants.categories,
            ];

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              itemCount: allCategories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = allCategories[index];
                final isSelected = cat == selectedCategory;

                return GestureDetector(
                  onTap: () {
                    AppHaptics.selection();
                    _listController.setCategory(cat);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected ? AppColors.primaryGradient : null,
                      color: isSelected
                          ? null
                          : (isDark
                                ? AppColors.darkSurfaceElevated
                                : AppColors.lightSurfaceElevated),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : (isDark
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder),
                        width: 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.35,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        cat,
                        style:
                            AppTypography.bodySmall(
                              context,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                            ).copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
