<div align="center">

# 💳 GazaPay

**A modern, Arabic-first mobile payment application built with Flutter**

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.11+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-6.x-7B68EE?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-informational?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</div>

---

## 📖 Project Overview

**GazaPay** is a Flutter-based mobile payment application designed specifically for users in Palestine. It provides a clean, RTL (right-to-left) Arabic interface for secure account management and authentication. The app communicates with a dedicated REST API backend (`gazapay-api.onrender.com`) and supports the full authentication lifecycle — from registration and login to PIN recovery.

The project is an early-stage fintech MVP focusing on a smooth, trustworthy user experience with a native Arabic feel, using the **Tajawal** font family and phone number validation for both `+970` and `+972` country codes.

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.x (Dart SDK ^3.11.0) |
| **State Management** | Provider 6.x (`ChangeNotifier`) |
| **HTTP Client** | `http` package 1.6.0 |
| **SVG Rendering** | `flutter_svg` 2.2.3 |
| **UI Enhancements** | `smooth_page_indicator` 2.0.1 |
| **Localization** | `flutter_localizations` (Arabic RTL) |
| **Fonts** | Tajawal (Regular & Bold) |
| **Linting** | `flutter_lints` 6.0.0 |
| **Testing** | `flutter_test` SDK |
| **Backend API** | REST API hosted on Render |

---

## 🏗️ Architecture

GazaPay follows a clean **MVVM-inspired layered architecture** with a clear separation of concerns across four main layers:

```
┌─────────────────────────────────────────────┐
│                   View Layer                │
│     (Screens, Widgets, UI Components)       │
├─────────────────────────────────────────────┤
│                Provider Layer               │
│   (ChangeNotifier — Business Logic/State)   │
├─────────────────────────────────────────────┤
│               Repository Layer              │
│      (UserRepository — Data Abstraction)    │
├─────────────────────────────────────────────┤
│                 Core / Helper               │
│  (ApiBaseHelper, ApiResponse, Exceptions)   │
└─────────────────────────────────────────────┘
                        │
                        ▼
              REST API (gazapay-api)
```

**Key architectural decisions:**

- **`ApiResponse<T>`** — A generic wrapper with `LOADING`, `COMPLETED`, and `ERROR` states, enabling reactive UI updates throughout the app.
- **`ApiBaseHelper`** — A centralized HTTP client handling GET, POST, PUT, DELETE requests with consistent error mapping (400, 401, 403, 404, 409, 500).
- **Custom Exception Classes** — Typed exceptions (`BadRequestException`, `UnauthorisedException`, `ConflictException`, etc.) for clean error propagation.
- **Named Routes** — All screens are registered with static `id` constants and navigated via `Navigator.pushNamed`.

---

## ✨ Features

### 🔐 Authentication
- **User Registration** — Create an account with name, phone number, and a 6-digit PIN. Includes real-time validation with confirm-PIN matching.
- **User Login** — Secure login via phone number and PIN, with JWT access token handling.
- **Forgot PIN Flow** — A smooth 3-step wizard:
  1. Enter phone number → receive OTP via SMS
  2. Verify OTP code (3-minute expiry countdown)
  3. Create a new PIN

### 🌍 Localization & RTL
- Full **Arabic (RTL)** language support via `flutter_localizations`
- Palestinian phone number validation for both `+970` and `+972` prefixes
- **Tajawal** Arabic font for a native, polished typographic experience

### 🎨 UI/UX
- Custom `PrimaryButton` with built-in loading spinner state
- Reusable `CustomTextField` with SVG prefix/suffix icons and styled border states (default, focused, error)
- Custom OTP input field (`OtpField`) for verification code entry
- `SuccessDialog` shown on successful PIN change with direct navigation to Login
- `SmoothPageIndicator` for the forgot-PIN step wizard
- Decorative auth screen background shapes

### 🏠 Home Screen
- Post-login landing screen with a logout action

---

## 🧪 Testing

The project includes a basic widget test scaffold in `test/widget_test.dart`. The test verifies that the root `MyApp` widget renders correctly.

```bash
# Run all tests
flutter test

# Run with verbose output
flutter test --reporter expanded
```

> **Note:** The current test suite is a smoke test placeholder. Expanding it with unit tests for Providers and integration tests for API flows is recommended (see Future Improvements).

---

## 📁 Folder Structure

