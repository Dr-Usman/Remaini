# Changelog

All notable changes to **Remaini** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [1.1.0] - 2026-10-02

### Added
- **Multi-Language Localization**: Full translation support across the application for 5 new languages: Spanish (Español), German (Deutsch), French (Français), Hindi (हिन्दी), and Bengali (বাংলা), alongside default English.
- **In-App Language Switcher**: Added an interactive Language selector under Preferences in Settings with country flags and instant real-time UI switching.
- **More Apps Discovery**: Added developer showcase tile in Settings linking directly to the Avenzor Google Play developer catalog.

### Changed
- **CI Workflows**: Upgraded GitHub Actions to latest runner actions (`checkout@v7`, `setup-java@v6`, `action-gh-release@v3`).
- **UI Enhancements**: Wrapped settings dialog tiles in Material widgets for smoother ripple animations and strict framework assertion compliance.
- **App Rating**: Replaced `in_app_review` with direct `url_launcher` store intents to eliminate KGP warnings and streamline native dependencies.

---

## [1.0.1] - 2026-09-03

### Added
- **Smart Adaptive Totals**: Added Total Years and Total Months (with 1-decimal precision) and Total Weeks (whole numbers) to the granular totals breakdown view.

---

## [1.0.0] - 2026-08-31

### 🎉 Initial Release

#### Added
- **🏠 Smart Event Feed & Spotlight**:
  - Hero "Next Up" Spotlight card highlighting the nearest event.
  - Dynamic urgency color badges (*Far Away*, *Approaching*, *Soon*, *Today*, *Completed*).
  - Instant category filter chips (*Personal, Work, Birthday, Holiday, Travel, Milestone, Anniversary*).
  - Search across event titles, categories, and memo notes.
  - Custom sort options (*Nearest First, Furthest First, Title A-Z, Date Added*).
  - Interactive swipe gestures (swipe left to delete with undo, swipe right to pin/unpin).

- **⏱️ Precision Live Countdown Showcase**:
  - Continuous 1-second live ticker stream with animated digit transitions.
  - Custom-painted glowing neon circular countdown progress ring.
  - Dual breakdown view switcher: **Calendar Units** (*Weeks, Days, Hours, Mins, Secs*) and **Cumulative Totals** (*Total Days, Hours, Minutes, Seconds*).
  - Milestone celebration screen with confetti cannon explosion on zero.
  - One-tap social sharing with formatted countdown summary.

- **➕ Event Creation & Editor**:
  - One-tap quick date presets (`Tomorrow`, `Weekend`, `+1 Week`, `+1 Month`, `New Year`).
  - One-tap quick time presets (`9:00 AM`, `12:00 PM`, `6:00 PM`, `Midnight`).
  - 8 category icons and 10 vibrant color swatches.
  - Optional memo notes and event pinning.

- **⚙️ Settings & Preferences**:
  - Appearance selector for **System**, **Dark Mode**, and **Light Mode**.
  - Tactile haptic feedback toggle.
  - In-app sample data loader and storage management.
  - In-app Privacy Policy modal (100% offline, zero data tracking).
