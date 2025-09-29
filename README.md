# Life Pulse

Empowering charitable giving with transparency, speed, and great UX.

Life Pulse is a modern donations app that helps users discover and support verified humanitarian cases and campaigns. It offers quick, secure payments, multi-language support (Arabic/English), and a clean, intuitive UI to track impact and stay informed with timely updates.

## ✨ Features

- Discover verified cases and featured campaigns
- Quick Donation flow with preset/custom amounts
- Secure payments via multiple methods (cards and wallets)
- Donations history and wallet balance view
- Realtime notifications (Firebase Cloud Messaging)
- Full localization (ar/en) via GetX `.tr`
- Light/Dark theme support and responsive UI

## 🏗 Architecture & Tech Stack

- Flutter (Dart)
- State management, routing, and i18n: GetX
- Networking: Dio with custom interceptors
- Local storage: GetStorage (token, language, preferences)
- Notifications: Firebase Messaging + flutter_local_notifications
- UI utilities: flutter_screenutil, cached_network_image
- Others: image_picker, url_launcher, webview_flutter, country_code_picker

Key files:

- `lib/app/app.dart`: App bootstrap, locales, routing, themes
- `lib/main.dart`: Initialization (Firebase, GetStorage, orientation)
- `lib/data/network/api.dart`: API client (Dio), interceptors, error handling
- `lib/presentation/**`: Screens, controllers, widgets
- `lib/presentation/resources/strings_manager.dart`: AppStrings keys
- `lib/presentation/resources/language/en.dart`, `ar.dart`: Translations

## 🗺 Localization (i18n)

All user-facing strings are centralized in `AppStrings` and translated in `en.dart`/`ar.dart`.

- Usage in UI:
  ```dart
  Text(AppStrings.donate.tr)
  ```
- Default locale fallback: Arabic (`ar`) with English support. The app reads the stored language from `GetStorage` (`language_code`) and falls back to device locale if supported.

## 🔐 Authentication & Storage

- Tokens are cached via `TokenStorage` using `GetStorage` for fast, persistent access.
- Helper utilities live under `lib/presentation/resources/helpers/`.

## 🌐 Networking

- `Dio` configured in `Api` with base URL, timeouts, and robust error handling.
- Interceptors add headers, log requests/responses, and normalize errors for the UI.

## 📦 Getting Started

Prerequisites:

- Flutter SDK >= 3.5.0
- Dart >= 3.5.0

Install & run:

```bash
flutter pub get
flutter run
```

Build release:

```bash
flutter build apk --release
# or
flutter build ios --release
```

## 📁 Project Structure (high-level)

```
lib/
  app/                 # MyApp, routes, themes
  core/                # Core services (e.g., Firebase notifications)
  data/
    network/           # API (Dio), interceptors
  presentation/
    auth/              # Sign in/up flows
    donations_tab/     # Donations list & controllers
    home_tab/          # Home, campaigns, details
    layout/            # Tabs, bottom nav
    resources/         # styles, themes, strings, localization
    transactions_tab/  # Wallet, transactions
    widgets/           # Shared widgets
```

## 🔔 Notifications

- Firebase Messaging for push notifications.
- Local display via `flutter_local_notifications`.

## 🧪 Notes

- This is an MVP; some endpoints or flows may be mocked or simplified.
- Replace API base URL and Firebase configs as needed for production.


## 📄 License

This project is licensed under the MIT License.
