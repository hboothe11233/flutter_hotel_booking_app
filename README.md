# Hotel Booking App

This Flutter app is a sample hotel booking application developed as part of an interview process. The app demonstrates modern Flutter practices including state management using BLoC, navigation with auto_route for tab-based navigation, and localization support for multiple languages (English and German).

## Features

- **Bottom Navigation:**  
  Four main tabs: Overview, Hotels, Favorites, and Account. Navigation is handled by the auto_route package.

- **State Management:**  
  The app uses the BLoC pattern for managing business logic. There are separate blocs for loading hotels (HotelsBloc) and managing favorite hotels (FavoritesBloc).

- **Data Layer:**  
  Hotel data is fetched from a provided API via the `HotelRepository`. Models are defined to parse and serialize JSON data.

- **Localization:**  
  The app supports multiple languages using Flutter's localization framework. ARB files (e.g., `app_en.arb` and `app_de.arb`) provide localized strings, and the app is configured with global localization delegates.

- **Theming:**  
  Global theming is applied through `ThemeData` to ensure consistent styling. All AppBars use a blue background with white, centered titles. The BottomNavigationBar includes a top border for visual separation.

- **Navigation (auto_route):**  
  The app uses the auto_route package to manage tab-based navigation. The MainTabScreen is defined with child routes for Overview, Hotels, Favorites, and Account.

- **Testing:**  
  Unit tests for BLoC business logic and widget tests for UI components ensure the app is reliable and maintainable.

## Architecture

The project is organized into the following layers:

- **Data Layer:**  
  Contains model classes (e.g., `Hotel`, `HotelElement`, etc.) and the repository (`HotelRepository`) responsible for fetching hotel data from the API.

- **Presentation Layer:**  
  Includes screens (OverviewScreen, HotelsScreen, FavoritesScreen, AccountScreen), widgets (HotelCard), and BLoC implementations (HotelsBloc and FavoritesBloc). Navigation is handled using the auto_route package.

- **Domain Layer:**  
  (Optional in this project) Could host business logic independent of UI details if the project scales further.

## Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/hboothe11233/hotel_booking_app.git
   cd hotel_booking_app
   
2. **Install Dependencies**
   Run the following command in your project root to install all required packages:
   flutter pub get

3. **Generate Localization Files**
   Ensure you have ARB files in the l10n directory (for example, app_en.arb and app_de.arb). Then run:
   flutter gen-l10n
   This will generate the localization files (by default, l10n/app_localizations.dart) to be used by your app.

[//]: # (4. **Generate AutoRoute Files**)

[//]: # (   The app uses the auto_route package for navigation. Run:)

[//]: # (   flutter pub run build_runner build)

[//]: # (   This command generates the necessary routing files &#40;for example, app_router.gr.dart&#41;.)

5. **Run the App**
   Start the app with the following command:
   flutter run

## Running Tests

Unit tests and widget tests validate business logic and UI behavior. To run all tests:
flutter test

# Global Theme and Localization

- Global Theme:
    - The AppBar has a blue background (Color(0xff002873)) and white, centered titles. 
    - The BottomNavigationBar has a top border for separation.
- Localization:
    - The app uses Flutter's localization framework. Localization delegates and supported locales are set in MaterialApp.router.
    - ARB files (e.g., app_en.arb, app_de.arb) provide localized strings that are accessed via the generated AppLocalizations class.
  

# AutoRoute Navigation

[//]: # (The auto_route package is used for tab-based navigation. The navigation structure includes:)

[//]: # ()
[//]: # (- app_router.dart:)

[//]: # (  Defines auto_route configuration with a MainTabScreen and child routes for Overview, Hotels, Favorites, and Account.)

[//]: # (- main_tab_screen.dart:)

[//]: # (  Implements tab-based navigation using AutoTabsRouter.tabBar, including a BottomNavigationBar that automatically updates the active tab.)

[//]: # (- main.dart:)

[//]: # (  Configures MaterialApp.router with the auto_route router, supplies global BLoCs, applies localization, and global theming.)


# BLoC Overview

- HotelsBloc:
  Manages fetching hotel data from the repository and responds to events like LoadHotelsEvent by emitting states such as HotelsLoading, HotelsLoaded, or HotelsError.
- FavoritesBloc:
  Manages the list of favorite hotels using local storage (via SharedPreferences). It handles events like LoadFavoritesEvent and ToggleFavoriteEvent, and emits states like FavoritesLoaded or FavoritesError.