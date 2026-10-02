/// Global application constants, Hive box identifiers, and default configurations.
class AppConstants {
  AppConstants._();

  static const String appName = 'Remaini';
  static const String appTagline = 'Count every moment that matters';
  static const String applicationId = 'com.avenzor.remaini';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.avenzor.remaini';
  static const String developerProfileUrl =
      'https://play.google.com/store/apps/dev?id=5809108425817759974';
  static const String githubRepoUrl = 'https://github.com/Dr-Usman/Remaini';
  static const String supportEmail = 'dr.usman7860@gmail.com';

  // Hive Box Names
  static const String eventsBoxName = 'remaini_events_box';
  static const String settingsBoxName = 'remaini_settings_box';

  // Settings Keys
  static const String keyIsDarkMode = 'is_dark_mode';
  static const String keySortOption = 'sort_option';
  static const String keyHasSeededInitialData = 'has_seeded_initial_data';
  static const String keyLanguageCode = 'language_code';

  // Default Categories
  static const String categoryAll = 'All';
  static const String categoryPersonal = 'Personal';
  static const String categoryWork = 'Work';
  static const String categoryBirthday = 'Birthday';
  static const String categoryHoliday = 'Holiday';
  static const String categoryTravel = 'Travel';
  static const String categoryMilestone = 'Milestone';
  static const String categoryAnniversary = 'Anniversary';

  static const List<String> categories = [
    categoryPersonal,
    categoryWork,
    categoryBirthday,
    categoryHoliday,
    categoryTravel,
    categoryMilestone,
    categoryAnniversary,
  ];

  // Sort Options
  static const String sortNearest = 'Nearest First';
  static const String sortFurthest = 'Furthest First';
  static const String sortTitleAz = 'Title (A-Z)';
  static const String sortDateCreated = 'Date Added';

  static const List<String> sortOptions = [
    sortNearest,
    sortFurthest,
    sortTitleAz,
    sortDateCreated,
  ];
}
