import 'package:equatable/equatable.dart';

/// Base class for hotel events.
abstract class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load hotels from the API.
class LoadHotelsEvent extends HotelsEvent {}
