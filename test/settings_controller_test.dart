import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:remaini/core/services/storage_service.dart';
import 'package:remaini/core/theme/theme_controller.dart';
import 'package:remaini/presentation/controllers/settings_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SettingsController Tests', () {
    late Directory tempDir;
    late StorageService storageService;
    late ThemeController themeController;
    late SettingsController settingsController;

    setUp(() async {
      tempDir = Directory.systemTemp.createTempSync();

      storageService = StorageService();
      await storageService.init(customPath: tempDir.path);
      Get.put<StorageService>(storageService, permanent: true);

      themeController = ThemeController();
      Get.put<ThemeController>(themeController, permanent: true);

      settingsController = SettingsController();
      Get.put<SettingsController>(settingsController, permanent: true);
    });

    tearDown(() async {
      Get.reset();
      await Hive.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('Initializes with default haptics and version info', () {
      expect(settingsController.appVersion.value, '1.0.0');
      expect(settingsController.hapticsEnabled.value, true);
    });

    test('Toggling haptics updates state', () {
      settingsController.toggleHaptics();
      expect(settingsController.hapticsEnabled.value, false);
      settingsController.toggleHaptics();
      expect(settingsController.hapticsEnabled.value, true);
    });

    test('Changing language updates selectedLanguageCode and currentLocale', () {
      expect(settingsController.selectedLanguageCode.value, isNull);
      expect(settingsController.currentLocale, isNull);
      expect(settingsController.currentLanguageDisplayName, 'System Default');

      // Change to Spanish
      settingsController.changeLanguage('es');
      expect(settingsController.selectedLanguageCode.value, 'es');
      expect(settingsController.currentLocale?.languageCode, 'es');
      expect(settingsController.currentLanguageDisplayName, contains('Español'));

      // Change to German
      settingsController.changeLanguage('de');
      expect(settingsController.selectedLanguageCode.value, 'de');
      expect(settingsController.currentLocale?.languageCode, 'de');
      expect(settingsController.currentLanguageDisplayName, contains('Deutsch'));

      // Revert to system default
      settingsController.changeLanguage(null);
      expect(settingsController.selectedLanguageCode.value, isNull);
      expect(settingsController.currentLocale, isNull);
    });
  });

}
