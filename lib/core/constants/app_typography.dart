import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography definitions using Outfit for bold countdowns and Plus Jakarta Sans for UI.
class AppTypography {
  AppTypography._();

  // Display Styles (Hero countdown numbers)
  static TextStyle displayGiant(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.outfit(
      fontSize: 56,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.5,
      color:
          color ??
          (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }

  static TextStyle displayLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.outfit(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.0,
      color:
          color ??
          (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }

  static TextStyle displayMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.outfit(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color:
          color ??
          (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }

  static TextStyle displaySmall(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      color:
          color ??
          (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }

  // Headings
  static TextStyle titleLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      color:
          color ??
          (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }

  static TextStyle titleMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color:
          color ??
          (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }

  static TextStyle titleSmall(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color:
          color ??
          (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
    );
  }

  // Body Styles
  static TextStyle bodyLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.plusJakartaSans(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color:
          color ??
          (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
    );
  }

  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.plusJakartaSans(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color:
          color ??
          (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
    );
  }

  static TextStyle bodySmall(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.plusJakartaSans(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color:
          color ??
          (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
    );
  }

  // Countdown Unit Label
  static TextStyle unitLabel(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.plusJakartaSans(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color:
          color ??
          (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
    );
  }

  // Badge Text
  static TextStyle badge(BuildContext context, {Color? color}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
      color: color ?? Colors.white,
    );
  }
}
