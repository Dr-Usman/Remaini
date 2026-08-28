import 'package:flutter/material.dart';

/// Design tokens and dynamic color palettes for the Remaini app.
class AppColors {
  AppColors._();

  // Dark Theme Palette (Primary & Default)
  static const Color darkBg = Color(0xFF090D16);
  static const Color darkSurface = Color(0xFF121927);
  static const Color darkSurfaceElevated = Color(0xFF1B2438);
  static const Color darkCard = Color(0xFF161F32);
  static const Color darkBorder = Color(0xFF26334D);
  static const Color darkBorderLight = Color(0x334B5563);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextTertiary = Color(0xFF64748B);

  // Light Theme Palette
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF1F5F9);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderLight = Color(0x1A64748B);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextTertiary = Color(0xFF94A3B8);

  // Brand Accents
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentViolet = Color(0xFF8B5CF6);
  static const Color accentPink = Color(0xFFEC4899);

  // Urgency Palettes
  // 1. Far Away (> 30 days) - Serene Emerald Green
  static const Color urgencyFar = Color(0xFF10B981);
  static const Color urgencyFarBg = Color(0x1F10B981);
  static const Color urgencyFarGlow = Color(0x4010B981);

  // 2. Moderate (7 - 30 days) - Warm Amber
  static const Color urgencyModerate = Color(0xFFF59E0B);
  static const Color urgencyModerateBg = Color(0x1FF59E0B);
  static const Color urgencyModerateGlow = Color(0x40F59E0B);

  // 3. Near (< 7 days) - Vivid Coral Red
  static const Color urgencyNear = Color(0xFFEF4444);
  static const Color urgencyNearBg = Color(0x1FEF4444);
  static const Color urgencyNearGlow = Color(0x40EF4444);

  // 4. Today / Critical (< 24 hours) - High Energy Electric Flame
  static const Color urgencyToday = Color(0xFFFF4500);
  static const Color urgencyTodayBg = Color(0x2BFF4500);
  static const Color urgencyTodayGlow = Color(0x66FF4500);

  // 5. Expired / Celebration - Radiant Violet Pink
  static const Color urgencyExpired = Color(0xFFA855F7);
  static const Color urgencyExpiredBg = Color(0x1FA855F7);
  static const Color urgencyExpiredGlow = Color(0x40A855F7);

  // Preset Colors for Event Customization
  static const List<Color> eventAccentColors = [
    Color(0xFF6366F1), // Indigo
    Color(0xFF06B6D4), // Cyan
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Coral
    Color(0xFFEC4899), // Pink
    Color(0xFF8B5CF6), // Purple
    Color(0xFF14B8A6), // Teal
    Color(0xFF3B82F6), // Blue
    Color(0xFFF97316), // Orange
  ];

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF161F32), Color(0xFF111827)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glowFarGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glowModerateGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glowNearGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
