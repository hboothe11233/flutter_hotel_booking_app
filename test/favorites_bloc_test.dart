import 'package:flutter_hotel_booking_app/data/models/hotel.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_event.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FavoritesBloc', () {
    late FavoritesBloc favoritesBloc;

    setUp(() async {
      // Initialize mock SharedPreferences.
      SharedPreferences.setMockInitialValues({});
      favoritesBloc = FavoritesBloc();
    });

    blocTest<FavoritesBloc, FavoritesState>(
      'emits [FavoritesLoaded] with one hotel when ToggleFavoriteEvent is added for a new favorite',
      build: () => favoritesBloc,
      act: (bloc) {
        final hotel = HotelElement(
          hotelId: "1",
          name: "Test Hotel",
          destination: "Test Destination",
          images: [],
        );
        bloc.add(ToggleFavoriteEvent(hotel: hotel));
      },
      expect: () => [
        isA<FavoritesLoaded>().having((state) => state.favoriteHotels.length, 'favorite hotels length', 1)
      ],
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'emits [FavoritesLoaded] with zero hotels when ToggleFavoriteEvent is added to remove an existing favorite',
      build: () => favoritesBloc,
      act: (bloc) async {
        final hotel = HotelElement(
          hotelId: "1",
          name: "Test Hotel",
          destination: "Test Destination",
          images: [],
        );
        bloc.add(ToggleFavoriteEvent(hotel: hotel)); // Adds the hotel.
        await Future.delayed(const Duration(milliseconds: 100)); // Allow state update.
        bloc.add(ToggleFavoriteEvent(hotel: hotel)); // Toggle off.
      },
      // Skip the first emission if necessary.
      skip: 1,
      expect: () => [
        isA<FavoritesLoaded>().having((state) => state.favoriteHotels.length, 'favorite hotels length', 0)
      ],
    );
  });
}