```
gazapay/
├── assets/
│   ├── fonts/
│   │   ├── Tajawal-Regular.ttf
│   │   └── Tajawal-Bold.ttf
│   ├── icons/              # SVG icons (lock, phone, app icon, success)
│   └── images/             # Background images (auth screen shape)
│
├── lib/
│   ├── main.dart           # App entry point, routing & MultiProvider setup
│   │
│   ├── Core/
│   │   ├── Helper/
│   │   │   ├── api_base_helper.dart   # HTTP client (GET, POST, PUT, DELETE)
│   │   │   ├── api_response.dart      # Generic ApiResponse<T> state wrapper
│   │   │   └── app_exceptions.dart    # Typed exception classes
│   │   └── Util/
│   │       ├── constants.dart         # Colors, base URL, style constants
│   │       └── assets.dart            # Asset path constants
│   │
│   ├── Model/
│   │   ├── user.dart                  # User model with JSON serialization
│   │   └── login_response.dart        # Login response (access token) model
│   │
│   ├── Repo/
│   │   └── user_repository.dart       # Auth API calls (register, login, reset PIN)
│   │
│   ├── Provider/
│   │   ├── register_provider.dart     # Registration state & logic
│   │   ├── login_provider.dart        # Login state & logic
│   │   └── forgot_pin_provider.dart   # Forgot PIN multi-step state & logic
│   │
│   ├── View/
│   │   ├── Auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   ├── forgot_pin_screen.dart
│   │   │   └── Forgot Pin Steps/
│   │   │       ├── step_enter_phone.dart
│   │   │       ├── step_verify_code.dart
│   │   │       └── step_create_pin.dart
│   │   └── Home/
│   │       └── home_screen.dart
│   │
│   └── Widgets/
│       ├── custom_text_filed.dart     # Reusable styled text input
│       ├── primary_button.dart        # Reusable CTA button with loading state
│       ├── logo_with_title.dart       # App logo + title widget
│       ├── forgot_pin_header.dart     # Back button header for forgot PIN flow
│       ├── otp_field.dart             # OTP input widget
│       └── success_dialog.dart        # Post-reset success dialog
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml
└── analysis_options.yaml
```

---

## 🚀 How to Run the Project

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (^3.11.0)
- Dart SDK (^3.11.0)
- Android Studio or VS Code with Flutter extension
- A connected device or emulator

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/your-username/gazapay.git
cd gazapay

# 2. Install dependencies
flutter pub get

# 3. Verify your environment
flutter doctor

# 4. Run the app
flutter run
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# iOS (macOS required)
flutter build ios --release
```

> **Backend:** The app connects to `https://gazapay-api.onrender.com`. No local backend setup is required — the API is already deployed and publicly accessible.

---

## 🔮 Future Improvements

Here are the planned enhancements for upcoming versions:

- [ ] **Secure Token Storage** — Replace in-memory token handling with `flutter_secure_storage` for persistent, encrypted JWT storage.
- [ ] **Biometric Authentication** — Add fingerprint / Face ID login support via `local_auth`.
- [ ] **Transaction Dashboard** — Build out the Home Screen with balance display, transaction history, and transfer capabilities.
- [ ] **OTP Timer** — Implement a live countdown timer for the 3-minute OTP expiry with a functional "Resend" button.
- [ ] **Dark Mode** — Add a dark theme toggle respecting system preferences.
- [ ] **Unit & Integration Tests** — Expand the test suite with Provider unit tests and API integration tests using `mockito`.
- [ ] **Accessibility** — Add semantic labels and screen reader support for visually impaired users.
- [ ] **Push Notifications** — Integrate Firebase Cloud Messaging for transaction alerts.
- [ ] **Multi-language Support** — Extend localization to support English alongside Arabic.
- [ ] **CI/CD Pipeline** — Set up GitHub Actions for automated testing and build workflows.

---

## 📸 Screenshots

> _Screenshots will be added here once the UI is finalized. Below is a placeholder layout:_

| Login Screen | Register Screen | Forgot PIN |
|:---:|:---:|:---:|
| `coming soon` | `coming soon` | `coming soon` |

| OTP Verification | New PIN | Home Screen |
|:---:|:---:|:---:|
| `coming soon` | `coming soon` | `coming soon` |

---

## 🌐 Social Links

<div align="center">

[![GitHub](https://img.shields.io/badge/GitHub-your--username-181717?style=for-the-badge&logo=github)](https://github.com/your-username)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/your-profile)
[![Twitter](https://img.shields.io/badge/Twitter-Follow-1DA1F2?style=for-the-badge&logo=twitter)](https://twitter.com/your-handle)
[![Email](https://img.shields.io/badge/Email-Contact-D14836?style=for-the-badge&logo=gmail)](mailto:your@email.com)

</div>

---

<div align="center">

Made with ❤️ for Gaza — Built with Flutter

</div>
