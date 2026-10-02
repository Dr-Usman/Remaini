// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'Remaini';

  @override
  String get appTagline => 'हर खास पल को गिनें';

  @override
  String get nextUp => 'अगला कार्यक्रम';

  @override
  String get noUpcomingEvents => 'कोई आगामी कार्यक्रम नहीं';

  @override
  String get tapPlusToCreate => 'पहला काउंटडाउन बनाने के लिए + दबाएं';

  @override
  String get searchHint => 'काउंटडाउन खोजें...';

  @override
  String get categoryAll => 'सभी';

  @override
  String get categoryPersonal => 'व्यक्तिगत';

  @override
  String get categoryWork => 'काम';

  @override
  String get categoryBirthday => 'जन्मदिन';

  @override
  String get categoryHoliday => 'छुट्टी';

  @override
  String get categoryTravel => 'यात्रा';

  @override
  String get categoryMilestone => 'लक्ष्य / मील का पत्थर';

  @override
  String get categoryAnniversary => 'सालगिरह';

  @override
  String get sortNearest => 'निकटतम पहले';

  @override
  String get sortFurthest => 'दूरतम पहले';

  @override
  String get sortTitleAz => 'शीर्षक (A-Z)';

  @override
  String get sortDateCreated => 'जोड़ने की तिथि';

  @override
  String get noMatchingCountdowns => 'कोई मेल खाता काउंटडाउन नहीं मिला';

  @override
  String get adjustSearchOrFilter => 'अपनी खोज या श्रेणी फ़िल्टर बदलकर देखें।';

  @override
  String get urgencyFarAway => 'काफी समय है';

  @override
  String get urgencyApproaching => 'करीब आ रहा है';

  @override
  String get urgencySoon => 'जल्द ही';

  @override
  String get urgencyToday => 'आज';

  @override
  String get urgencyCompleted => 'पूरा हुआ';

  @override
  String get urgencyOverdue => 'समय बीत गया';

  @override
  String get unitYears => 'वर्ष';

  @override
  String get unitMonths => 'महीने';

  @override
  String get unitWeeks => 'सप्ताह';

  @override
  String get unitDays => 'दिन';

  @override
  String get unitHours => 'घंटे';

  @override
  String get unitMinutes => 'मिनट';

  @override
  String get unitSeconds => 'सेकंड';

  @override
  String get shortDays => 'दिन';

  @override
  String get shortHours => 'घंटे';

  @override
  String get shortMins => 'मिनट';

  @override
  String get shortSecs => 'सेकंड';

  @override
  String get totalYears => 'कुल वर्ष';

  @override
  String get totalMonths => 'कुल महीने';

  @override
  String get totalWeeks => 'कुल सप्ताह';

  @override
  String get totalDays => 'कुल दिन';

  @override
  String get totalHours => 'कुल घंटे';

  @override
  String get totalMinutes => 'कुल मिनट';

  @override
  String get totalSeconds => 'कुल सेकंड';

  @override
  String get calendarUnits => 'कैलेंडर इकाइयाँ';

  @override
  String get totalPrecision => 'सटीक कुल समय';

  @override
  String get milestoneReached => 'पड़ाव पूरा हुआ! 🎉';

  @override
  String get theMomentHasArrived => 'वह खास पल आ गया है!';

  @override
  String get shareCountdown => 'काउंटडाउन साझा करें';

  @override
  String get editEvent => 'संपादित करें';

  @override
  String get deleteEvent => 'हटाएं';

  @override
  String deleteEventConfirm(String title) {
    return 'क्या आप वाकई \"$title\" को हटाना चाहते हैं?';
  }

  @override
  String get delete => 'हटाएं';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get pinned => 'पिन किया गया';

  @override
  String get unpinned => 'अनपिन किया गया';

  @override
  String get pinEvent => 'पिन करें';

  @override
  String get unpinEvent => 'अनपिन करें';

  @override
  String get eventDeleted => 'इवेंट हटा दिया गया';

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get newCountdown => 'नया काउंटडाउन';

  @override
  String get editCountdown => 'काउंटडाउन बदलें';

  @override
  String get eventTitle => 'इवेंट का नाम';

  @override
  String get titlePlaceholder => 'जैसे: क्योटो की ग्रीष्मकालीन यात्रा';

  @override
  String get selectDateTime => 'दिनांक और समय';

  @override
  String get quickDatePresets => 'त्वरित दिनांक';

  @override
  String get presetTomorrow => 'कल';

  @override
  String get presetThisWeekend => 'इस सप्ताहांत';

  @override
  String get presetOneWeek => '+1 सप्ताह';

  @override
  String get presetOneMonth => '+1 महीना';

  @override
  String get presetNewYear => 'नया साल';

  @override
  String get quickTimePresets => 'त्वरित समय';

  @override
  String get presetMorning => 'सुबह 9:00';

  @override
  String get presetNoon => 'दोपहर 12:00';

  @override
  String get presetEvening => 'शाम 6:00';

  @override
  String get presetMidnight => 'मध्यरात्रि';

  @override
  String get category => 'श्रेणी';

  @override
  String get colorAndIcon => 'रंग और प्रतीक';

  @override
  String get notesOptional => 'नोट्स (वैकल्पिक)';

  @override
  String get notesPlaceholder => 'विवरण, फ़्लाइट नंबर या यादें जोड़ें...';

  @override
  String get pinToTop => 'शीर्ष पर पिन करें';

  @override
  String get saveCountdown => 'काउंटडाउन सहेजें';

  @override
  String get updateCountdown => 'काउंटडाउन अपडेट करें';

  @override
  String get titleRequiredError => 'कृपया इवेंट का नाम दर्ज करें';

  @override
  String get emptyTitle => 'कोई काउंटडाउन नहीं है';

  @override
  String get emptySubtitle =>
      'जन्मदिन, छुट्टियां, उपलब्धियां और लक्ष्य ट्रैक करने के लिए अपना पहला काउंटडाउन बनाएं।';

  @override
  String get createCountdown => 'काउंटडाउन बनाएं';

  @override
  String get settingsAndAbout => 'सेटिंग्स और जानकारी';

  @override
  String get appearance => 'दिखावट (थीम)';

  @override
  String get themeMode => 'थीम मोड';

  @override
  String get system => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get dark => 'डार्क';

  @override
  String get light => 'लाइट';

  @override
  String get preferences => 'प्राथमिकताएं';

  @override
  String get language => 'भाषा (Language)';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get hapticFeedback => 'हैप्टिक कंपन';

  @override
  String get hapticSubtitle => 'बटन दबाने और मील के पत्थरों पर हल्का कंपन';

  @override
  String get communityAndSupport => 'समुदाय और सहायता';

  @override
  String get shareRemaini => 'Remaini साझा करें';

  @override
  String get shareSubtitle => 'अपने दोस्तों और परिवार को बताएं';

  @override
  String get rateApp => 'ऐप को रेट करें';

  @override
  String get rateSubtitle => 'गूगल प्ले स्टोर पर 5-स्टार रेटिंग दें';

  @override
  String get moreApps => 'अन्य ऐप्स';

  @override
  String get moreAppsSubtitle => 'Avenzor के अन्य ऐप्स देखें';

  @override
  String get sourceCode => 'सोर्स कोड';

  @override
  String get sourceCodeSubtitle => 'GitHub पर कोड देखें और स्टार दें';

  @override
  String get contactUs => 'संपर्क करें';

  @override
  String get contactSubtitle => 'सहायता या सुझाव के लिए संपर्क करें';

  @override
  String get aboutAndLegal => 'जानकारी और कानूनी';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get openSourceLicenses => 'ओपन सोर्स लाइसेंस';

  @override
  String get sampleDataLoader => 'नमूना डेटा और स्टोरेज';

  @override
  String get resetSampleData => 'नमूना डेटा रीसेट करें';

  @override
  String get resetSampleDataSubtitle =>
      'डिफ़ॉल्ट नमूना काउंटडाउन पुनः लोड करें';

  @override
  String get sampleDataReloaded => 'नमूना काउंटडाउन पुनः लोड किए गए!';

  @override
  String shareMessage(String url) {
    return 'Remaini ⏳ के साथ हर महत्वपूर्ण पल को ट्रैक करें — आधुनिक और सुंदर काउंटडाउन ऐप!\n\nGoogle Play पर अभी डाउनलोड करें:\n$url';
  }
}
