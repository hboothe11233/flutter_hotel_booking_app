import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/hotels/hotels_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/hotels/hotels_event.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/account_screen.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/favorites_screen.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/hotels_screen.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/overview_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'domain/repository/hotel_repository.dart';
import 'presentation/blocs/favorites/favorites_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final List<Widget> _tabs = const [
    OverviewScreen(),
    HotelsScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          HotelsBloc(hotelRepository: HotelRepository())..add(LoadHotelsEvent()),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc()..add(LoadFavoritesEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Hotel Booking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // Global AppBarTheme: blue background, white centered titles.
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff002873),
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          // Global BottomNavigationBarTheme: customize as needed.
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
          ),
        ),
        // Localization configuration.
        localizationsDelegates: const [
          AppLocalizations.delegate, // Generated localization delegate.
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('de', ''),
          // Add additional supported locales here.
        ],
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    OverviewScreen(),
    HotelsScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Retrieve localized titles via AppLocalizations.
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: localizations.overviewTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: localizations.searchTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              label: localizations.favoritesTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              label: localizations.accountTab,
            ),
          ],
        ),
      ),
    );
  }
}