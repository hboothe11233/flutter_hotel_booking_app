import 'package:equatable/equatable.dart';

import '../../../data/models/hotel.dart';

/// Base class for hotel states.
abstract class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object?> get props => [];
}

/// Initial state.
class HotelsInitial extends HotelsState {}

/// State while hotels are being loaded.
class HotelsLoading extends HotelsState {}

/// State when hotels are loaded successfully.
class HotelsLoaded extends HotelsState {
  final List<HotelElement> hotels;
  const HotelsLoaded({required this.hotels});

  @override
  List<Object?> get props => [hotels];
}

/// State when there is an error loading hotels.
class HotelsError extends HotelsState {
  final String message;
  const HotelsError({required this.message});

  @override
  List<Object?> get props => [message];
}
