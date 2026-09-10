import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/storage_service.dart';

/// GetxController to handle theme switching (System, Dark, Light) and persistence.
class ThemeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;

  bool get isSystemMode => _themeMode.value == ThemeMode.system;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
  bool get isLightMode => _themeMode.value == ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final String savedMode = _storageService.getSetting<String>(
      'theme_mode_preference',
      defaultValue: 'system',
    );

    switch (savedMode) {
      case 'dark':
        _themeMode.value = ThemeMode.dark;
        break;
      case 'light':
        _themeMode.value = ThemeMode.light;
        break;
      case 'system':
      default:
        _themeMode.value = ThemeMode.system;
        break;
    }
  }

  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;

    String modeStr = 'system';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    if (mode == ThemeMode.light) modeStr = 'light';

    _storageService.saveSetting('theme_mode_preference', modeStr);
  }
}
