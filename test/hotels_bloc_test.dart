import 'package:flutter_hotel_booking_app/data/models/hotel.dart';
import 'package:flutter_hotel_booking_app/domain/repository/hotel_repository.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/hotels/hotels_bloc.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/hotels/hotels_event.dart';
import 'package:flutter_hotel_booking_app/presentation/blocs/hotels/hotels_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

// A mock implementation of HotelRepository.
class MockHotelRepository implements HotelRepository {
  @override
  Future<List<HotelElement>> fetchHotels() async {
    // Return a dummy list with one HotelElement.
    return [
      HotelElement(
        hotelId: "1",
        name: "Test Hotel",
        destination: "Test Destination",
        images: [],
        ratingInfo: RatingInfo(
          score: 4.5,
          scoreDescription: "Great",
          reviewsCount: 100,
        ),
        bestOffer: null,
      ),
    ];
  }

  @override
  // TODO: implement baseUrl
  String get baseUrl => throw UnimplementedError();
}

void main() {
  group('HotelsBloc', () {
    late HotelsBloc hotelsBloc;
    late MockHotelRepository mockHotelRepository;

    setUp(() {
      mockHotelRepository = MockHotelRepository();
      hotelsBloc = HotelsBloc(hotelRepository: mockHotelRepository);
    });

    blocTest<HotelsBloc, HotelsState>(
      'emits [HotelsLoading, HotelsLoaded] when LoadHotelsEvent is added',
      build: () => hotelsBloc,
      act: (bloc) => bloc.add(LoadHotelsEvent()),
      expect: () => [
        isA<HotelsLoading>(),
        isA<HotelsLoaded>().having((state) => state.hotels.length, 'hotels length', 1),
      ],
    );
  });
}
