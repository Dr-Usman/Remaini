import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/haptic_feedback.dart';

/// Interactive and dismissible celebration banner with confetti cannons.
class CelebrationOverlay extends StatelessWidget {
  final ConfettiController confettiController;
  final String eventTitle;
  final VoidCallback onDismiss;

  const CelebrationOverlay({
    super.key,
    required this.confettiController,
    required this.eventTitle,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Confetti Blast Cannons
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            emissionFrequency: 0.06,
            numberOfParticles: 35,
            gravity: 0.15,
            colors: const [
              AppColors.primary,
              AppColors.accentCyan,
              AppColors.accentViolet,
              AppColors.accentPink,
              AppColors.urgencyFar,
              AppColors.urgencyModerate,
            ],
          ),
        ),

        // SafeArea Positioned Banner
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child:
              SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Dismissible(
                        key: const Key('celebration_banner'),
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          AppHaptics.light();
                          onDismiss();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E1B2E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.urgencyExpired.withValues(
                                alpha: isDark ? 0.6 : 0.4,
                              ),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.urgencyExpired.withValues(
                                  alpha: isDark ? 0.3 : 0.18,
                                ),
                                blurRadius: 18,
                                spreadRadius: 1,
                                offset: const Offset(0, 6),
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: isDark ? 0.35 : 0.06,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Sparkle Icon Circle
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFA855F7),
                                      Color(0xFFEC4899),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFA855F7)
                                          .withValues(alpha: 0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  CupertinoIcons.sparkles,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Title & Subtitle with high contrast
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'IT’S TIME! 🎉',
                                          style:
                                              AppTypography.titleSmall(
                                                context,
                                                color: isDark
                                                    ? const Color(0xFFE9D5FF)
                                                    : const Color(0xFF7E22CE),
                                              ).copyWith(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 13,
                                                letterSpacing: 0.2,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'The countdown for "$eventTitle" has completed!',
                                      style:
                                          AppTypography.bodySmall(
                                            context,
                                            color: isDark
                                                ? const Color(0xFFCBD5E1)
                                                : const Color(0xFF334155),
                                          ).copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Close Button
                              GestureDetector(
                                onTap: () {
                                  AppHaptics.light();
                                  onDismiss();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : Colors.black.withValues(alpha: 0.06),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.xmark,
                                    size: 14,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 300.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: -0.5,
                    end: 0,
                    duration: 300.ms,
                    curve: Curves.easeOut,
                  ),
        ),
      ],
    );
  }
}
