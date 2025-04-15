import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/hotel_repository.dart';
import 'hotels_event.dart';
import 'hotels_state.dart';

/// Bloc handling the loading of hotels.
class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final HotelRepository hotelRepository;
  HotelsBloc({required this.hotelRepository}) : super(HotelsInitial()) {
    on<LoadHotelsEvent>((event, emit) async {
      emit(HotelsLoading());
      try {
        final hotels = await hotelRepository.fetchHotels();
        emit(HotelsLoaded(hotels: hotels));
      } catch (e) {
        emit(HotelsError(message: e.toString()));
      }
    });
  }
}
