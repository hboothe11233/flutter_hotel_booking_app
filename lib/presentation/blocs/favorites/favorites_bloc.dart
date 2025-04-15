import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/hotel.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bloc to manage favorite hotels using local storage.
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  // Key used to store favorites in SharedPreferences.
  final String favoritesKey = 'favorites';

  FavoritesBloc() : super(FavoritesInitial()) {
    // Load favorites from local storage.
    on<LoadFavoritesEvent>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final favoritesJson = prefs.getStringList(favoritesKey) ?? [];
        final favoriteHotels = favoritesJson
            .map((jsonStr) => HotelElement.fromJson(jsonDecode(jsonStr)))
            .toList();
        emit(FavoritesLoaded(favoriteHotels: favoriteHotels));
      } catch (e) {
        emit(FavoritesError(message: e.toString()));
      }
    });

    // Toggle a hotel as favorite (adding it if missing, removing if already present).
    on<ToggleFavoriteEvent>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final favoritesJson = prefs.getStringList(favoritesKey) ?? [];
        List<HotelElement> favoriteHotels = favoritesJson
            .map((jsonStr) => HotelElement.fromJson(jsonDecode(jsonStr)))
            .toList();

        // Use hotelId to decide if this hotel is already favorited.
        final index = favoriteHotels
            .indexWhere((hotel) => hotel.hotelId == event.hotel.hotelId);
        if (index >= 0) {
          favoriteHotels.removeAt(index);
        } else {
          favoriteHotels.add(event.hotel);
        }

        // Save the updated list back to SharedPreferences.
        final updatedFavoritesJson = favoriteHotels
            .map((hotel) => jsonEncode(hotel.toJson()))
            .toList();
        await prefs.setStringList(favoritesKey, updatedFavoritesJson);
        emit(FavoritesLoaded(favoriteHotels: favoriteHotels));
      } catch (e) {
        emit(FavoritesError(message: e.toString()));
      }
    });
  }
}
