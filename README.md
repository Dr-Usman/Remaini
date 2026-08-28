# Remaini ⏳

[![GitHub Stars](https://img.shields.io/github/stars/Dr-Usman/Remaini?style=social)](https://github.com/Dr-Usman/Remaini)
[![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter)](https://flutter.dev)

> **Count every moment that matters.**  
> A modern, production-ready, and minimal countdown mobile application built with Flutter.

---

## ✨ Overview

**Remaini** helps you anticipate life's most exciting moments — vacations, birthdays, product launches, anniversaries, and personal milestones. It calculates and dynamically displays remaining time down to the exact second with a sleek glassmorphic UI, live ticker animations, and urgency-based color accents.

---

## 🚀 Key Features

### 1. 🏠 Home Screen (Event Feed & Spotlight)
* **Modern Glassmorphic Cards**: Displays event title, target date, category badge, and live ticking mini-countdown.
* **Dynamic Urgency Color Accents**:
  * 🟢 **Far Away** (> 30 days): Emerald Green
  * 🟡 **Approaching** (7–30 days): Sunset Amber
  * 🔴 **Soon** (< 7 days): Vivid Coral Red
  * 🔥 **Today** (< 24 hours): Electric Flame
  * 💜 **Completed / Past**: Radiant Violet
* **Next Up Spotlight**: Hero banner at the top highlighting your nearest upcoming countdown.
* **Instant Search & Category Filters**: Search across titles, categories, and memo notes. Filter by *Personal, Work, Birthday, Holiday, Travel, Milestone, Anniversary, or Custom*.
* **Custom Sorting**: Sort by Nearest First, Furthest First, Title (A-Z), or Date Added.
* **Interactive Swipe Gestures**: Swipe left to delete (with an immediate **Undo** snackbar), swipe right to Pin/Unpin.
* **Theme Toggle**: One-tap toggle between sleek Dark mode (default) and Light mode.

### 2. ⏱️ Detail Screen (Core Showcase)
* **Dynamic 1-Second Ticker**: Continuous live-ticking countdown displaying **Years, Months, Weeks, Days, Hours, Minutes, and Seconds** with micro-slide transitions.
* **Glowing Neon Circular Progress Ring**: Custom-painted circular progress ring showing elapsed ratio vs. total event lifespan.
* **Dual Breakdown Views**:
  * **Calendar Units View**: Grid of animated ticking glass cards.
  * **Cumulative Totals View**: Total Days, Total Hours, Total Minutes, and Total Seconds remaining.
* **🎉 Milestone Celebration**: Confetti cannon explosion and celebration banner when a countdown reaches zero.
* **Social Sharing**: One-tap formatted summary to share your countdown with friends.

### 3. ➕ Add / Edit Event Screen
* **Quick Date Presets**: Instant one-tap date shortcuts (`Tomorrow`, `Weekend`, `+1 Week`, `+1 Month`, `New Year`).
* **Quick Time Presets**: Instant one-tap time shortcuts (`9:00 AM`, `12:00 PM`, `6:00 PM`, `Midnight`).
* **Category & Color Picker**: 8 built-in categories with custom icons and 10 vibrant accent swatches.
* **Notes & Pinning**: Add optional memo notes and pin important events to the top.

### 4. ⚙️ Settings & About Screen
* **Appearance Switcher**: Visual cards for Dark Mode and Light Mode.
* **Preferences**: Toggle haptic tactile feedback on/off.
* **Community & Support**: Share Remaini with friends, leave a 5-star rating, and in-app contact support dialog.
* **Data Management**: Seed sample countdowns and clear all local data with confirmation prompt.
* **Legal & Privacy**: Built-in in-app Privacy Policy (100% offline, zero tracking) and Terms of Use modals.

---

## 🛠️ Tech Stack & Architecture

* **Framework**: Flutter 3.x / Dart 3
* **State Management**: [GetX](https://pub.dev/packages/get) (`get: ^4.7.3`) — Reactive `Rx` observables, dependency injection, and clean navigation.
* **Local Storage**: [Hive CE](https://pub.dev/packages/hive_ce) (`hive_ce: ^2.19.3`, `hive_ce_flutter: ^2.3.4`) — High-performance, offline-first Community Edition key-value database for Flutter & Dart 3.
* **Typography**: Google Fonts (Outfit for bold display numbers, Plus Jakarta Sans for body text).
* **Animations**: `flutter_animate` + `confetti` + custom Flutter `CustomPainter`.

### Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart         # Dynamic urgency palettes, dark/light tokens, gradients
│   │   ├── app_typography.dart     # Google Fonts Outfit & Plus Jakarta Sans
│   │   └── app_constants.dart      # Hive box keys, presets, sort options
│   ├── theme/
│   │   ├── app_theme.dart          # Dark and Light ThemeData
│   │   └── theme_controller.dart   # GetxController for ThemeMode toggle & persistence
│   ├── utils/
│   │   ├── countdown_calculator.dart # Precision calendar arithmetic & urgency math
│   │   ├── date_formatter.dart     # Friendly relative/absolute date formatting
│   │   └── haptic_feedback.dart    # Micro-haptics helper
│   └── services/
│       └── storage_service.dart    # Hive CE storage engine & sample data seeding
├── data/
│   └── models/
│       ├── countdown_event.dart    # Primary event model with Map/JSON serialization
│       ├── event_category.dart     # Categories with icons & default colors
│       └── time_remaining.dart     # Decomposed units & UrgencyLevel enums
├── presentation/
│   ├── controllers/
│   │   ├── event_list_controller.dart     # Reactive list, filter, search, sort, pin, delete
│   │   ├── event_detail_controller.dart   # 1s ticker stream, celebration, sharing
│   │   └── add_edit_event_controller.dart # Form validation, date/time pickers & presets
│   ├── routes/
│   │   └── app_routes.dart         # GetPage transitions & lazy bindings
│   ├── widgets/
│   │   ├── common/                 # GlassContainer, GradientButton, CustomTextField, UrgencyBadge, EmptyStateView
│   │   ├── home/                   # EventCard, SearchFilterBar, StatHeader
│   │   └── detail/                 # CircularCountdownRing, TimeUnitCard, GranularBreakdownView, CelebrationOverlay
│   └── views/
│       ├── home_view.dart          # Home event feed screen
│       ├── add_edit_event_view.dart # Event creation & editor screen
│       └── event_detail_view.dart  # Live 1s ticking countdown showcase
└── main.dart                       # App entrypoint, Hive CE initialization, GetMaterialApp
```

---

## 🚦 Getting Started

### Prerequisites

* Flutter SDK (3.x or later)
* Dart SDK (3.x or later)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/remaini.git
   cd remaini
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   # Run on connected device or simulator
   flutter run

   # Or run on macOS Desktop
   flutter run -d macos

   # Or run on Chrome Web
   flutter run -d chrome
   ```

---

## 🧪 Running Tests

Run the full automated unit and widget test suite:

```bash
flutter test
```

Run static analysis check:

```bash
flutter analyze
```

---

## 📄 License & Privacy

* **License**: Licensed under the [MIT License](LICENSE) — see the [LICENSE](LICENSE) file for details.
* **Privacy Policy**: Read our full [Privacy Policy](PRIVACY_POLICY.md).

