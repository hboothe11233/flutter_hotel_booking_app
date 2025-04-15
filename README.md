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
   git clone https://github.com/yourusername/hotel_booking_app.git
   cd hotel_booking_app
