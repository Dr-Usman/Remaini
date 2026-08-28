import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import 'gradient_button.dart';

/// Clean and engaging empty state screen when no countdowns exist.
class EmptyStateView extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onAction;
  final IconData icon;

  const EmptyStateView({
    super.key,
    this.title = 'No Countdowns Yet',
    this.message = 'Start anticipating your next big moment, trip, birthday, or milestone.',
    this.buttonText = 'Create Countdown',
    required this.onAction,
    this.icon = CupertinoIcons.hourglass,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(icon, size: 44, color: AppColors.primaryLight),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.titleLarge(
                context,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge(
                context,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 32),
            GradientButton(
              text: buttonText,
              icon: CupertinoIcons.add,
              onPressed: onAction,
            ),
          ],
        ),
      ),
    );
  }
}
