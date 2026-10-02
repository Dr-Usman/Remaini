import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Remaini'**
  String get appName;

  /// Application tagline
  ///
  /// In en, this message translates to:
  /// **'Count every moment that matters'**
  String get appTagline;

  /// Header for nearest event spotlight
  ///
  /// In en, this message translates to:
  /// **'NEXT UP'**
  String get nextUp;

  /// Text when there are no events in spotlight
  ///
  /// In en, this message translates to:
  /// **'No upcoming events'**
  String get noUpcomingEvents;

  /// Hint to create first countdown
  ///
  /// In en, this message translates to:
  /// **'Tap + to create your first countdown'**
  String get tapPlusToCreate;

  /// Search input placeholder
  ///
  /// In en, this message translates to:
  /// **'Search countdowns...'**
  String get searchHint;

  /// Category filter: All
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// Category filter: Personal
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get categoryPersonal;

  /// Category filter: Work
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// Category filter: Birthday
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get categoryBirthday;

  /// Category filter: Holiday
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get categoryHoliday;

  /// Category filter: Travel
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get categoryTravel;

  /// Category filter: Milestone
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get categoryMilestone;

  /// Category filter: Anniversary
  ///
  /// In en, this message translates to:
  /// **'Anniversary'**
  String get categoryAnniversary;

  /// Sort option: Nearest First
  ///
  /// In en, this message translates to:
  /// **'Nearest First'**
  String get sortNearest;

  /// Sort option: Furthest First
  ///
  /// In en, this message translates to:
  /// **'Furthest First'**
  String get sortFurthest;

  /// Sort option: Title (A-Z)
  ///
  /// In en, this message translates to:
  /// **'Title (A-Z)'**
  String get sortTitleAz;

  /// Sort option: Date Added
  ///
  /// In en, this message translates to:
  /// **'Date Added'**
  String get sortDateCreated;

  /// Empty state title when search has no results
  ///
  /// In en, this message translates to:
  /// **'No matching countdowns'**
  String get noMatchingCountdowns;

  /// Empty state subtitle for search
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search query or category filter.'**
  String get adjustSearchOrFilter;

  /// Urgency badge: Far Away
  ///
  /// In en, this message translates to:
  /// **'Far Away'**
  String get urgencyFarAway;

  /// Urgency badge: Approaching
  ///
  /// In en, this message translates to:
  /// **'Approaching'**
  String get urgencyApproaching;

  /// Urgency badge: Soon
  ///
  /// In en, this message translates to:
  /// **'Soon'**
  String get urgencySoon;

  /// Urgency badge: Today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get urgencyToday;

  /// Urgency badge: Completed
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get urgencyCompleted;

  /// Urgency badge: Overdue
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get urgencyOverdue;

  /// Calendar unit: Years
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get unitYears;

  /// Calendar unit: Months
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get unitMonths;

  /// Calendar unit: Weeks
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get unitWeeks;

  /// Calendar unit: Days
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get unitDays;

  /// Calendar unit: Hours
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get unitHours;

  /// Calendar unit: Minutes
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get unitMinutes;

  /// Calendar unit: Seconds
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get unitSeconds;

  /// Short label: Days
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get shortDays;

  /// Short label: Hours
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get shortHours;

  /// Short label: Mins
  ///
  /// In en, this message translates to:
  /// **'Mins'**
  String get shortMins;

  /// Short label: Secs
  ///
  /// In en, this message translates to:
  /// **'Secs'**
  String get shortSecs;

  /// Precision unit: Total Years
  ///
  /// In en, this message translates to:
  /// **'Total Years'**
  String get totalYears;

  /// Precision unit: Total Months
  ///
  /// In en, this message translates to:
  /// **'Total Months'**
  String get totalMonths;

  /// Precision unit: Total Weeks
  ///
  /// In en, this message translates to:
  /// **'Total Weeks'**
  String get totalWeeks;

  /// Precision unit: Total Days
  ///
  /// In en, this message translates to:
  /// **'Total Days'**
  String get totalDays;

  /// Precision unit: Total Hours
  ///
  /// In en, this message translates to:
  /// **'Total Hours'**
  String get totalHours;

  /// Precision unit: Total Minutes
  ///
  /// In en, this message translates to:
  /// **'Total Minutes'**
  String get totalMinutes;

  /// Precision unit: Total Seconds
  ///
  /// In en, this message translates to:
  /// **'Total Seconds'**
  String get totalSeconds;

  /// Detail view tab: Calendar Units
  ///
  /// In en, this message translates to:
  /// **'Calendar Units'**
  String get calendarUnits;

  /// Detail view tab: Total Precision
  ///
  /// In en, this message translates to:
  /// **'Total Precision'**
  String get totalPrecision;

  /// Header when countdown completes
  ///
  /// In en, this message translates to:
  /// **'Milestone Reached! 🎉'**
  String get milestoneReached;

  /// Subtitle when countdown reaches zero
  ///
  /// In en, this message translates to:
  /// **'The moment has arrived!'**
  String get theMomentHasArrived;

  /// Action to share countdown
  ///
  /// In en, this message translates to:
  /// **'Share Countdown'**
  String get shareCountdown;

  /// Action to edit countdown
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get editEvent;

  /// Action to delete event
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get deleteEvent;

  /// Confirmation message for deleting an event
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String deleteEventConfirm(String title);

  /// Button: Delete
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Button: Cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Badge: Pinned
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get pinned;

  /// Badge: Unpinned
  ///
  /// In en, this message translates to:
  /// **'Unpinned'**
  String get unpinned;

  /// Action to pin event
  ///
  /// In en, this message translates to:
  /// **'Pin Event'**
  String get pinEvent;

  /// Action to unpin event
  ///
  /// In en, this message translates to:
  /// **'Unpin Event'**
  String get unpinEvent;

  /// Snackbar message when event is deleted
  ///
  /// In en, this message translates to:
  /// **'Event deleted'**
  String get eventDeleted;

  /// Action to undo deletion
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Title for creating new countdown
  ///
  /// In en, this message translates to:
  /// **'New Countdown'**
  String get newCountdown;

  /// Title for editing countdown
  ///
  /// In en, this message translates to:
  /// **'Edit Countdown'**
  String get editCountdown;

  /// Label for title input
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get eventTitle;

  /// Placeholder for event title
  ///
  /// In en, this message translates to:
  /// **'e.g., Summer Trip to Kyoto'**
  String get titlePlaceholder;

  /// Label for date and time picker
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get selectDateTime;

  /// Header for quick date chips
  ///
  /// In en, this message translates to:
  /// **'Quick Date Presets'**
  String get quickDatePresets;

  /// Quick preset: Tomorrow
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get presetTomorrow;

  /// Quick preset: This Weekend
  ///
  /// In en, this message translates to:
  /// **'This Weekend'**
  String get presetThisWeekend;

  /// Quick preset: +1 Week
  ///
  /// In en, this message translates to:
  /// **'+1 Week'**
  String get presetOneWeek;

  /// Quick preset: +1 Month
  ///
  /// In en, this message translates to:
  /// **'+1 Month'**
  String get presetOneMonth;

  /// Quick preset: New Year
  ///
  /// In en, this message translates to:
  /// **'New Year'**
  String get presetNewYear;

  /// Header for quick time chips
  ///
  /// In en, this message translates to:
  /// **'Quick Time Presets'**
  String get quickTimePresets;

  /// Time preset 9 AM
  ///
  /// In en, this message translates to:
  /// **'9:00 AM'**
  String get presetMorning;

  /// Time preset 12 PM
  ///
  /// In en, this message translates to:
  /// **'12:00 PM'**
  String get presetNoon;

  /// Time preset 6 PM
  ///
  /// In en, this message translates to:
  /// **'6:00 PM'**
  String get presetEvening;

  /// Time preset Midnight
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get presetMidnight;

  /// Label for category selector
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Label for color and icon customizer
  ///
  /// In en, this message translates to:
  /// **'Color & Icon'**
  String get colorAndIcon;

  /// Label for notes field
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesOptional;

  /// Placeholder for notes
  ///
  /// In en, this message translates to:
  /// **'Add any details, flight numbers, or memories...'**
  String get notesPlaceholder;

  /// Toggle to pin event
  ///
  /// In en, this message translates to:
  /// **'Pin to top of list'**
  String get pinToTop;

  /// Button to save new countdown
  ///
  /// In en, this message translates to:
  /// **'Save Countdown'**
  String get saveCountdown;

  /// Button to update countdown
  ///
  /// In en, this message translates to:
  /// **'Update Countdown'**
  String get updateCountdown;

  /// Validation error for missing title
  ///
  /// In en, this message translates to:
  /// **'Please enter an event title'**
  String get titleRequiredError;

  /// Empty state headline
  ///
  /// In en, this message translates to:
  /// **'No Countdowns Yet'**
  String get emptyTitle;

  /// Empty state description
  ///
  /// In en, this message translates to:
  /// **'Create your first countdown to track birthdays, vacations, milestones, and goals.'**
  String get emptySubtitle;

  /// Empty state call to action
  ///
  /// In en, this message translates to:
  /// **'Create Countdown'**
  String get createCountdown;

  /// Title of settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings & About'**
  String get settingsAndAbout;

  /// Section header: Appearance
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearance;

  /// Theme mode selector title
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// System theme mode
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Dark theme mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Light theme mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Section header: Preferences
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences;

  /// Language selector title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Title of language picker modal
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// System default language option
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Haptic feedback setting title
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get hapticFeedback;

  /// Haptic feedback setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Vibrate on button presses & milestones'**
  String get hapticSubtitle;

  /// Section header: Community & Support
  ///
  /// In en, this message translates to:
  /// **'COMMUNITY & SUPPORT'**
  String get communityAndSupport;

  /// Share app tile title
  ///
  /// In en, this message translates to:
  /// **'Share Remaini'**
  String get shareRemaini;

  /// Share app tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Tell your friends and family'**
  String get shareSubtitle;

  /// Rate app tile title
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// Rate app tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Leave a 5-star rating on Google Play'**
  String get rateSubtitle;

  /// More apps tile title
  ///
  /// In en, this message translates to:
  /// **'More Apps'**
  String get moreApps;

  /// More apps tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Discover more apps by Avenzor'**
  String get moreAppsSubtitle;

  /// Source code tile title
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// Source code tile subtitle
  ///
  /// In en, this message translates to:
  /// **'View repository & star on GitHub'**
  String get sourceCodeSubtitle;

  /// Contact us tile title
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// Contact us tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Reach out for support or feedback'**
  String get contactSubtitle;

  /// Section header: About & Legal
  ///
  /// In en, this message translates to:
  /// **'ABOUT & LEGAL'**
  String get aboutAndLegal;

  /// Privacy policy tile title
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms of service tile title
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Open source licenses tile title
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// Section header: Sample Data & Storage
  ///
  /// In en, this message translates to:
  /// **'SAMPLE DATA & STORAGE'**
  String get sampleDataLoader;

  /// Reset sample data tile title
  ///
  /// In en, this message translates to:
  /// **'Reset Sample Data'**
  String get resetSampleData;

  /// Reset sample data tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Reload default sample countdowns'**
  String get resetSampleDataSubtitle;

  /// Snackbar message on data reload
  ///
  /// In en, this message translates to:
  /// **'Sample countdowns reloaded!'**
  String get sampleDataReloaded;

  /// App share message template
  ///
  /// In en, this message translates to:
  /// **'Track every moment that matters with Remaini ⏳ — The modern & beautiful countdown app!\n\nDownload now on Google Play:\n{url}'**
  String shareMessage(String url);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bn',
    'de',
    'en',
    'es',
    'fr',
    'hi',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
