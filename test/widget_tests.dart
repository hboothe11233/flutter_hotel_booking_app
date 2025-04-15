import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_app/data/models/hotel.dart';
import 'package:flutter_hotel_booking_app/domain/repository/hotel_repository.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_state.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/hotels/hotels_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/hotels/hotels_state.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/account_screen.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/favorites_screen.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/hotels_screen.dart';
import 'package:flutter_hotel_booking_app/presentation/screens/overview_screen.dart';
import 'package:flutter_hotel_booking_app/presentation/widgets/hotel_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  // Create a dummy HotelElement for testing purposes.
  final dummyHotel = HotelElement(
    hotelId: "1",
    name: "Test Hotel",
    destination: "Test Destination",
    images: [
      ImageType(
        large: "http://example.com/test.jpg",
        small: "http://example.com/test_small.jpg",
      )
    ],
    ratingInfo: RatingInfo(
      score: 4.5,
      scoreDescription: "Excellent",
      reviewsCount: 120,
    ),
    bestOffer: BestOffer(
      travelDate: TravelDate(days: 5, nights: 4),
      rooms: Rooms(
        overall: Overall(name: "Doppelzimmer", boarding: "Frühstück"),
      ),
      total: 1500,
      simplePricePerPerson: 750,
    ),
  );

  group('HotelCard Widget Tests', () {
    testWidgets('HotelCard (favorites layout) displays hotel details and rating overlay', (WidgetTester tester) async {
      // Wrap HotelCard in a BlocProvider for FavoritesBloc.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<FavoritesBloc>(
            create: (_) => FavoritesBloc()..emit(FavoritesLoaded(favoriteHotels: [dummyHotel])),
            child: HotelCard(hotelElement: dummyHotel, showRatingInfo: true),
          ),
        ),
      );

      // Verify that the hotel name and destination are shown.
      expect(find.text("Test Hotel"), findsOneWidget);
      expect(find.text("Test Destination"), findsOneWidget);
      // Verify that the rating overlay shows the score.
      expect(find.textContaining("4.5 / 5.0"), findsOneWidget);
      // Check that the favorites icon is present.
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('HotelCard (default layout) shows full details', (WidgetTester tester) async {
      // Wrap HotelCard in a MaterialApp (FavoritesBloc is not needed for default layout).
      await tester.pumpWidget(
        MaterialApp(
          home: HotelCard(hotelElement: dummyHotel, showRatingInfo: false),
        ),
      );

      // Expect to see star icons.
      expect(find.byIcon(Icons.star), findsWidgets);
      // Verify hotel name text.
      expect(find.text("Test Hotel"), findsOneWidget);
      // Verify default CTA text.
      expect(find.text("Zu den Angeboten"), findsOneWidget);
    });
  });

  group('Screen Widget Tests', () {
    testWidgets('FavoritesScreen displays a list of favorite hotels', (WidgetTester tester) async {
      // Create a FavoritesBloc with a dummy hotel in its state.
      final favoritesBloc = FavoritesBloc();
      favoritesBloc.emit(FavoritesLoaded(favoriteHotels: [dummyHotel]));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<FavoritesBloc>.value(
            value: favoritesBloc,
            child: const FavoritesScreen(),
          ),
        ),
      );

      // Verify that a HotelCard is rendered.
      expect(find.byType(HotelCard), findsOneWidget);
    });

    testWidgets('HotelsScreen displays a list of hotels', (WidgetTester tester) async {
      // Create a dummy HotelsBloc that immediately emits HotelsLoaded.
      final hotelsBloc = HotelsBloc(hotelRepository: DummyHotelRepository());
      hotelsBloc.emit(HotelsLoaded(hotels: [dummyHotel]));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HotelsBloc>.value(
            value: hotelsBloc,
            child: const HotelsScreen(),
          ),
        ),
      );

      // Verify that a HotelCard is rendered.
      expect(find.byType(HotelCard), findsOneWidget);
    });

    testWidgets('OverviewScreen displays welcome text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const OverviewScreen()),
      );

      expect(find.text('Welcome to the Hotel Booking App!'), findsOneWidget);
    });

    testWidgets('AccountScreen displays account information', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const AccountScreen()),
      );

      expect(find.text('Account'), findsOneWidget);
      expect(find.text('User Account Information'), findsOneWidget);
    });
  });
}

/// A dummy implementation of HotelRepository for testing HotelsScreen.
class DummyHotelRepository implements HotelRepository {
  @override
  Future<List<HotelElement>> fetchHotels() async {
    return [dummyHotelForTest];
  }

  @override
  // TODO: implement baseUrl
  String get baseUrl => throw UnimplementedError();
}

/// A dummy hotel element for testing via DummyHotelRepository.
final HotelElement dummyHotelForTest = HotelElement(
  hotelId: "1",
  name: "Test Hotel",
  destination: "Test Destination",
  images: [
    ImageType(
      large: "http://example.com/test.jpg",
      small: "http://example.com/test_small.jpg",
    )
  ],
  ratingInfo: RatingInfo(
    score: 4.5,
    scoreDescription: "Excellent",
    reviewsCount: 120,
  ),
  bestOffer: BestOffer(
    travelDate: TravelDate(days: 5, nights: 4),
    rooms: Rooms(
      overall: Overall(name: "Doppelzimmer", boarding: "Frühstück"),
    ),
    total: 1500,
    simplePricePerPerson: 750,
  ),
);
