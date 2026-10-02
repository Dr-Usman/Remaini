import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/utils/haptic_feedback.dart';
import '../../data/models/app_language.dart';
import '../../l10n/app_localizations.dart';
import 'event_list_controller.dart';

/// Controller managing app settings, theme modes, haptics, legal modals, and community actions.
class SettingsController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final ThemeController themeController = Get.find<ThemeController>();

  final RxBool hapticsEnabled = true.obs;
  final RxString appVersion = '1.0.0'.obs;
  final RxString buildNumber = '1'.obs;
  final RxnString selectedLanguageCode = RxnString(null);

  Locale? get currentLocale => selectedLanguageCode.value != null
      ? Locale(selectedLanguageCode.value!)
      : null;

  String get currentLanguageDisplayName {
    final code = selectedLanguageCode.value;
    if (code == null) return 'System Default';
    final match = AppLanguage.supportedLanguages.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.supportedLanguages.first,
    );
    return '${match.flag} ${match.nativeName}';
  }

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
    _loadAppInfo();
  }

  void _loadSettings() {
    hapticsEnabled.value = _storageService.getSetting<bool>(
      'haptics_enabled',
      defaultValue: true,
    );
    final savedLang = _storageService.getSetting<String?>(
      AppConstants.keyLanguageCode,
      defaultValue: null,
    );
    selectedLanguageCode.value = savedLang;
  }

  Future<void> _loadAppInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      appVersion.value = info.version;
      buildNumber.value = info.buildNumber;
    } catch (_) {}
  }

  void setThemeMode(ThemeMode mode) {
    if (hapticsEnabled.value) AppHaptics.selection();
    themeController.setTheme(mode);
  }

  void toggleHaptics() {
    hapticsEnabled.value = !hapticsEnabled.value;
    _storageService.saveSetting('haptics_enabled', hapticsEnabled.value);
    if (hapticsEnabled.value) AppHaptics.medium();
  }

  void changeLanguage(String? code) {
    if (hapticsEnabled.value) AppHaptics.selection();
    selectedLanguageCode.value = code;
    if (code == null) {
      _storageService.removeSetting(AppConstants.keyLanguageCode);
      final deviceLocale = Get.deviceLocale ?? const Locale('en');
      if (Get.context != null) {
        Get.updateLocale(deviceLocale);
      }
    } else {
      _storageService.saveSetting<String?>(AppConstants.keyLanguageCode, code);
      if (Get.context != null) {
        Get.updateLocale(Locale(code));
      }
    }
  }

  void showLanguageSelectionDialog(BuildContext context) {
    if (hapticsEnabled.value) AppHaptics.light();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    Get.dialog(
      Dialog(
        backgroundColor: isDark
            ? AppColors.darkSurfaceElevated
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.globe,
                      color: AppColors.primaryLight,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n?.selectLanguage ?? 'Select Language',
                    style: AppTypography.titleLarge(context)
                        .copyWith(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.5,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: AppLanguage.supportedLanguages.map((lang) {
                      return Obx(() {
                        final isSelected =
                            selectedLanguageCode.value == lang.code;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Material(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.12)
                                : (isDark
                                      ? Colors.white.withValues(alpha: 0.04)
                                      : Colors.black.withValues(alpha: 0.03)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 2,
                              ),
                              leading: Text(
                                lang.flag,
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Text(
                                lang.nativeName,
                                style: AppTypography.bodyMedium(context)
                                    .copyWith(
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? AppColors.primary
                                          : null,
                                    ),
                              ),
                              subtitle: lang.code != null
                                  ? Text(
                                      lang.name,
                                      style: AppTypography.bodySmall(context),
                                    )
                                  : Text(
                                      l10n?.systemDefault ?? 'System Default',
                                      style: AppTypography.bodySmall(context),
                                    ),
                              trailing: isSelected
                                  ? const Icon(
                                      CupertinoIcons.checkmark_circle_fill,
                                      color: AppColors.primary,
                                      size: 22,
                                    )
                                  : null,
                              onTap: () {
                                changeLanguage(lang.code);
                                Get.back();
                              },
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareApp() async {
    if (hapticsEnabled.value) AppHaptics.light();
    await SharePlus.instance.share(
      ShareParams(
        text:
            'Track every moment that matters with Remaini ⏳ — The modern & beautiful countdown app!\n\nDownload now on Google Play:\n${AppConstants.playStoreUrl}',
        subject: 'Check out Remaini Countdown App',
      ),
    );
  }

  Future<void> rateApp() async {
    if (hapticsEnabled.value) AppHaptics.medium();
    final Uri marketUri = Uri.parse(
      'market://details?id=${AppConstants.applicationId}',
    );
    final Uri webUri = Uri.parse(AppConstants.playStoreUrl);

    try {
      if (await canLaunchUrl(marketUri)) {
        await launchUrl(marketUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  Future<void> openGitHub() async {
    if (hapticsEnabled.value) AppHaptics.light();
    final Uri url = Uri.parse(AppConstants.githubRepoUrl);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  Future<void> openMoreApps() async {
    if (hapticsEnabled.value) AppHaptics.light();
    final Uri url = Uri.parse(AppConstants.developerProfileUrl);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void contactSupport(BuildContext context) {
    if (hapticsEnabled.value) AppHaptics.light();
    _showContactOptionsDialog(context);
  }

  void _showContactOptionsDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      Dialog(
        backgroundColor: isDark
            ? AppColors.darkSurfaceElevated
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.chat_bubble_2_fill,
                      color: AppColors.primaryLight,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Contact & Feedback',
                    style: AppTypography.titleLarge(context)
                        .copyWith(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'How can we help you today?',
                style: AppTypography.bodySmall(context),
              ),
              const SizedBox(height: 16),

              // Option 1: General Inquiry
              _buildContactOptionTile(
                context: context,
                isDark: isDark,
                icon: CupertinoIcons.envelope_fill,
                iconColor: AppColors.accentCyan,
                title: 'General Contact',
                subtitle: 'Ask questions or say hello',
                onTap: () => _openMailWithOptions(
                  context,
                  subject: '[Remaini] General Inquiry',
                  body: 'Hi Usman,\n\nI have a question/inquiry regarding Remaini:\n\n',
                ),
              ),
              const SizedBox(height: 10),

              // Option 2: Suggest a Feature
              _buildContactOptionTile(
                context: context,
                isDark: isDark,
                icon: CupertinoIcons.lightbulb_fill,
                iconColor: const Color(0xFFF59E0B),
                title: 'Suggest a Feature',
                subtitle: 'Share ideas to make Remaini better',
                onTap: () => _openMailWithOptions(
                  context,
                  subject: '[Remaini] Feature Suggestion',
                  body: 'Hi Usman,\n\nI would love to suggest a new feature for Remaini:\n\n• Feature Idea:\n• Why it would be useful:\n\n',
                ),
              ),
              const SizedBox(height: 10),

              // Option 3: Report an Issue / Bug
              _buildContactOptionTile(
                context: context,
                isDark: isDark,
                icon: CupertinoIcons.ant_fill,
                iconColor: AppColors.urgencyNear,
                title: 'Report a Bug',
                subtitle: 'Let us know if something isn\'t working',
                onTap: () => _openMailWithOptions(
                  context,
                  subject: '[Remaini] Bug Report',
                  body: 'Hi Usman,\n\nI found an issue in Remaini:\n\n• What happened:\n• Steps to reproduce:\n\n',
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactOptionTile({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isDark ? AppColors.darkSurface : AppColors.lightSurfaceElevated,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Get.back();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
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
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleSmall(context)
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall(context)
                          .copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                size: 14,
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

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  Future<void> _openMailWithOptions(
    BuildContext context, {
    required String subject,
    required String body,
  }) async {
    if (hapticsEnabled.value) AppHaptics.selection();

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': body,
      }),
    );

    try {
      final bool launched = await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
      if (launched) return;
    } catch (_) {}

    if (context.mounted) {
      _showSupportEmailFallback(context);
    }
  }

  void _showSupportEmailFallback(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.mail_solid,
                      color: AppColors.primaryLight,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Contact Developer',
                      style: AppTypography.titleLarge(context)
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Could not launch your email client automatically. Feel free to copy our email:',
                style: AppTypography.bodyMedium(context),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurface
                      : AppColors.lightSurfaceElevated,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.envelope,
                      size: 18,
                      color: AppColors.primaryLight,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SelectableText(
                        AppConstants.supportEmail,
                        style: AppTypography.titleSmall(context).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        CupertinoIcons.doc_on_clipboard,
                        size: 16,
                      ),
                      label: const Text('Copy Email'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: AppConstants.supportEmail),
                        );
                        Get.back();
                        Get.rawSnackbar(
                          message:
                              'Email copied to clipboard: ${AppConstants.supportEmail}',
                          duration: const Duration(seconds: 2),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.darkSurfaceElevated,
                          borderRadius: 14,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Close',
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

  void showPrivacyPolicy(BuildContext context) {
    if (hapticsEnabled.value) AppHaptics.light();
    _showLegalSheet(
      context: context,
      title: 'Privacy Policy',
      content:
          '''
Last Updated: August 2026

At Remaini, your privacy is our absolute priority.

1. Offline-First & No Accounts
Remaini does not require you to create an account, log in, or provide any personal details. All your countdown events, memos, categories, and settings are stored strictly on your device using encrypted local storage (Hive CE).

2. Zero Data Collection
We do not track, collect, transmit, or sell your private event data, names, dates, notes, or usage habits to any remote servers or third-party advertising networks. Remaini contains zero third-party analytics trackers or ads.

3. Device Permissions
- Vibration / Haptic Feedback: Used only to provide tactile feedback when buttons are clicked or countdown milestones complete.
- Sharing: Used only when you explicitly choose to share a countdown summary via your device's native share sheet.

4. Data Retention & Deletion
You maintain 100% ownership and control over your data. You can delete individual events at any time or clear all stored countdowns instantly via "Reset All Events" in Settings.

5. Children's Privacy
Remaini does not collect personal data from anyone, making it safe for users of all ages.

6. Contact & Inquiries
If you have any questions or feedback regarding our privacy practices, contact us at:
${AppConstants.supportEmail}
''',
    );
  }

  void showTermsOfUse(BuildContext context) {
    if (hapticsEnabled.value) AppHaptics.light();
    _showLegalSheet(
      context: context,
      title: 'Terms of Use',
      content:
          '''
Last Updated: August 2026

Welcome to Remaini! By downloading, installing, or using the Remaini application, you agree to these Terms of Use.

1. License & Usage
Remaini grants you a personal, non-exclusive, non-transferable license to use the app for personal and productivity countdown tracking.

2. Local Data Responsibility
Because Remaini operates offline-first, your countdowns are stored solely on your device. Uninstalling the app or clearing application storage without creating a backup will permanently erase your local data.

3. Disclaimer of Warranties
Remaini is provided "AS IS" without warranties of any kind. While we strive for absolute accuracy in calendar and countdown calculations, Remaini is not liable for missed events or schedule conflicts.

4. Intellectual Property
All design tokens, animations, logos, graphics, and code are the proprietary intellectual property of Remaini and its creators.

5. Questions
For inquiries or support, contact:
${AppConstants.supportEmail}
''',
    );
  }

  void _showLegalSheet({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurfaceElevated
              : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkBorderLight
                      : AppColors.lightBorderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTypography.titleLarge(context)),
                IconButton(
                  icon: const Icon(CupertinoIcons.xmark_circle_fill),
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  content,
                  style: AppTypography.bodyMedium(context)
                      .copyWith(height: 1.6),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void confirmClearAllData(BuildContext context) {
    if (hapticsEnabled.value) AppHaptics.medium();
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
                'Reset All Events?',
                style: AppTypography.titleLarge(context),
              ),
              const SizedBox(height: 8),
              Text(
                'This will permanently delete all your custom countdowns from local storage.',
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
                      onPressed: () async {
                        Get.back();
                        await _storageService.clearAllEvents();
                        Get.find<EventListController>().loadEvents();

                        Get.snackbar(
                          'Cleared',
                          'All events have been cleared.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: isDark
                              ? AppColors.darkCard
                              : AppColors.lightCard,
                          colorText: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        );
                      },
                      child: const Text(
                        'Clear All',
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

  Future<void> seedSampleData(BuildContext context) async {
    if (hapticsEnabled.value) AppHaptics.light();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    await _storageService.saveSetting(
      AppConstants.keyHasSeededInitialData,
      false,
    );
    await _storageService.seedInitialDataIfFirstLaunch();
    Get.find<EventListController>().loadEvents();

    Get.snackbar(
      'Sample Data Added',
      'Loaded fresh sample countdowns into your list.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
      colorText: isDark
          ? AppColors.darkTextPrimary
          : AppColors.lightTextPrimary,
    );
  }
}
