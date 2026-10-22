# DEEN-STEP App 🌙

A modern, production-grade Islamic lifestyle and spiritual journey tracking application built with **Flutter**, following **Clean Architecture**, **Feature-First modular structure**, and strict coding guidelines (maximum 120 lines per file).

---

## 📌 Table of Contents
1. [Flutter & Dart Versions](#-flutter--dart-versions)
2. [How to Run the Project](#-how-to-run-the-project)
3. [Folder Structure Explained](#-folder-structure-explained)
4. [State Management Used](#-state-management-used)
5. [Firebase Setup & How to Switch Projects](#-firebase-setup--how-to-switch-projects)
6. [Step-by-Step Guide to Adding a New Feature](#-step-by-step-guide-to-adding-a-new-feature)
7. [API & Authentication Overview](#-api--authentication-overview)
8. [Testing & Code Quality](#-testing--code-quality)

---

## 🛠 Flutter & Dart Versions

This project is built and verified with the following SDK environment:

| Tool | Version |
|---|---|
| **Flutter SDK** | `>= 3.47.0` (Stable channel) |
| **Dart SDK** | `>= 3.13.4 < 4.0.0` |
| **Java JDK** | Java 17+ (with Java 8 Core Library Desugaring enabled for Android) |
| **Gradle** | 8.x+ (Android Gradle Plugin 8.9.0) |

---

## 🚀 How to Run the Project

### 1. Prerequisites
- Install [Flutter SDK](https://docs.flutter.dev/get-started/install).
- Set up Android Studio (Android SDK 34+, Android Build-Tools, Platform-Tools).
- For iOS: Xcode 15+ and CocoaPods (`sudo gem install cocoapods`).
- Physical device or emulator/simulator with Google Play Services enabled.

### 2. Clone the Repository
```bash
git clone https://github.com/ranasheikh64/deen-step-task.git
cd deen-step-task
```

### 3. Install Dependencies
```bash
flutter clean
flutter pub get
```

### 4. iOS Pod Installation (macOS only)
```bash
cd ios
pod install
cd ..
```

### 5. Run the Application
Connect your device or start an emulator, then run:

```bash
# Debug mode
flutter run

# Run on a specific device
flutter devices
flutter run -d <device_id>

# Release mode
flutter run --release
```

---

## 📁 Folder Structure Explained

The codebase follows **Feature-First Clean Architecture**, separating business logic, data persistence/networking, and UI into distinct layers.

```text
lib/
├── app.dart                                # Global MaterialApp & root configuration
├── main.dart                               # App entry point, Firebase init & DI setup
│
├── core/                                   # Cross-cutting foundational modules
│   ├── config/                             # AppConfig, environment variables & base URLs
│   ├── constants/                          # AssetPaths, StorageKeys, AppConstants
│   ├── di/                                 # Service locator (get_it) registrations
│   ├── error/                              # Failure & Exception classes
│   ├── network/                            # Dio client, Interceptors (Auth, Logging)
│   ├── routing/                            # GoRouter configuration & AppRoutes
│   ├── services/                           # Platform & external services
│   │   ├── auth/                           # Social login (Google, Apple) & session manager
│   │   ├── location/                       # Geolocator & GPS services
│   │   ├── notifications/                  # Firebase FCM & Local Notifications service
│   │   └── storage/                        # FlutterSecureStorage service
│   ├── theme/                              # AppColors, AppTypography, AppSpacing
│   ├── utils/                              # Validators, formatters, helpers
│   └── widgets/                            # Global design system widgets (DeenButton, DeenTextField, DeenSnackBar, Shimmer)
│
└── features/                               # Feature-First modules
    ├── auth/                               # Authentication feature (Login, Register, OTP, Social, Guest)
    │   ├── data/                           # DataSources, Models, Repository Implementations
    │   ├── domain/                         # Entities, Repositories (Contracts), UseCases
    │   └── presentation/                   # BLoC, Pages (Login, SignUp, OTP), Widgets
    │
    ├── onboarding/                         # 4-step onboarding flow with SVG backgrounds
    │   ├── presentation/                   # OnboardingBloc, OnboardingScreen
    │   └── widgets/                        # Silhouette, PageIndicator, SkipButton, ActionButtons
    │
    ├── dashboard/                          # Bottom navigation shell
    │   └── presentation/                   # DashboardScreen, DeenBottomNavigationBar
    │
    └── home/                               # Home prayer tracker & spiritual journey
        ├── data/                           # Home remote data source, models
        ├── domain/                         # Dashboard entity, location use cases
        └── presentation/                   # HomeBloc, Prayer Timeline, Shimmer, Dialogs
```

### Layer Responsibilities
- **Domain Layer (`domain/`)**: Pure Dart with zero Flutter/external framework dependencies. Contains business Entities, Repository contracts, and UseCases (`Either<Failure, T>`).
- **Data Layer (`data/`)**: Implements Repository contracts, handles serialization (Models with `fromJson`/`toJson`), and interacts with remote APIs (Dio) or local storage (SecureStorage).
- **Presentation Layer (`presentation/`)**: Manages UI state using BLoC/Cubit, responsive layouts, design tokens, and modular widgets keeping all files `<= 120` lines.

---

## ⚡ State Management Used

This project uses **BLoC (Business Logic Component)** pattern powered by `flutter_bloc`:

1. **Separation of Concerns**:
   - **Events**: Pure data classes representing user actions or system triggers (`LoginSubmitted`, `OnboardingPageChanged`, `FetchHomeDashboard`).
   - **States**: Immutable state classes representing UI states (`AuthInitial`, `AuthLoading`, `AuthSuccess`, `AuthFailureState`).
   - **Blocs**: Processes events, executes domain UseCases, and emits updated states.

2. **Dependency Injection**:
   - `get_it` service locator registers singleton and factory instances in `lib/core/di/service_locator.dart`.
   - Blocs and services are injected cleanly without tightly coupling UI components.

3. **Session & Auth State Management**:
   - `AuthSessionManager` orchestrates token storage (`access_token`, `refresh_token`), validates token expiration via `jwt_decoder`, and handles automatic refresh or logout.

---

## 🔥 Firebase Setup & How to Switch Projects

### Current Firebase Configuration
- **Active Firebase Project**: `deen-3ad74`
- **Enabled Services**:
  - Firebase Authentication (Google Sign-In, Apple Sign-In)
  - Firebase Cloud Messaging (FCM Device Tokens & Push Notifications)

### 1. Initial Setup for a New Machine
1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   firebase login
   ```
2. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

### 2. How to Switch Firebase Projects
To switch the app to a different Firebase project (e.g. `deen-production` or a staging project):

1. **Run FlutterFire Configure**:
   ```bash
   flutterfire configure --project=<your-firebase-project-id>
   ```
   Select both `android` and `ios`. This automatically generates or updates:
   - `lib/firebase_options.dart`
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

2. **Android Setup**:
   - In Firebase Console > Project Settings > General > Your Apps > Android app:
     - Verify Package Name: `com.deenApp.APP`
     - Add SHA-1 and SHA-256 fingerprints:
       ```bash
       cd android && ./gradlew signingReport
       ```
     - Copy the SHA-1 and SHA-256 keys into the Firebase Console.
   - Download the updated `google-services.json` and place it in `android/app/google-services.json`.

3. **iOS Setup**:
   - In Firebase Console > Project Settings > iOS app:
     - Verify Bundle Identifier: `com.deenApp.APP`
     - Download `GoogleService-Info.plist` and add it to `ios/Runner/` via Xcode.
     - In Xcode > Signing & Capabilities, add `Push Notifications` and `Sign in with Apple`.

4. **Authentication Sign-in Methods**:
   - Firebase Console > Authentication > Sign-in method:
     - Enable **Google** (select project support email).
     - Enable **Apple**.

---

## 🧩 Step-by-Step Guide to Adding a New Feature

Follow this standard procedure to add any new feature (e.g. `quran` or `tasbeeh`):

### Step 1: Create a Feature Branch
```bash
git checkout main
git pull origin main
git checkout -b feature/new-feature-name
```

### Step 2: Define Domain Layer
1. **Entity**: Create `lib/features/<feature>/domain/entities/<entity>.dart` (plain Dart object).
2. **Repository Contract**: Create `lib/features/<feature>/domain/repositories/<feature>_repository.dart` declaring abstract methods returning `Future<Either<Failure, T>>`.
3. **Use Case**: Create `lib/features/<feature>/domain/usecases/<action>_usecase.dart`.

### Step 3: Implement Data Layer
1. **Model**: Create `lib/features/<feature>/data/models/<model>.dart` extending the Entity with `fromJson` and `toJson`.
2. **Remote DataSource**: Create `lib/features/<feature>/data/datasources/<feature>_remote_data_source.dart` using Dio.
3. **Repository Implementation**: Create `lib/features/<feature>/data/repositories/<feature>_repository_impl.dart`.

### Step 4: Implement Presentation Layer
1. **BLoC**:
   - Event: `lib/features/<feature>/presentation/bloc/<feature>_event.dart`
   - State: `lib/features/<feature>/presentation/bloc/<feature>_state.dart`
   - Bloc: `lib/features/<feature>/presentation/bloc/<feature>_bloc.dart`
2. **Pages & Widgets**:
   - Keep each widget focused and reusable.
   - **Enforce the strict <= 120 lines rule per file**. If a page grows, extract widgets into `widgets/<component_name>.dart`.

### Step 5: Register in Service Locator
In `lib/core/di/service_locator.dart`:
```dart
// Data Source
sl.registerLazySingleton<FeatureRemoteDataSource>(...);
// Repository
sl.registerLazySingleton<FeatureRepository>(...);
// UseCase
sl.registerLazySingleton<GetFeatureUseCase>(...);
// BLoC
sl.registerFactory<FeatureBloc>(() => FeatureBloc(...));
```

### Step 6: Add Route in AppRouter
In `lib/core/routing/app_routes.dart` and `app_router.dart`:
```dart
GoRoute(
  path: AppRoutes.newFeature,
  builder: (context, state) => const NewFeatureScreen(),
)
```

### Step 7: Write Unit & Widget Tests
Create matching test files in `test/features/<feature>/`:
```bash
flutter test test/features/<feature>/
```

### Step 8: Code Quality Check & Pull Request
```bash
flutter analyze
flutter test
git add .
git commit -m "feat(<feature>): describe changes concisely"
git push -u origin feature/<feature>
gh pr create
```

---

## 🌐 API & Authentication Overview

The app connects to the Deen-Step REST backend:

- **Base URL**: `https://test.deenstep.com/api/v1`
- **Key Endpoints**:
  - `POST /auth/register/` — Register with full name, email, and password.
  - `POST /auth/login/` — Standard email & password login.
  - `POST /auth/social/login/` — Google & Apple sign-in with Firebase ID token.
  - `POST /auth/guest/login/` — Anonymous guest login keyed to device FCM token.
  - `POST /auth/logout/` — Blacklists refresh token and unregisters device.
  - `POST /auth/verify-email/` — 4-digit OTP email verification with resend countdown.
  - `GET /home/dashboard/` — Live prayer timings, current active prayer, next countdown.
  - `PATCH /home/user/location/` — Update user GPS coordinates.

---

## 🧪 Testing & Code Quality

### Static Analysis
Zero warnings or errors are permitted across the entire codebase:
```bash
flutter analyze
```

### Running Test Suite
Over 50+ unit and widget tests covering validators, use cases, BLoCs, and screens:
```bash
flutter test
```

### Style & Coding Rules
- **Strict File Limit**: Maximum 120 lines of code per Dart file.
- **Design System First**: Use `AppColors`, `AppTypography`, `AppSpacing`, and `DeenButton`.
- **Zero Raw Strings/Colors**: Colors and text styles must use tokens from `lib/core/theme/`.

---

## 📄 License
This repository is private property and developed for **DEEN-STEP**. All rights reserved.
