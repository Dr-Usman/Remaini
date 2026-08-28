import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/constants/app_constants.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set immersive edge-to-edge system bars
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Storage Service (Hive CE 2026)
  final storageService = await StorageService().init();
  await storageService.seedInitialDataIfFirstLaunch();
  Get.put<StorageService>(storageService, permanent: true);

  // Initialize Theme Controller
  final themeController = Get.put<ThemeController>(
    ThemeController(),
    permanent: true,
  );

  runApp(RemainiApp(themeController: themeController));
}

class RemainiApp extends StatelessWidget {
  final ThemeController themeController;

  const RemainiApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        initialRoute: AppRoutes.home,
        getPages: AppRoutes.pages,
        defaultTransition: Transition.cupertino,
      );
    });
  }
}
