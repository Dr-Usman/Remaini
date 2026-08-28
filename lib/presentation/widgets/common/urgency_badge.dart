import 'package:flutter/material.dart';

import '../../../core/constants/app_typography.dart';
import '../../../data/models/time_remaining.dart';

/// Dynamic status pill badge displaying urgency with subtle glow and colored dot.
class UrgencyBadge extends StatelessWidget {
  final UrgencyLevel urgency;
  final String? customLabel;
  final bool showDot;

  const UrgencyBadge({
    super.key,
    required this.urgency,
    this.customLabel,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = urgency.color;
    final bgColor = urgency.bgColor;
    final label = customLabel ?? urgency.label;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.6),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTypography.badge(
              context,
              color: color,
            ).copyWith(fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
