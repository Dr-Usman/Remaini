// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Remaini';

  @override
  String get appTagline => 'Count every moment that matters';

  @override
  String get nextUp => 'NEXT UP';

  @override
  String get noUpcomingEvents => 'No upcoming events';

  @override
  String get tapPlusToCreate => 'Tap + to create your first countdown';

  @override
  String get searchHint => 'Search countdowns...';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryPersonal => 'Personal';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryBirthday => 'Birthday';

  @override
  String get categoryHoliday => 'Holiday';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get categoryMilestone => 'Milestone';

  @override
  String get categoryAnniversary => 'Anniversary';

  @override
  String get sortNearest => 'Nearest First';

  @override
  String get sortFurthest => 'Furthest First';

  @override
  String get sortTitleAz => 'Title (A-Z)';

  @override
  String get sortDateCreated => 'Date Added';

  @override
  String get noMatchingCountdowns => 'No matching countdowns';

  @override
  String get adjustSearchOrFilter =>
      'Try adjusting your search query or category filter.';

  @override
  String get urgencyFarAway => 'Far Away';

  @override
  String get urgencyApproaching => 'Approaching';

  @override
  String get urgencySoon => 'Soon';

  @override
  String get urgencyToday => 'Today';

  @override
  String get urgencyCompleted => 'Completed';

  @override
  String get urgencyOverdue => 'Overdue';

  @override
  String get unitYears => 'Years';

  @override
  String get unitMonths => 'Months';

  @override
  String get unitWeeks => 'Weeks';

  @override
  String get unitDays => 'Days';

  @override
  String get unitHours => 'Hours';

  @override
  String get unitMinutes => 'Minutes';

  @override
  String get unitSeconds => 'Seconds';

  @override
  String get shortDays => 'Days';

  @override
  String get shortHours => 'Hours';

  @override
  String get shortMins => 'Mins';

  @override
  String get shortSecs => 'Secs';

  @override
  String get totalYears => 'Total Years';

  @override
  String get totalMonths => 'Total Months';

  @override
  String get totalWeeks => 'Total Weeks';

  @override
  String get totalDays => 'Total Days';

  @override
  String get totalHours => 'Total Hours';

  @override
  String get totalMinutes => 'Total Minutes';

  @override
  String get totalSeconds => 'Total Seconds';

  @override
  String get calendarUnits => 'Calendar Units';

  @override
  String get totalPrecision => 'Total Precision';

  @override
  String get milestoneReached => 'Milestone Reached! 🎉';

  @override
  String get theMomentHasArrived => 'The moment has arrived!';

  @override
  String get shareCountdown => 'Share Countdown';

  @override
  String get editEvent => 'Edit Event';

  @override
  String get deleteEvent => 'Delete Event';

  @override
  String deleteEventConfirm(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get pinned => 'Pinned';

  @override
  String get unpinned => 'Unpinned';

  @override
  String get pinEvent => 'Pin Event';

  @override
  String get unpinEvent => 'Unpin Event';

  @override
  String get eventDeleted => 'Event deleted';

  @override
  String get undo => 'Undo';

  @override
  String get newCountdown => 'New Countdown';

  @override
  String get editCountdown => 'Edit Countdown';

  @override
  String get eventTitle => 'Event Title';

  @override
  String get titlePlaceholder => 'e.g., Summer Trip to Kyoto';

  @override
  String get selectDateTime => 'Date & Time';

  @override
  String get quickDatePresets => 'Quick Date Presets';

  @override
  String get presetTomorrow => 'Tomorrow';

  @override
  String get presetThisWeekend => 'This Weekend';

  @override
  String get presetOneWeek => '+1 Week';

  @override
  String get presetOneMonth => '+1 Month';

  @override
  String get presetNewYear => 'New Year';

  @override
  String get quickTimePresets => 'Quick Time Presets';

  @override
  String get presetMorning => '9:00 AM';

  @override
  String get presetNoon => '12:00 PM';

  @override
  String get presetEvening => '6:00 PM';

  @override
  String get presetMidnight => 'Midnight';

  @override
  String get category => 'Category';

  @override
  String get colorAndIcon => 'Color & Icon';

  @override
  String get notesOptional => 'Notes (Optional)';

  @override
  String get notesPlaceholder =>
      'Add any details, flight numbers, or memories...';

  @override
  String get pinToTop => 'Pin to top of list';

  @override
  String get saveCountdown => 'Save Countdown';

  @override
  String get updateCountdown => 'Update Countdown';

  @override
  String get titleRequiredError => 'Please enter an event title';

  @override
  String get emptyTitle => 'No Countdowns Yet';

  @override
  String get emptySubtitle =>
      'Create your first countdown to track birthdays, vacations, milestones, and goals.';

  @override
  String get createCountdown => 'Create Countdown';

  @override
  String get settingsAndAbout => 'Settings & About';

  @override
  String get appearance => 'APPEARANCE';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get system => 'System';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get preferences => 'PREFERENCES';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get hapticSubtitle => 'Vibrate on button presses & milestones';

  @override
  String get communityAndSupport => 'COMMUNITY & SUPPORT';

  @override
  String get shareRemaini => 'Share Remaini';

  @override
  String get shareSubtitle => 'Tell your friends and family';

  @override
  String get rateApp => 'Rate App';

  @override
  String get rateSubtitle => 'Leave a 5-star rating on Google Play';

  @override
  String get moreApps => 'More Apps';

  @override
  String get moreAppsSubtitle => 'Discover more apps by Avenzor';

  @override
  String get sourceCode => 'Source Code';

  @override
  String get sourceCodeSubtitle => 'View repository & star on GitHub';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get contactSubtitle => 'Reach out for support or feedback';

  @override
  String get aboutAndLegal => 'ABOUT & LEGAL';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String get sampleDataLoader => 'SAMPLE DATA & STORAGE';

  @override
  String get resetSampleData => 'Reset Sample Data';

  @override
  String get resetSampleDataSubtitle => 'Reload default sample countdowns';

  @override
  String get sampleDataReloaded => 'Sample countdowns reloaded!';

  @override
  String shareMessage(String url) {
    return 'Track every moment that matters with Remaini ⏳ — The modern & beautiful countdown app!\n\nDownload now on Google Play:\n$url';
  }
}
