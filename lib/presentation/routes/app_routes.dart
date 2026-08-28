import 'package:get/get.dart';

import '../controllers/add_edit_event_controller.dart';
import '../controllers/event_detail_controller.dart';
import '../controllers/event_list_controller.dart';
import '../controllers/settings_controller.dart';
import '../views/add_edit_event_view.dart';
import '../views/event_detail_view.dart';
import '../views/home_view.dart';
import '../views/settings_view.dart';

/// App route definitions and dependency bindings.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String addEditEvent = '/add-edit-event';
  static const String eventDetail = '/event-detail';
  static const String settings = '/settings';

  static final List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<EventListController>(() => EventListController());
      }),
    ),
    GetPage(
      name: addEditEvent,
      page: () => const AddEditEventView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AddEditEventController>(() => AddEditEventController());
      }),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: eventDetail,
      page: () => const EventDetailView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<EventDetailController>(() => EventDetailController());
      }),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(() => SettingsController());
      }),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
