// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Remaini';

  @override
  String get appTagline => 'Chaque instant compte';

  @override
  String get nextUp => 'À VENIR';

  @override
  String get noUpcomingEvents => 'Aucun événement à venir';

  @override
  String get tapPlusToCreate =>
      'Appuyez sur + pour créer votre premier compte à rebours';

  @override
  String get searchHint => 'Rechercher des comptes à rebours...';

  @override
  String get categoryAll => 'Tous';

  @override
  String get categoryPersonal => 'Personnel';

  @override
  String get categoryWork => 'Travail';

  @override
  String get categoryBirthday => 'Anniversaire';

  @override
  String get categoryHoliday => 'Vacances';

  @override
  String get categoryTravel => 'Voyage';

  @override
  String get categoryMilestone => 'Étape clé';

  @override
  String get categoryAnniversary => 'Fête';

  @override
  String get sortNearest => 'Plus proches d\'abord';

  @override
  String get sortFurthest => 'Plus lointains d\'abord';

  @override
  String get sortTitleAz => 'Titre (A-Z)';

  @override
  String get sortDateCreated => 'Date d\'ajout';

  @override
  String get noMatchingCountdowns => 'Aucun compte à rebours trouvé';

  @override
  String get adjustSearchOrFilter =>
      'Essayez de modifier votre recherche ou le filtre de catégorie.';

  @override
  String get urgencyFarAway => 'Lointain';

  @override
  String get urgencyApproaching => 'Approche';

  @override
  String get urgencySoon => 'Bientôt';

  @override
  String get urgencyToday => 'Aujourd\'hui';

  @override
  String get urgencyCompleted => 'Terminé';

  @override
  String get urgencyOverdue => 'Échu';

  @override
  String get unitYears => 'Ans';

  @override
  String get unitMonths => 'Mois';

  @override
  String get unitWeeks => 'Semaines';

  @override
  String get unitDays => 'Jours';

  @override
  String get unitHours => 'Heures';

  @override
  String get unitMinutes => 'Minutes';

  @override
  String get unitSeconds => 'Secondes';

  @override
  String get shortDays => 'Jours';

  @override
  String get shortHours => 'Heures';

  @override
  String get shortMins => 'Mins';

  @override
  String get shortSecs => 'Secs';

  @override
  String get totalYears => 'Total d\'années';

  @override
  String get totalMonths => 'Total de mois';

  @override
  String get totalWeeks => 'Total de semaines';

  @override
  String get totalDays => 'Total de jours';

  @override
  String get totalHours => 'Total d\'heures';

  @override
  String get totalMinutes => 'Total de minutes';

  @override
  String get totalSeconds => 'Total de secondes';

  @override
  String get calendarUnits => 'Unités calendaires';

  @override
  String get totalPrecision => 'Précision totale';

  @override
  String get milestoneReached => 'Étape franchie ! 🎉';

  @override
  String get theMomentHasArrived => 'Le moment est arrivé !';

  @override
  String get shareCountdown => 'Partager le compte à rebours';

  @override
  String get editEvent => 'Modifier l\'événement';

  @override
  String get deleteEvent => 'Supprimer l\'événement';

  @override
  String deleteEventConfirm(String title) {
    return 'Voulez-vous vraiment supprimer « $title » ?';
  }

  @override
  String get delete => 'Supprimer';

  @override
  String get cancel => 'Annuler';

  @override
  String get pinned => 'Épinglé';

  @override
  String get unpinned => 'Désépinglé';

  @override
  String get pinEvent => 'Épingler l\'événement';

  @override
  String get unpinEvent => 'Désépingler l\'événement';

  @override
  String get eventDeleted => 'Événement supprimé';

  @override
  String get undo => 'Annuler';

  @override
  String get newCountdown => 'Nouveau compte à rebours';

  @override
  String get editCountdown => 'Modifier le compte à rebours';

  @override
  String get eventTitle => 'Titre de l\'événement';

  @override
  String get titlePlaceholder => 'ex. Voyage estival à Kyoto';

  @override
  String get selectDateTime => 'Date et heure';

  @override
  String get quickDatePresets => 'Dates rapides';

  @override
  String get presetTomorrow => 'Demain';

  @override
  String get presetThisWeekend => 'Ce week-end';

  @override
  String get presetOneWeek => '+1 Semaine';

  @override
  String get presetOneMonth => '+1 Mois';

  @override
  String get presetNewYear => 'Nouvel An';

  @override
  String get quickTimePresets => 'Heures rapides';

  @override
  String get presetMorning => '9h00';

  @override
  String get presetNoon => '12h00';

  @override
  String get presetEvening => '18h00';

  @override
  String get presetMidnight => 'Minuit';

  @override
  String get category => 'Catégorie';

  @override
  String get colorAndIcon => 'Couleur et icône';

  @override
  String get notesOptional => 'Notes (facultatif)';

  @override
  String get notesPlaceholder =>
      'Ajoutez des précisions, numéros de vol ou souvenirs...';

  @override
  String get pinToTop => 'Épingler en haut de la liste';

  @override
  String get saveCountdown => 'Enregistrer le compte à rebours';

  @override
  String get updateCountdown => 'Mettre à jour le compte à rebours';

  @override
  String get titleRequiredError => 'Veuillez entrer un titre d\'événement';

  @override
  String get emptyTitle => 'Pas encore de compte à rebours';

  @override
  String get emptySubtitle =>
      'Créez votre premier compte à rebours pour suivre anniversaires, vacances, projets et objectifs.';

  @override
  String get createCountdown => 'Créer un compte à rebours';

  @override
  String get settingsAndAbout => 'Paramètres & À propos';

  @override
  String get appearance => 'APPARENCE';

  @override
  String get themeMode => 'Mode de thème';

  @override
  String get system => 'Système';

  @override
  String get dark => 'Sombre';

  @override
  String get light => 'Clair';

  @override
  String get preferences => 'PRÉFÉRENCES';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get hapticFeedback => 'Retour haptique';

  @override
  String get hapticSubtitle => 'Vibrations lors des actions et des jalons';

  @override
  String get communityAndSupport => 'COMMUNAUTÉ & SUPPORT';

  @override
  String get shareRemaini => 'Partager Remaini';

  @override
  String get shareSubtitle => 'Faites-en profiter vos amis et proches';

  @override
  String get rateApp => 'Noter l\'application';

  @override
  String get rateSubtitle => 'Laissez 5 étoiles sur Google Play';

  @override
  String get moreApps => 'Plus d\'applications';

  @override
  String get moreAppsSubtitle => 'Découvrez d\'autres applications par Avenzor';

  @override
  String get sourceCode => 'Code source';

  @override
  String get sourceCodeSubtitle =>
      'Consulter le dépôt et donner une étoile sur GitHub';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get contactSubtitle => 'Support d\'aide ou retours d\'expérience';

  @override
  String get aboutAndLegal => 'À PROPOS & LÉGAL';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get openSourceLicenses => 'Licences open source';

  @override
  String get sampleDataLoader => 'DONNÉES D\'EXEMPLE & STOCKAGE';

  @override
  String get resetSampleData => 'Réinitialiser les exemples';

  @override
  String get resetSampleDataSubtitle =>
      'Recharger les comptes à rebours par défaut';

  @override
  String get sampleDataReloaded => 'Comptes à rebours d\'exemple rechargés !';

  @override
  String shareMessage(String url) {
    return 'Suivez chaque moment qui compte avec Remaini ⏳ — L\'application de compte à rebours moderne et soignée !\n\nTéléchargez-la sur Google Play :\n$url';
  }
}
