import 'package:equatable/equatable.dart';

import '../../../data/models/hotel.dart';

/// Base class for favorites events.
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load favorite hotels from local storage.
class LoadFavoritesEvent extends FavoritesEvent {}

/// Event to toggle a hotel in or out of the favorites list.
class ToggleFavoriteEvent extends FavoritesEvent {
  final HotelElement hotel;
  const ToggleFavoriteEvent({required this.hotel});

  @override
  List<Object?> get props => [hotel];
}
