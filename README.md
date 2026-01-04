# Movie Study Case App

A production-grade Flutter application demonstrating advanced UI/UX, A/B testing, and robust DevOps practices.

## 🚀 Features

### 🎬 Interactive Onboarding
- **Genre Selection**: Users can choose their favorite movie genres with a smooth, engaging UI.
- **Movie Selection**: An infinite, curved 3D carousel (`InfiniteCurvedCarousel`) lets users pick their top movies.
- **Zero-Latency Transitions**: Optimized image preloading logic ensures images appear instantly without loading spinners.

### 💰 Smart Paywall & A/B Testing
- **Dynamic A/B Testing**: The app randomly assigns users to different Paywall variants (Variant A vs. Variant B) to test different layouts and pricing models.
- **Variant A**: Features a detailed feature comparison table with animated checkmarks and dynamic styling.
- **Variant B**: Features a simplified, high-conversion layout.
- **Remote Config Integration**: Built to easily plug into Firebase Remote Config for real-time experiment control.

### 🏠 Immersive Home Screen
- **Category Feed**: Vertically scrollable feed with horizontal movie lists for each selected genre.
- **Scroll Synchronization**: The genre chips at the top automatically sync with the vertical scroll position.
- **Tap-to-Scroll**: Tapping a genre chip instantly smooth-scrolls to that specific category.

### ⚡ Performance & Polish
- **Responsive Design**: Pixel-perfect layout across all screen sizes using `flutter_screenutil`.
- **3D Animations**: Custom `MeshCurvedImage` and custom shaders for premium visual effects.
- **Optimized Caching**: Smart caching strategies for TMDB API limits and memory usage.

## 🛠 Tech Stack & Architecture

This project follows **Clean Architecture** principles to ensure scalability, testability, and separation of concerns.

- **State Management**: [MobX](https://pub.dev/packages/mobx) for reactive, clean, and testable state management.
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) & [Injectable](https://pub.dev/packages/injectable) for loosely coupled components.
- **Architecture**:
  - `Domain Layer`: Entities, Use Cases, Repository Interfaces (Pure Dart).
  - `Data Layer`: Repository Implementations, API Services, DTOs.
  - `Presentation Layer`: UI Widgets, MobX Stores.
- **Networking**: [Dio](https://pub.dev/packages/dio) for robust HTTP requests.
- **UI Utils**: `flutter_screenutil` for responsiveness, `cached_network_image` for image handling.

## 🏗 Build Flavors & Environments

This project uses **Build Flavors** to separate Development, Staging, and Production environments, each with distinct apps and icons.

### Flavors Configuration

| Environment | Flavor Name | Entry Point          | App ID Suffix | App Name        |
|-------------|-------------|----------------------|---------------|-----------------|
| Development | `dev`       | `lib/main_dev.dart`  | `.dev`        | Movie App Dev   |
| Staging     | `staging`   | `lib/main_staging.dart`| `.stg`      | Movie App Stg   |
| Production  | `prod`      | `lib/main_prod.dart` | (none)        | Movie App       |

### Running the App

To run the app in a specific environment:

```bash
# Development (Green Icon)
flutter run --flavor dev -t lib/main_dev.dart

# Staging (Red Icon)
flutter run --flavor staging -t lib/main_staging.dart

# Production (Blue Icon)
flutter run --flavor prod -t lib/main_prod.dart
```

### App Icons
Distinct icons are configured for each environment to prevent accidental mix-ups:
- `android/app/src/dev/res/`: Contains Dev icons.
- `android/app/src/staging/res/`: Contains Staging icons.
- `android/app/src/main/res/`: Contains Production icons.

## 🚀 CI/CD & DevOps

The project is configured for automated build pipelines (GitHub Actions, Codemagic, etc.).

### Build Commands
Use strict flavor and entry-point definition for builds:

```bash
# Build Development APK
flutter build apk --flavor dev -t lib/main_dev.dart

# Build Production AppBundle
flutter build appbundle --flavor prod -t lib/main_prod.dart
```

### Environment Management
- The app uses `flutter_dotenv` to load environment variables.
- **Security Note**: Never commit `.env` files. In CI/CD, inject these secrets into a file or environment variables during the build process.

## 📂 Project Structure

```
lib/
├── config/             # AppConfig, Theme, Routes, Environment
├── core/               # Constants, Extensions, Services (Preloader, RemoteConfig)
├── data/               # API Services, Models, Repositories Impl
├── domain/             # Entities, Use Cases, Repository Interfaces
├── presentation/       # Screens, Widgets, MobX Stores
│   ├── screens/
│   │   ├── home/
│   │   ├── onboarding/
│   │   ├── paywall/
│   │   └── splash/
│   └── widgets/        # Reusable UI components
├── main.dart           # Common main delegate
├── main_dev.dart       # Dev entry point
├── main_staging.dart   # Staging entry point
└── main_prod.dart      # Prod entry point
```

## 🏁 Getting Started

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/movie-study-case.git
    ```

2.  **Get Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Generate Code (MobX/Injectable)**:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the App**:
    ```bash
    flutter run --flavor dev -t lib/main_dev.dart
    ```
