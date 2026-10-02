import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../widgets/common/glass_container.dart';

/// Settings & About Screen providing theme customization, preferences, legal info, and feedback.
class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          l10n?.settingsAndAbout ?? 'Settings & About',
          style: AppTypography.titleLarge(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 48),
        physics: const BouncingScrollPhysics(),
        children: [
          // Branding Card
          GlassContainer(
            padding: const EdgeInsets.all(20),
            borderRadius: 24,
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    CupertinoIcons.hourglass,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Remaini',
                            style: AppTypography.titleLarge(context).copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Obx(
                              () => Text(
                                'v${controller.appVersion.value} (${controller.buildNumber.value})',
                                style:
                                    AppTypography.bodySmall(
                                      context,
                                      color: AppColors.primaryLight,
                                    ).copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n?.appTagline ?? 'Count every moment that matters',
                        style: AppTypography.bodySmall(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // --- Appearance Section ---
          _SectionTitle(title: l10n?.appearance ?? 'APPEARANCE'),
          const SizedBox(height: 10),
          GlassContainer(
            padding: const EdgeInsets.all(16),
            borderRadius: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n?.themeMode ?? 'Theme Mode',
                  style: AppTypography.titleSmall(context)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Obx(() {
                  final currentMode = controller.themeController.themeMode;

                  return Row(
                    children: [
                      Expanded(
                        child: _ThemeChoiceCard(
                          title: l10n?.system ?? 'System',
                          icon: CupertinoIcons.device_phone_portrait,
                          isSelected: currentMode == ThemeMode.system,
                          iconColor: AppColors.accentCyan,
                          onTap: () =>
                              controller.setThemeMode(ThemeMode.system),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ThemeChoiceCard(
                          title: l10n?.dark ?? 'Dark',
                          icon: CupertinoIcons.moon_fill,
                          isSelected: currentMode == ThemeMode.dark,
                          iconColor: const Color(0xFF818CF8),
                          onTap: () => controller.setThemeMode(ThemeMode.dark),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ThemeChoiceCard(
                          title: l10n?.light ?? 'Light',
                          icon: CupertinoIcons.sun_max_fill,
                          isSelected: currentMode == ThemeMode.light,
                          iconColor: const Color(0xFFF59E0B),
                          onTap: () => controller.setThemeMode(ThemeMode.light),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // --- Preferences Section ---
          _SectionTitle(title: l10n?.preferences ?? 'PREFERENCES'),
          const SizedBox(height: 10),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: 20,
            child: Column(
              children: [
                _SettingsTile(
                  icon: CupertinoIcons.globe,
                  iconColor: const Color(0xFF38BDF8),
                  title: l10n?.language ?? 'Language',
                  subtitle: l10n?.selectLanguage ?? 'Choose your language',
                  trailing: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.currentLanguageDisplayName,
                          style: AppTypography.bodySmall(
                            context,
                            color: AppColors.primaryLight,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          CupertinoIcons.chevron_forward,
                          size: 16,
                          color: AppColors.darkTextTertiary,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => controller.showLanguageSelectionDialog(context),
                ),
                const Divider(),
                _SettingsTile(
                  icon: CupertinoIcons.waveform,
                  iconColor: AppColors.accentCyan,
                  title: l10n?.hapticFeedback ?? 'Haptic Feedback',
                  subtitle: l10n?.hapticSubtitle ??
                      'Vibrate on button presses & milestones',
                  trailing: Obx(
                    () => CupertinoSwitch(
                      value: controller.hapticsEnabled.value,
                      activeTrackColor: AppColors.primary,
                      onChanged: (val) => controller.toggleHaptics(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // --- Community & Growth ---
          _SectionTitle(title: l10n?.communityAndSupport ?? 'COMMUNITY & SUPPORT'),

          const SizedBox(height: 10),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: 20,
            child: Column(
              children: [
                _SettingsTile(
                  icon: CupertinoIcons.share,
                  iconColor: AppColors.primaryLight,
                  title: l10n?.shareRemaini ?? 'Share Remaini',
                  subtitle: l10n?.shareSubtitle ?? 'Tell your friends and family',
                  onTap: controller.shareApp,
                ),
                const Divider(),
                _SettingsTile(
                  icon: CupertinoIcons.star_fill,
                  iconColor: const Color(0xFFF59E0B),
                  title: l10n?.rateApp ?? 'Rate App',
                  subtitle: l10n?.rateSubtitle ?? 'Leave a 5-star rating on Google Play',
                  onTap: controller.rateApp,
                ),
                const Divider(),
                _SettingsTile(
                  icon: CupertinoIcons.square_grid_2x2_fill,
                  iconColor: const Color(0xFF6366F1),
                  title: l10n?.moreApps ?? 'More Apps',
                  subtitle: l10n?.moreAppsSubtitle ?? 'Discover more apps by Avenzor',
                  onTap: controller.openMoreApps,
                ),
                const Divider(),
                _SettingsTile(
                  icon: CupertinoIcons.chevron_left_slash_chevron_right,
                  iconColor: const Color(0xFF8B5CF6),
                  title: l10n?.sourceCode ?? 'Source Code',
                  subtitle: l10n?.sourceCodeSubtitle ?? 'View repository & star on GitHub',
                  onTap: controller.openGitHub,
                ),
                const Divider(),
                _SettingsTile(
                  icon: CupertinoIcons.mail_solid,
                  iconColor: const Color(0xFF10B981),
                  title: l10n?.contactUs ?? 'Contact Us',
                  subtitle: l10n?.contactSubtitle ?? 'Get in touch, suggest features, or report bugs',
                  onTap: () => controller.contactSupport(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // --- Data Management ---
          _SectionTitle(title: l10n?.sampleDataLoader ?? 'DATA MANAGEMENT'),
          const SizedBox(height: 10),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: 20,
            child: Column(
              children: [
                _SettingsTile(
                  icon: CupertinoIcons.sparkles,
                  iconColor: AppColors.accentViolet,
                  title: l10n?.resetSampleData ?? 'Load Sample Countdowns',
                  subtitle: l10n?.resetSampleDataSubtitle ?? 'Seed initial example events',
                  onTap: () => controller.seedSampleData(context),
                ),
                const Divider(),
                _SettingsTile(
                  icon: CupertinoIcons.trash_fill,
                  iconColor: AppColors.urgencyNear,
                  title: 'Clear All Events',
                  subtitle: 'Permanently remove all local countdowns',
                  titleColor: AppColors.urgencyNear,
                  onTap: () => controller.confirmClearAllData(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // --- Legal & Info ---
          _SectionTitle(title: l10n?.aboutAndLegal ?? 'LEGAL & PRIVACY'),
          const SizedBox(height: 10),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: 20,
            child: Column(
              children: [
                _SettingsTile(
                  icon: CupertinoIcons.shield_fill,
                  iconColor: AppColors.accentCyan,
                  title: l10n?.privacyPolicy ?? 'Privacy Policy',
                  subtitle: '100% offline, zero data tracking',
                  onTap: () => controller.showPrivacyPolicy(context),
                ),
                const Divider(),
                _SettingsTile(
                  icon: CupertinoIcons.doc_text_fill,
                  iconColor: AppColors.primaryLight,
                  title: l10n?.termsOfService ?? 'Terms of Use',
                  subtitle: 'Terms and licensing conditions',
                  onTap: () => controller.showTermsOfUse(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Footer
          Center(
            child: Text(
              'Crafted with ❤️ for precision milestone tracking',
              style: AppTypography.bodySmall(
                context,
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: AppTypography.unitLabel(context)
            .copyWith(fontSize: 11, letterSpacing: 1.4),
      ),
    );
  }
}

class _ThemeChoiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Color iconColor;
  final VoidCallback onTap;

  const _ThemeChoiceCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : (isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurfaceElevated),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : (isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.04)),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.primaryLight : iconColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTypography.bodySmall(
                    context,
                    color: isSelected
                        ? (isDark ? Colors.white : AppColors.primaryDark)
                        : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                  ).copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap != null
            ? () {
                AppHaptics.selection();
                onTap!();
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleSmall(
                        context,
                        color: titleColor,
                      ).copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: AppTypography.bodySmall(
                          context,
                          color: isDark
                              ? AppColors.darkTextTertiary
                              : AppColors.lightTextTertiary,
                        ).copyWith(fontSize: 11),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onTap != null)
                Icon(
                  CupertinoIcons.chevron_right,
                  size: 16,
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
