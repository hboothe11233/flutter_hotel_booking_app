import 'package:flutter_hotel_booking_app/data/models/hotel.dart';
import 'package:flutter_hotel_booking_app/domain/repository/hotel_repository.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_event.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/favorites/favorites_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Update these imports to match your project structure.

void main() {
  // Create a dummy HotelElement with all required fields.
  final dummyHotel = HotelElement(
    hotelId: "1",
    name: "Test Hotel",
    destination: "Test Destination",
    // Provide a non-empty list for images.
    images: [
      ImageType(
        large: "http://example.com/test.jpg",
        small: "http://example.com/test_small.jpg",
      )
    ],
    // Provide a valid categoryType.
    categoryType: CategoryType.DOTS,
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
          // Provide non-empty image list and a valid categoryType.
          images: [],
          categoryType: CategoryType.DOTS,
        );
        bloc.add(ToggleFavoriteEvent(hotel: hotel));
      },
      expect: () => [
        isA<FavoritesLoaded>().having(
              (state) => state.favoriteHotels.length,
          'favorite hotels length',
          1,
        )
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
          images: [
            ImageType(
              large: "http://example.com/test.jpg",
              small: "http://example.com/test_small.jpg",
            )
          ],
          categoryType: CategoryType.DOTS,
        );
        bloc.add(ToggleFavoriteEvent(hotel: hotel)); // Add hotel.
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(ToggleFavoriteEvent(hotel: hotel)); // Remove hotel.
      },
      skip: 1,
      expect: () => [
        isA<FavoritesLoaded>().having(
              (state) => state.favoriteHotels.length,
          'favorite hotels length',
          0,
        )
      ],
    );
  });

}

/// Dummy implementation of HotelRepository for HotelsScreen tests.
class DummyHotelRepository implements HotelRepository {
  @override
  Future<List<HotelElement>> fetchHotels() async {
    return [dummyHotelForTest];
  }

  @override
  // TODO: implement baseUrl
  String get baseUrl => throw UnimplementedError();
}

/// Dummy hotel element for DummyHotelRepository.
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
  categoryType: CategoryType.DOTS,
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

