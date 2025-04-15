import 'package:equatable/equatable.dart';

import '../../../data/models/hotel.dart';

/// Base class for favorites states.
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

/// Initial state.
class FavoritesInitial extends FavoritesState {}

/// State when favorites have been successfully loaded.
class FavoritesLoaded extends FavoritesState {
  final List<HotelElement> favoriteHotels;
  const FavoritesLoaded({required this.favoriteHotels});

  @override
  List<Object?> get props => [favoriteHotels];
}

/// State when there is an error with favorites.
class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError({required this.message});

  @override
  List<Object?> get props => [message];
}
